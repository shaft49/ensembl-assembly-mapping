use strict;
use warnings;
use diagnostics;

use feature 'say';
use lib 'lib';
use Getopt::Long;

# This is perl 5, version 18, subversion 4 (v5.18.4)
use Bio::EnsEMBL::Registry;

my $registry = 'Bio::EnsEMBL::Registry';

$registry->load_registry_from_db(
  -host => 'ensembldb.ensembl.org',
  -user => 'anonymous',
);

my ($chromosome, $start, $end);
my ($species, $asm_one, $asm_two, $file_name, $strand) = ('human', 'GRCh38', 'GRCh37', 'data.json', '1');
my $help = <<"END";
usage: assembly_mapping.pl [-h] [-s SPECIES] [-a1 ASM_ONE] [-a2 ASM_TWO] -c CHROMOSOME -st START -en END [-f FILE_NAME]
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
END

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
or die($help);
if (!defined $chromosome || !defined $start || !defined $end) {
    say $help
}
say $chromosome;


my $slice_adaptor = $registry->get_adaptor( 'Human', 'Core', 'Slice' );
my $old_slice = $slice_adaptor->fetch_by_region( 'chromosome', $chromosome, $start, $end, $strand, $asm_one );

# The method coord_system() returns a Bio::EnsEMBL::CoordSystem object
my $old_coord_sys  = $old_slice->coord_system()->name();
my $old_seq_region = $old_slice->seq_region_name();
my $old_start      = $old_slice->start();
my $old_end        = $old_slice->end();
my $old_strand     = $old_slice->strand();
my $old_version  = $old_slice->coord_system()->version();

print "Slice: $old_coord_sys $old_seq_region $old_start-$old_end ($old_strand)\n";
printf( "# %s\n", $old_slice->name() );
# Project the old slice to the current assembly and display
  # information about each resulting segment.
  foreach my $segment ( @{ $old_slice->project('chromosome', $asm_two) } ) {
    # We display the old slice info followed by a comma and then the new
    # slice (segment) info.
    printf( "%s:%s:%s:%d:%d:%d,%s\n",
            $old_coord_sys,
            $old_version,
            $old_seq_region,
            $old_start + $segment->from_start() - 1,
            $old_start + $segment->from_end() - 1,
            $old_strand,
            $segment->to_Slice()->name() );
  }
  print("\n")