#!/bin/sh
array=( blockLU gaussJordan_inv blockGaussJordan blockGauss blockLUsolveLS )
app=$1

blocks=$2
size=$3
procs=$4

nbhosts=$5
nbnodes=$6

machine=$7

rf="~/results.csv"

echo "
rm -r run*/data

echo -n \"$machine;$nbhosts;$nbnodes;$app;$blocks;$size;$procs;\" >> $rf
echo -n \$(date) >> $rf

. scripts/check_clear run1/exec_log

echo -n \";\$nbWorker;\$tmpGen;\$totGen;\$tmpNoG;\$totNoG;\" >> $rf

if [ -f run1_results.pack ]
then
	echo -n true >> $rf
else
	echo -n false >> $rf
fi

echo \";\$nbTask\" >> $rf

mkdir -p ~/res_campaign/$app
nb=\$[\$(ls ~/res_campaign/$app/$blocks-$size-$procs* | wc -l)+1]
tar -cvf ~/res_campaign/$app/$blocks-$size-$procs---\$nb.tar.gz run* out-run-$app.*

rm -r run*
rm out-run-$app*
rm core.*

if [ \$(cat todo | wc -l) != 0 ]
then
        \$(head -n 1 todo)
        sed -i '1d' todo
fi
"

