#!/bin/sh

blocks=$1
size=$2
procs=$3

echo "
#SBATCH --comment \"Hello ROMEO!\"
#SBATCH -J \"compil\"

#SBATCH --error=out-compile.%J-$blocks-$size-$procs.err
#SBATCH --output=out-compile.%J-$blocks-$size-$procs.out

#SBATCH --reservation=jegurhem_5403
#SBATCH --qos=short
#SBATCH -p romeo

#SBATCH --time=00:30:00

#SBATCH -n 1
#SBATCH -N 1
"

