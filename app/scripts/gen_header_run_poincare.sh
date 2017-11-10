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
#@ class            = clallmds+
#@ job_name         = out-run-$test
#@ total_tasks      = $nbhosts
#@ node             = $nbnodes
#@ wall_clock_limit = 03:00:00
#@ output           = \$(job_name).\$(jobid).log
#@ error            = \$(job_name).\$(jobid).err
#@ job_type         = mpich
#@ environment      = COPY_ALL 
#@ queue
#
" >> submit-run-$test-$blocks-$size-$procs.sh

