#!/bin/bash

# running the script - ./run_protax_plutof.sh <run_id> <its> <percent>

if [ -z "$1" ]
    then
        echo "No run_id argument supplied!"
        exit
fi

if [ -z "$2" ]
    then
        echo "No ITS argument supplied!"
        exit
fi

if [ -z "$3" ]
    then
        echo "No percent argument supplied!"
        exit
fi

if [ "$2" != "its1" ] && [ "$2" != "its2" ] && [ "$2" != "itsfull" ]
    then
        echo "ERROR: ITS must be either its1, its2, or itsfull (was '$2')"
        exit
fi

re="^[0-9]+$"
if ! [[ $3 =~ $re ]]
    then
        echo "ERROR: Percent must be a number (was '$3')"
fi

# get vars
run_id=$1
its=$2
percent=$3

# get working directory
pwd=$(pwd)
user_dir="$pwd/userdir/$run_id"

echo "Start"

echo "Starting new analysis in $user_dir"

# rm (if exists) user working dir and create as new
if [ -d "$user_dir" ]
  then
      rm -fr "$user_dir"
fi
mkdir "$user_dir"

export PATH=$PATH:/krona/bin

# copy indata to user's workdir
cp "$pwd/indata/source_$run_id" "$user_dir/query.fa"

# start protax analysis
source /run_protax.sh "$run_id" "$its" "$percent"

echo "Run has finished"
