#!/bin/sh
array=( blockLU gaussJordan_inv blockGaussJordan blockGauss blockLUsolveLS )
app=$1
nbhosts=$2
nbnodes=$3

echo "
#@ class            = clallmds+
#@ job_name         = yml_xmp-run-$app
#@ total_tasks      = $nbhosts
#@ node             = $nbnodes
#@ wall_clock_limit = 06:00:00
#@ output           = \$(job_name).\$(jobid).log
#@ error            = \$(job_name).\$(jobid).err
#@ job_type         = mpich
#@ environment      = COPY_ALL 
#@ queue
#
"

