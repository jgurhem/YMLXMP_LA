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

file=run1/exec_log
nbWorker=\$(grep pid=* \$file | cut -d '(' -f2 | sort | uniq -c | wc -l)
tmpGen=\$(grep -E 'start *|end *' \$file -A 1 | grep -e '(' | cut -d '(' -f2 | tr -d ')' | awk '{x[NR]=\$1}END{asort(x);print x[NR]-x[1]}')
totGen=\$(grep elasped* \$file | grep time: | cut -d ' ' -f3 | awk '{s+=\$1} END {print s}')
tmpNoG=\$(grep -v ^host \$file | sed -E '/genMat|fillMatrixZero|genVect/,+9d' | grep -E 'start *|end *' -A 1 | grep -e '(' | cut -d '(' -f2 | tr -d ')' | awk '{x[NR]=\$1}END{asort(x);print x[NR]-x[1]}')
totNoG=\$(grep -v ^host \$file | sed -E '/genMat|fillMatrixZero|genVect/,+9d' | grep elasped* | grep time: | cut -d ' ' -f3 | awk '{s+=\$1} END {print s}')
nbTask=\$(grep -c SUCCESS \$file)

echo -n \";\$nbWorker;\$tmpGen;\$totGen;\$tmpNoG;\$totNoG;\" >> $rf

if [ -f run1_results.pack ]
then
	echo -n true >> $rf
else
	echo -n false >> $rf
fi

echo \";\$nbTask\" >> $rf
"

