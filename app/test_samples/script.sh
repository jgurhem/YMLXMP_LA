#!/bin/bash
#SBATCH --comment "Hello ROMEO!"
#SBATCH -J "TEST 1"

#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out

#SBATCH --time=00:30:00

#SBATCH -n 20
#SBATCH -N 2

#mpirun -n 1 yml_scheduler gaussJordan.query.yapp
mpirun -n 1 yml_scheduler test.query.yapp

