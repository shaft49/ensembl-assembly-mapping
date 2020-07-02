#!/bin/bash
cd ~
mkdir src
cd src
wget ftp://ftp.ensembl.org/pub/ensembl-api.tar.gz
wget https://cpan.metacpan.org/authors/id/C/CJ/CJFIELDS/BioPerl-1.6.924.tar.gz
wget https://cpan.metacpan.org/authors/id/I/IS/ISHIGAKI/JSON-4.02.tar.gz
tar zxvf ensembl-api.tar.gz
tar zxvf BioPerl-1.6.924.tar.gz