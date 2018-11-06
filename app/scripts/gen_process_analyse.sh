#!/bin/sh
app=$1

blocks=$2
size=$3
procs=$4

nbhosts=$5
nbnodes=$6

machine=$7

rf="~/results.csv"

echo "
echo -n \"$machine;$nbhosts;$nbnodes;$app;$blocks;$size;$procs;\" >> $rf
echo -n \$(date +%Y%m%d-%H%M%S) >> $rf

. scripts/check_clear run1/exec_log

echo -n \";\$nbWorker;\$tmpGen;\$totGen;\$tmpNoG;\$totNoG;\" >> $rf

if [ -f run1_results.pack ]
then
	echo -n true >> $rf
else
	echo -n false >> $rf
fi

echo \";\$nbTask\" >> $rf
"

