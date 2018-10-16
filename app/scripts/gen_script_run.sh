#!/bin/sh
array=( blockLU gaussJordan_inv blockGaussJordan blockGauss blockLUsolveLS )
test=$1

nbhosts=$2

echo "
echo \"localhost\" > hosts
j=1
while [ \$j -lt $nbhosts ]  
do
        echo \"localhost\" >> hosts
        j=\$[\$j+1]
done

cp hosts ~/.omrpc_registry/nodes

mpirun -n 1 yml_scheduler $test.query.yapp
"

