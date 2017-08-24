#!/bin/sh
array=( blockLU gaussJordan_inv blockGaussJordan blockGauss blockLUsolveLS )
test=$1

blocks=$2
size=$3
procs=$4
dis1=$5
dis2=$6

nbhosts=80
nbnodes=5

. scripts/gen_script_run.sh $test $blocks $size $procs $dis1 $dis2 $nbhosts $nbnodes

. scripts/gen_script_compile.sh $test $blocks $size $procs $dis1 $dis2 $nbhosts $nbnodes

sbatch submit-compile-$test-$blocks-$size-$procs.sh


