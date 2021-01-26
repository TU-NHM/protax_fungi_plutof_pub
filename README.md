# protax_fungi_plutof
EOSC-Nordic service preparations (PROTAX-fungi)

## Setup

### Pre-requisites

* OPTIONAL: [Singularity](https://sylabs.io/singularity/) - install Singularity (needed to create new singularity container)
* OPTIONAL: [VSEARCH](https://github.com/torognes/vsearch) - download VSEARCH binary, place it in the folder protaxfungi/thirdparty/ named as vsearch (needed to update supporting files)

### Setup steps

1. OPTIONAL: Create Singularity Image File (SIF)
	```console
	sudo singularity build protax_fungi.sif protax_fungi_plutof.def
	```

2. OPTIONAL: Copy SIF to HPC
	```console
	scp protax_fungi.sif example_hpc_user@example.com:
	```

3. Run setup bash script (downloads singularity container and supporting data files, creates input and output data directories)
    ```console
    ./run_setup.sh
    ```

4. OPTIONAL: prepare updated supporting data files (udb) needed by PROTAX-fungi (location of these files should be in the db_files/ folder)
	```console
	wget https://github.com/torognes/vsearch/releases/download/v2.15.1/vsearch-2.15.1-linux-x86_64.tar.gz
	tar xzf vsearch-2.15.1-linux-x86_64.tar.gz
	rm vsearch-2.15.1-linux-x86_64.tar.gz
	wget https://files.plutof.ut.ee/public/orig/A9/11/A911815A6691B3F74EACA42A20605CEB680424F01553E65D1EF3A6767BBCA22B.zip
	unzip A911815A6691B3F74EACA42A20605CEB680424F01553E65D1EF3A6767BBCA22B.zip
	rm A911815A6691B3F74EACA42A20605CEB680424F01553E65D1EF3A6767BBCA22B.zip
    ./vsearch-2.15.1-linux-x86_64/bin/vsearch -makeudb_usearch db_files/its1.fa -output db_files/its1.udb
    ./vsearch-2.15.1-linux-x86_64/bin/vsearch -makeudb_usearch db_files/its2.fa -output db_files/its2.udb
    ./vsearch-2.15.1-linux-x86_64/bin/vsearch -makeudb_usearch db_files/itsfull.fa -output db_files/itsfull.udb
    ./vsearch-2.15.1-linux-x86_64/bin/vsearch -makeudb_usearch db_files/sintaxits1train.fa -output db_files/sintaxits1.udb
    ./vsearch-2.15.1-linux-x86_64/bin/vsearch -makeudb_usearch db_files/sintaxits2train.fa -output db_files/sintaxits2.udb
    ./vsearch-2.15.1-linux-x86_64/bin/vsearch -makeudb_usearch db_files/sintaxitsfulltrain.fa -output db_files/sintaxitsfull.udb
    ```

## PROTAX-fungi: running the analysis (OPTIONAL: This could be done through sbatch slurm scripts)

**NB! The script expects input files in FASTA format, named as source_[run_id] and placed in indata/ directory.**

5. Run PROTAX-fungi using SIF (example data with run_id=11)
	```console
	./protax_fungi.sif /run_protax_plutof.sh 11 itsfull 90
	```
