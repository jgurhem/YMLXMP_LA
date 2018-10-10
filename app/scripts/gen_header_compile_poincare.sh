#!/bin/sh

name=$1
blocks=$2
size=$3
procs=$4

echo "
#@ class            = compil
#@ job_name         = out-compile-$name
#@ total_tasks      = 1
#@ node             = 1
#@ wall_clock_limit = 00:30:00
#@ output           = \$(job_name).\$(jobid)-$blocks-$size-$procs.log
#@ error            = \$(job_name).\$(jobid)-$blocks-$size-$procs.err
#@ job_type         = mpich
#@ environment      = COPY_ALL
#@ queue
#
"

