# ensembl assembly mapping using python and rest api

For details of the rest API used here, click this link, http://rest.ensembl.org/documentation/info/assembly_map
# Converts coordinates from GRCh38 to GRCh37 and vice-verca
# Requirements:
If you don't have python installed, please install
    python 3.x
I've tested this against python 3.8.0

install the prerequisites from requirements.txt, If you have pip installed, then use the below command
        
    pip3 install -r requirements.txt

# Description
This will show you the details arguments that you need to pass.
    
    usage: assembly_mapping.py [-h] -c CHROMOSOME -s START -e END

    arguments:
    -h, --help            show this help message and exit
    -c CHROMOSOME, --chromosome CHROMOSOME
                            Name of the chromosome [1-22] X Y.
    -s START, --start START
                            Start point for that chromosome.
    -e END, --end END     End point for that chromosome.
        
# Example:

You can copy paste the below line in the terminal to see the output. You can change the chromosome, start and end.

    python3 assembly_mapping.py --chromosome 10 --start 25000 --end 30000