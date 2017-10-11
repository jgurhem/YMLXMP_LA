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
. ~/env_yml-xmp_impi.sh

echo \"localhost\" > hosts
j=1
while [ \$j -lt $nbhosts ]  
do
        echo \"localhost\" >> hosts
        j=\$[\$j+1]
done

cp hosts ~/.omrpc_registry/nodes

sed -e \"s/BC/$blocks/g\" model/$test.query > $test.query

yml_compiler $test.query

omrpc-register-yml $test.query.yapp | grep ^$test > stubs
echo \" \" >> stubs

cp stubs  ~/.omrpc_registry

mpirun -n 1 yml_scheduler $test.query.yapp
" >> submit-run-$test-$blocks-$size-$procs.sh

