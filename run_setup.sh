#!/bin/bash

# create input and output data directories for PROTAX-fungi (unless exist)
echo "Creating input and output directories for PROTAX-fungi ..."
mkdir -p indata
mkdir -p userdir
mkdir -p outdata

# Download protax_fungi.sif
echo "Downloading PROTAX-fungi singularity container from https://plutof.ut.ee/#/filerepository/view/3576198 ..."
wget https://files.plutof.ut.ee/public/orig/D2/5E/D25EE5C0C740F63887125FD05F1B3E91C9573B67CDD5C226EC7E4CF6AF70B52A
mv D25EE5C0C740F63887125FD05F1B3E91C9573B67CDD5C226EC7E4CF6AF70B52A protax.sif
chmod 755 protax.sif

echo "Removing old db files ..."
rm -fr db_files/

echo "Downloading PROTAX-fungi supporting files from https://plutof.ut.ee/#/filerepository/view/3576293 ..."
wget https://files.plutof.ut.ee/public/orig/A9/11/A911815A6691B3F74EACA42A20605CEB680424F01553E65D1EF3A6767BBCA22B.zip
unzip A911815A6691B3F74EACA42A20605CEB680424F01553E65D1EF3A6767BBCA22B.zip
rm A911815A6691B3F74EACA42A20605CEB680424F01553E65D1EF3A6767BBCA22B.zip

# Download db_files (1 & 2)
echo "Downloading PROTAX-fungi supporting files (1) from https://plutof.ut.ee/#/filerepository/view/3576316 ..."
wget https://files.plutof.ut.ee/public/orig/20/8B/208B5BC9D1CA59BB63A9A1C41D627D14B7A4CA83C5A35BAC9A99013A01C29235.zip
echo "Downloading PROTAX-fungi supporting files (2) from https://plutof.ut.ee/#/filerepository/view/3576321 ..."
wget https://files.plutof.ut.ee/public/orig/47/F6/47F6D794C3168BFA4F26855D6853359FC3AEFB32D374441312D6C1BFFE432E7A.zip

mv 208B5BC9D1CA59BB63A9A1C41D627D14B7A4CA83C5A35BAC9A99013A01C29235.zip db_files/
mv 47F6D794C3168BFA4F26855D6853359FC3AEFB32D374441312D6C1BFFE432E7A.zip db_files/

cd db_files/

unzip 208B5BC9D1CA59BB63A9A1C41D627D14B7A4CA83C5A35BAC9A99013A01C29235.zip
rm 208B5BC9D1CA59BB63A9A1C41D627D14B7A4CA83C5A35BAC9A99013A01C29235.zip

unzip 47F6D794C3168BFA4F26855D6853359FC3AEFB32D374441312D6C1BFFE432E7A.zip
rm 47F6D794C3168BFA4F26855D6853359FC3AEFB32D374441312D6C1BFFE432E7A.zip

# end here
echo "Done"