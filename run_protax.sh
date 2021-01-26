# 1) user creates $ODIR and copies input sequence 'query.fa' there before running this script
# 2) Shell variable ITS needs to be defined to be either its1, its2, or itsfull. It defines the model and reference sequences to be used.

# get working directory
PWD=$(pwd)

RUNID=$1
ITS=$2
PERCENT=$3

ODIR="$PWD/userdir/$RUNID"
INSEQ=$ODIR/query.fa
THRESHOLD=$PERCENT/100

if [ ! -e $INSEQ ]; then
 echo "ERROR: query.fa not in ODIR ($ODIR)"
 return 1
fi

if [ "$ITS" != "its1" ] && [ "$ITS" != "its2" ] && [ "$ITS" != "itsfull" ]; then
 echo "ERROR: ITS must be either its1, its2, or itsfull (was '$ITS')"
 return 1
fi


PROTAXDIR=/protaxfungi
PROTAX=$PROTAXDIR/protaxscripts
MDIR="$PWD/db_files"
THIRDPARTY=$PROTAXDIR/thirdparty


SIMFILE1=$ODIR/query.m8
OUTSINTAX=$ODIR/query.sintax
SIMFILE2=$ODIR/query.sasintax

grep '^>' $INSEQ | cut -c2- > $ODIR/query.ids

$THIRDPARTY/vsearch -usearch_global $INSEQ -db $MDIR/${ITS}.udb -id 0.75 -maxaccepts 1000 -strand both -userfields query+target+id -userout $SIMFILE1
$THIRDPARTY/vsearch -sintax $INSEQ -db $MDIR/sintax${ITS}.udb -tabbedout $OUTSINTAX -strand both

perl $PROTAX/sintax2sa.pl $MDIR/taxonomy.ascii7 $OUTSINTAX > $SIMFILE2

grep '^>' $INSEQ | cut -c2- > $ODIR/query.ids

perl $PROTAX/testsample2init.pl 1 $ODIR/query.ids > $ODIR/query1.logprob

# parent probs from previous level classification
for LEVEL in 2 3 4 5 6 7
do
 echo "LEVEL $LEVEL"
 PREVLEVEL=$((LEVEL-1))
 IFILE=$ODIR/query${PREVLEVEL}.logprob
 OFILE=$ODIR/query${LEVEL}.logprob
 perl $PROTAX/classify.pl "$IFILE" $MDIR/tax$LEVEL $MDIR/ref.tax$LEVEL $MDIR/rseqs$LEVEL $MDIR/params.${ITS}.level${LEVEL} $SIMFILE1 $SIMFILE2  0 .01 $OFILE 0
done

######### Krona

perl $PROTAX/fastalensize.pl $INSEQ > $ODIR/query.lensize
# if sequences do not represent clusters, clustersize file (text file with lines: seqid clustersize) can be replaced by '-'

perl $PROTAX/protaxlogprob2kronaxml.pl $THRESHOLD Fungi $MDIR/taxonomy $ODIR/query.lensize $ODIR/query[1,2,3,4,5,6,7].logprob > $ODIR/krona.xml

# export PATH=$PATH:$PROTAX/thirdparty/krona/bin
$THIRDPARTY/krona/bin/ktImportXML -o "$ODIR"/krona.html "$ODIR"/krona.xml

###################
# .logprob files contain list of node ids and logprobs, convert node ids to taxonomic names and logprobs to probs
# NOTE: for final output, we can add information from best matching reference sequences etc., this is just example

for LEVEL in 2 3 4 5 6 7
do
 perl $PROTAX/nameprob.pl $MDIR/taxonomy $ODIR/query${LEVEL}.logprob > $ODIR/query${LEVEL}.nameprob
done

INFILE="source_$RUNID"
cp $PROTAXDIR/README.txt "$ODIR"

#zip "$INFILE.zip" README.txt krona.html krona.xml query2.logprob query3.logprob query4.logprob query5.logprob query6.logprob query7.logprob query.fa query.lensize query.sasintax query2.nameprob query3.nameprob query4.nameprob query5.nameprob query6.nameprob query7.nameprob query.ids query.m8 query.sintax
pushd "$PWD/userdir/"
zip "../outdata/$INFILE.zip" "$ODIR"/*
popd
