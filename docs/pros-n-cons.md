# Pros and Cons

I've found two different ways to retrive converted coordinates on chromosome using the latest human data from Ensembl release.

# Using Perl API

All the data created by Ensembl are stored in MySQL relation databases.
Using the PERL API decribed in this link http://asia.ensembl.org/info/docs/api/core/core_tutorial.htmlUsing  one can connect to the database and retrive necessary information.

# pros

    1. Once connected to the datbase, retiriveing data is very fast. This method is helpful when we need to do multiple queries.

# cons

    1. Take a lot of time to connect to the database. One can specify the port number to make it faster. But I've only found port 3337 to work with the GRCh37 assembly. I didn't found any information regarding GRCh38 assembly.


    2. Need to install a lot of perl modules and also the perl api.

    3. Specific to perl programming language.

***

# Using REST API

Same information can be retireved using rest api provided by ensembl http://rest.ensembl.org/

# pros

    1. Faster retrieval method.
    2. Has support for multiple languages.

# cons

    1. If the number of query gets higher then one need to make a lot of request, which is not feasible.

