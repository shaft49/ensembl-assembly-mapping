# ensembl-grch38-to-grch37
Ensembl Software Developer Pre Screening Test
For details of the rest API used here, go to this link,
    http://rest.ensembl.org/documentation/info/assembly_map
# Converts coordinates from GRCh38 to GRCh37
# REQUIREMENTS:
    python 3.x
install the prerequisites from requirements.txt, If you have pip installed, then use the below command
        
    pip3 install -r requirements.txt

# RUN:
    python3 convert_coordinates.py -h
This will show you the details arguments that you need to pass.
    
For example, you can copy paste the below line in the terminal to see the output. You can change the chromosome, start and end.

    python3 convert_coordinates.py --chromosome 10 --start 25000 --end 30000