#!/bin/sh
array=( blockLU gaussJordan_inv blockGaussJordan blockGauss blockLUsolveLS )
test=$1

blocks=$2
size=$3
procs=$4
dis1=$5
dis2=$6

nbhosts=5
nbnodes=1

echo "#!/bin/bash" > submit-run-$test-$blocks-$size-$procs.sh
#. scripts/gen_header_run.sh $test $blocks $size $procs $dis1 $dis2 $nbhosts $nbnodes
. scripts/gen_script_run.sh $test $blocks $size $procs $dis1 $dis2 $nbhosts $nbnodes
#. scripts/gen_process_run.sh $test $blocks $size $procs $dis1 $dis2 $nbhosts $nbnodes

echo "#!/bin/bash" > submit-compile-$blocks-$size-$procs.sh
#. scripts/gen_header_compile.sh $blocks $size $procs
. scripts/gen_script_compile.sh $blocks $size $procs $dis1 $dis2
#echo "sbatch submit-run-$test-$blocks-$size-$procs.sh" >> submit-compile-$blocks-$size-$procs.sh

#sbatch submit-compile-$blocks-$size-$procs.sh


