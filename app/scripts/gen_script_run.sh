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

echo "#!/bin/bash
#SBATCH --comment \"Hello ROMEO!\"
#SBATCH -J \"$test\"

#SBATCH --error=out-run-$test.%J.err
#SBATCH --output=out-run-$test.%J.out

#SBATCH --time=01:00:00

#SBATCH -n $nbhosts
#SBATCH -N $nbnodes

. ~/env_yml-xmp_impi.sh

cd /scratch_p/jegurhem/test_xmp/app

mpirun -n 1 yml_scheduler $test.query.yapp

rm -r run*/data

echo \" 



=================================================================
(h$nbhosts  n$nbnodes)  $test   $blocks   $size    $procs
=================================================================
\" >> results
date >> results

echo \"
---
no time for matrix generation
---
\"

. scripts/check_nogen run1/exec_log 

echo \"
---
with time for matrix generation
---
\"

. scripts/check_clear run1/exec_log >> results

sleep 2

echo \"\" >> results
ls *results.pack >> results

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
" > submit-run-$test-$blocks-$size-$procs.sh

