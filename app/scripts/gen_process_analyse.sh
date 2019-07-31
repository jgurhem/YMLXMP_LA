#!/bin/sh
app=$1

blocks=$2
size=$3
procs=$4

nbhosts=$5
nbnodes=$6

machine=$7

rf=$8


d=$(find . -maxdepth 1 -type d -name 'run*' | xargs ls -dt | head -n 1)

file=$d/exec_log
nbWorker=$(grep pid=* $file | cut -d '(' -f2 | sort | uniq -c | wc -l)
tmpGen=$(grep -E 'start *|end *' $file -A 1 | grep -e '(' | cut -d '(' -f2 | tr -d ')' | awk '{x[NR]=$1}END{asort(x);print x[NR]-x[1]}')
totGen=$(grep elasped* $file | grep time: | cut -d ' ' -f3 | awk '{s+=$1} END {print s}')
tmpNoG=$(grep -v ^host $file | sed -E '/genMat|fillMatrixZero|genVect/,+9d' | grep -E 'start *|end *' -A 1 | grep -e '(' | cut -d '(' -f2 | tr -d ')' | awk '{x[NR]=$1}END{asort(x);print x[NR]-x[1]}')
totNoG=$(grep -v ^host $file | sed -E '/genMat|fillMatrixZero|genVect/,+9d' | grep elasped* | grep time: | cut -d ' ' -f3 | awk '{s+=$1} END {print s}')
nbTask=$(grep -c SUCCESS $file)

let datasize=blocks*size
date=$(date +%Y%m%d-%H%M%S)
success="false"
if [ -f "$d"_results.pack ]
then
        success="true"
fi

{
#echo "$machine;$nbhosts;$nbnodes;$app;$blocks;$size;$procs;$date;$nbWorker;$tmpGen;$totGen;$tmpNoG;$totNoG;$success;$nbTask"
cat << EOF
{"machine":"$machine",\
"nb_cores":"$nbhosts",\
"nb_nodes":"$nbnodes",\
"test":"$app",\
"lang":"YML+XMP",\
"nb_blocks":"$blocks",\
"blocksize":"$size",\
"datasize":"$datasize",\
"nb_proc_per_task":"$procs",\
"date":"$date",\
"nbWorker":"$nbWorker",\
"tmpGen":"$tmpGen",\
"totGen":"$totGen",\
"time_calc":"$tmpNoG",\
"totNoG":"$totNoG",\
"success":"$success",\
"nbTask":"$nbTask",\
"runfolder":"$d"}
EOF
} | tee -a $rf

