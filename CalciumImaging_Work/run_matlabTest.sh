#!/bin/csh
# this is a qsub companion script for running Array Job
# Usage examples:
# module load matlab/2016a
# scc1$ qsub -t 1:3500 -tc 100 ./run_matlabTest.sh
# Specify qsub options
# Send email to SCC userID when job finished or aborted
#$ -m ae
# Give the job(s) a name
#$ -N MA666
# Specify where to put the outfile
# -o OutFiles/$JOB_ID.$TASK_ID.out
# -e OutFiles/$JOB_ID.$TASK_ID.err
# use env var SGE_TASK_ID as random matrix size n
 
matlab -nodisplay -singleCompThread -r \
 "sccRunTests('inputList.txt', $SGE_TASK_ID, 'results_$JOB_ID'),exit"
