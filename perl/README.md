# ensembl assembly mapping using perl api

For details of the perl API used here, click this link, http://asia.ensembl.org/info/docs/api/core/core_tutorial.html
# Converts coordinates from GRCh38 to GRCh37 and vice-verca
# Requirements:
If you don't have perl installed, please install

    I've tested this against perl 5(v5.30.0)

# Installation [to install in other os except ubuntu please see the details in the link given below]
The first step for working with the Perl APIs is to install the APIs and ensure your PERL5LIB environment variable is set up correctly.
Click this link (http://asia.ensembl.org/info/docs/api/api_installation.html) for details. You need to have mysqlal, DBD:: mysql, DBI, JSON, JSON::XS perl module installed.
To install mysql see details from the below link.
    
    https://dev.mysql.com/doc/refman/8.0/en/installing.html

Or type if you use ubuntu

    sudo apt install mysql-client-core-8.0

For mysql_config

    sudo apt-get install libmysqlclient-dev 

To install other Perl modules and ensemble dependencies.
    
    chmod +x installation.sh
    ./installation.sh

It will download and extract all the neccessary files in home/src directory.please change the directory name to something else if you don't want it to be src. If any error occurs please download and install the modules one by one from the script file.

You need to set up your environment:

You have to tell Perl where to find the modules you just installed. You can see which shell you're using by typing
    
    echo $SHELL
In my case, it is something like.

    /bin/zsh

Put this at the end of sh derived shell file. If you don't have sh derived shell then check the link to see details. Check whether the files in the src folder have the same name or not.

    PERL5LIB=${HOME}/src/bioperl-1.6.924:${PERL5LIB}
    PERL5LIB=${HOME}/src/ensembl/modules:${PERL5LIB}
    PERL5LIB=${HOME}/src/ensembl-compara/modules:${PERL5LIB}
    PERL5LIB=${HOME}/src/ensembl-variation/modules:${PERL5LIB}
    PERL5LIB=${HOME}/src/ensembl-funcgen/modules:${PERL5LIB}
    export PERL5LIB

Now type you shell file instead of zshrc

    . ~/.zshrc
Type the bellow command, you'll see the modules path
    
    echo $PERL5LIB

To check everything is installed successfully, ping ensemble. You may need to access this as a root user. It'll take some waiting. 

    cd ~/src/ensembl/misc-scripts
    ./ping_ensembl.pl

If it says "nstallation is good. Connection to Ensembl works and you can query the human core database"
then you're good to go.
# Description
This will show you the details arguments that you need to pass.
    
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
# Example:

You can copy paste the below line in the terminal to see the output.

    perl assembly_mapping.pl --chromosome 10 --start 25000 --end 30000

You can see the converted result in the output. Also if you open the data.json or whatever name you've given, data will also be there.
