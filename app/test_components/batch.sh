#!/bin/bash
#@ class            = clallmds
#@ job_name         = ymlxmp_test
#@ total_tasks      = 32 
#@ node             = 2
#@ wall_clock_limit = 00:05:00
#@ output           = $(job_name).$(jobid).log
#@ error            = $(job_name).$(jobid).err
#@ job_type         = mpich
#@ environment      = COPY_ALL 
#@ queue
#

module purge
module load gnu/5.4.0 gnu-env/5.4.0 openmpi/1.10.0_gnu54 autotools/Feb2014
mpirun -n 1 yml_scheduler *.query.yapp
