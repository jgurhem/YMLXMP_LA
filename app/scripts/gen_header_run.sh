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
#SBATCH --comment \"Hello ROMEO!\"
#SBATCH -J \"$test\"

#SBATCH --error=out-run-$test.%J.err
#SBATCH --output=out-run-$test.%J.out

#SBATCH --reservation=jegurhem_5403
#SBATCH --qos=short
#SBATCH -p romeo

#SBATCH --time=01:00:00

#SBATCH -n $nbhosts
#SBATCH -N $nbnodes
"

