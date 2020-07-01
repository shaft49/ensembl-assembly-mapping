use strict;
use warnings;
use diagnostics;
use Getopt::Long;
use Bio::EnsEMBL::Registry;

sub get_help_message {
  my $message = <<"END";
    usage: assembly_mapping.pl [-h] [-s SPECIES] [-a1 ASM_ONE] [-a2 ASM_TWO] -c CHROMOSOME -st START -en END [-f FILE_NAME] [-str STRAND]
    help:
    -h, --help            show this help message and exit
    arguments:
    -c CHROMOSOME, --chromosome CHROMOSOME
                            Name of the chromosome [1-22] X Y.
    -st START, --start START
                            Start point for that chromosome.
    -en END, --end END    End point for that chromosome.
    optional arguments;
    -s SPECIES, --species SPECIES
                            Species name/alias, default value is human
    -a1 ASM_ONE, --asm_one ASM_ONE
                            Version of the input assembly, default value is GRCh38
    -a2 ASM_TWO, --asm_two ASM_TWO
                            Version of the output assembly, default value is GRCh37
    -f FILE_NAME, --file_name FILE_NAME
                            Dumps Json data in the given given file, default file_name is data.json
    -str STRAND, --strand STRAND
                            Value of strand, Default value is 1.
END
    return $message;
}

sub get_argumets {
    my ($chromosome, $start, $end);
    my ($species, $asm_one, $asm_two, $file_name, $strand) = ('Human', 'GRCh38', 'GRCh37', 'data.json', '1');
    my $help_message = get_help_message();

    GetOptions(
        'species|s=s' => \$species,
        'asm_one|a1=s' => \$asm_one,
        'asm_two|a2=s' => \$asm_two,
        'chromosome|c=s' => \$chromosome,
        'start|st=i' => \$start,
        'end|en=i' => \$end,
        'file_name|f=s' => \$file_name,
        'strand|str=s' => \$strand,
        'h|help!'
        )
    or die($help_message);

    if (!defined $chromosome || !defined $start || !defined $end) {
        say $help_message
    }

    printf("This script will run against this data
          species: $species, asm_one: $asm_one, asm_two: $asm_two,chromosome: $chromosome start: $start, end: $end, file_name: $file_name, strand: $strand\n");
    return $chromosome, $start, $end, $species, $asm_one, $asm_two, $file_name, $strand;
}

sub connect_to_db {
  printf("[INFO] Connecting to EnsEMBL::Registry...\n");
  my $registry = 'Bio::EnsEMBL::Registry';
  $registry->load_registry_from_db(
      -host => 'ensembldb.ensembl.org',
      -user => 'anonymous',
  );
  printf("[INFO] DB Connection Successful\n");
  return $registry;
}

sub show_data_mappings {
    my ($registry, $chromosome, $start, $end, $species, $asm_one, $asm_two, $file_name, $strand) = @_;
    my $slice_adaptor = $registry->get_adaptor($species, 'Core', 'Slice');
    my $old_slice = $slice_adaptor->fetch_by_region( 'chromosome', $chromosome, $start, $end, $strand, $asm_one);

    # The method coord_system() returns a Bio::EnsEMBL::CoordSystem object
    my $old_coord_sys  = $old_slice->coord_system()->name();
    my $old_seq_region = $old_slice->seq_region_name();
    my $old_start      = $old_slice->start();
    my $old_end        = $old_slice->end();
    my $old_strand     = $old_slice->strand();
    my $old_version    = $old_slice->coord_system()->version();

    my $projection = $old_slice->project('chromosome', $asm_two);

    printf("[INFO] We display the old slice info followed by a comma and then the new\n");
    
    foreach my $segment (@{$projection}) {
        printf( "%s:%s:%s:%d:%d:%d,%s\n",
              $old_coord_sys,
              $old_version,
              $old_seq_region,
              $old_start + $segment->from_start() - 1,
              $old_start + $segment->from_end() - 1,
              $old_strand,
              $segment->to_Slice()->name() );
    }
}

unless(caller) {
  printf("[INFO] Perl Script for assembly mapping\n");
  my ($chromosome, $start, $end, $species, $asm_one, $asm_two, $file_name, $strand) = get_argumets();
  my $registry = connect_to_db();
  show_data_mappings($registry, $chromosome, $start, $end, $species, $asm_one, $asm_two, $file_name, $strand);

  printf("[INFO] End of Perl Script\n");
}