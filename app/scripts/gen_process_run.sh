#!/bin/sh
array=( blockLU gaussJordan_inv blockGaussJordan blockGauss blockLUsolveLS )
test=$1

blocks=$2
size=$3
procs=$4
dis1=$5
dis2=$6

nbhosts=$7
nbnodes=$8

echo "
rm -r run*/data

echo \" 


=================================================================
(h$nbhosts  n$nbnodes)  $test   $blocks   $size    $procs
=================================================================
\" >> results
date >> results

. scripts/check_clear run1/exec_log >> results

sleep 2

echo \"\" >> results
ls *results.pack >> results

if [ ! -d ~/res_campaign ]
then
        mkdir ~/res_campaign
fi

if [ ! -d ~/res_campaign/$test ]
then
	mkdir ~/res_campaign/$test
fi

nb=\$[\$(ls ~/res_campaign/$test/$blocks-$size-$procs* | wc -l)+1]

tar -cvf ~/res_campaign/$test/$blocks-$size-$procs---\$nb.tar.gz run* out-run-$test.*

rm -r run*
rm out-run-$test*

if [ \$(cat todo | wc -l) != 0 ]
then
        \$(head -n 1 todo)
        sed -i '1d' todo
fi
" >> submit-run-$test-$blocks-$size-$procs.sh

