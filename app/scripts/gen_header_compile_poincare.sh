#!/bin/sh

blocks=$1
size=$2
procs=$3

echo "
#@ class            = compil
#@ job_name         = out-compile
#@ total_tasks      = 1
#@ node             = 1
#@ wall_clock_limit = 00:30:00
#@ output           = \$(job_name).\$(jobid)-$blocks-$size-$procs.log
#@ error            = \$(job_name).\$(jobid)-$blocks-$size-$procs.err
#@ job_type         = mpich
#@ environment      = COPY_ALL
#@ queue
#
" >> submit-compile-$blocks-$size-$procs.sh

