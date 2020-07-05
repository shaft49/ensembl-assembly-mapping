# ensembl assembly mapping using python and rest api

For details of the rest API used here, click this link, http://rest.ensembl.org/documentation/info/assembly_map
# Converts coordinates from GRCh38 to GRCh37 and vice-verca
# Requirements:
If you don't have python installed, please install
    python 3.x
I've tested this against python 3.8.0

install the prerequisites from requirements.txt. If you don't have pip installed, install it by typing the below command in the terminal.
    
    sudo apt install python3-pip
   
If you have pip installed, then use the below command to install requirements.
        
    pip3 install -r requirements.txt

# Description
This will show you the details arguments that you need to pass.
    
    usage: assembly_mapping.py [-h] [-s SPECIES] [-a1 ASM_ONE] [-a2 ASM_TWO] -c CHROMOSOME -st START -en END [-f FILE_NAME] [-str strand]

    
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

    python3 assembly_mapping.py --chromosome 10 --start 25000 --end 30000

You can see the converted result in the output. Also if you open the data.json or whatever name you've given, data will also be there.
