#!/bin/bash
cd ~
mkdir src
cd src
sudo apt update -y
sudo apt upgrade -y
sudo wget ftp://ftp.ensembl.org/pub/ensembl-api.tar.gz
sudo wget https://cpan.metacpan.org/authors/id/C/CJ/CJFIELDS/BioPerl-1.6.924.tar.gz
tar zxvf ensembl-api.tar.gz
tar zxvf BioPerl-1.6.924.tar.gz
mv BioPerl-1.6.924/ bioperl-1.6.924

# json
cd ~
mkdir perl-module-downloads
cd perl-module-downloads
sudo wget https://cpan.metacpan.org/authors/id/I/IS/ISHIGAKI/JSON-4.02.tar.gz
tar zxvf JSON-4.02.tar.gz
cd JSON-4.02
perl Makefile.PL
sudo make
sudo make install
cd ..
#JSON::XS
cpan install JSON::XS
cd ..

# Devel::CheckLib
sudo wget https://cpan.metacpan.org/authors/id/M/MA/MATTN/Devel-CheckLib-1.14.tar.gz
tar zxvf Devel-CheckLib-1.14.tar.gz
cd Devel-CheckLib-1.14
perl Makefile.PL
sudo make
sudo make install
cd ..

#DBI
sudo wget https://cpan.metacpan.org/authors/id/T/TI/TIMB/DBI-1.643.tar.gz
tar zxvf DBI-1.643.tar.gz
cd DBI-1.643
perl Makefile.PL
sudo make
sudo make install
cd ..

#DBD
sudo wget https://cpan.metacpan.org/authors/id/D/DV/DVEEDEN/DBD-mysql-4.050.tar.gz
tar zxvf DBD-mysql-4.050.tar.gz
cd DBD-mysql-4.050
perl Makefile.PL
sudo make
sudo make install
cd ..

