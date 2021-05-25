#!/bin/bash

# create input and output data directories for PROTAX-fungi (unless exist)
echo "Creating input and output directories for PROTAX-fungi ..."
mkdir -p indata
mkdir -p userdir
mkdir -p outdata

# Download protax_fungi.sif
echo "Downloading PROTAX-fungi singularity container from https://plutof.ut.ee/#/filerepository/view/4357089 ..."
wget https://files.plutof.ut.ee/public/orig/C1/FF/C1FF323AD11189B32D423506EC4E55403BF2DC84AEBF0703E7E78DBE7024C891
mv C1FF323AD11189B32D423506EC4E55403BF2DC84AEBF0703E7E78DBE7024C891 protax.sif
chmod 755 protax.sif

echo "Removing old db files ..."
rm -fr db_files/

echo "Downloading PROTAX-fungi supporting files from https://plutof.ut.ee/#/filerepository/view/4357033 ..."
wget https://files.plutof.ut.ee/public/orig/F5/B1/F5B1921D065CCEBD4E646300CC9D5B8D67045A9948E6E6910378EF00DD6F7B1F.zip
unzip F5B1921D065CCEBD4E646300CC9D5B8D67045A9948E6E6910378EF00DD6F7B1F.zip
rm F5B1921D065CCEBD4E646300CC9D5B8D67045A9948E6E6910378EF00DD6F7B1F.zip

# Download db_files (1 & 2)
echo "Downloading PROTAX-fungi supporting files (1) from https://plutof.ut.ee/#/filerepository/view/4357078 ..."
wget https://files.plutof.ut.ee/public/orig/18/3C/183CA4119F32835273A28F765568DFCCC2302CAC246F14D1306DD2B9C4A753F8.zip
echo "Downloading PROTAX-fungi supporting files (2) from https://plutof.ut.ee/#/filerepository/view/4357077 ..."
wget https://files.plutof.ut.ee/public/orig/99/26/99265DB6F4D71CD7D8A96C974BB69B71B714A53DE218225073BB88D6810B5ECB.zip

mv 183CA4119F32835273A28F765568DFCCC2302CAC246F14D1306DD2B9C4A753F8.zip db_files/
mv 99265DB6F4D71CD7D8A96C974BB69B71B714A53DE218225073BB88D6810B5ECB.zip db_files/

cd db_files/

unzip 183CA4119F32835273A28F765568DFCCC2302CAC246F14D1306DD2B9C4A753F8.zip
rm 183CA4119F32835273A28F765568DFCCC2302CAC246F14D1306DD2B9C4A753F8.zip

unzip 99265DB6F4D71CD7D8A96C974BB69B71B714A53DE218225073BB88D6810B5ECB.zip
rm 99265DB6F4D71CD7D8A96C974BB69B71B714A53DE218225073BB88D6810B5ECB.zip

# end here
echo "Done"
