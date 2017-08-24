#!/bin/bash
#SBATCH --comment "Hello ROMEO!"
#SBATCH -J "TEST 1"

#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out

#SBATCH --time=00:30:00

#SBATCH -n 1040
#SBATCH -N 65

. ~/env_yml-xmp.sh
mpirun -n 1 yml_scheduler *.yapp

