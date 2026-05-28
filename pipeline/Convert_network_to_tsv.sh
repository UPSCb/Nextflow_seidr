#!/bin/bash -l
#SBATCH -A hpc2ncourses2026-006
#SBATCH -c 4
#SBATCH -t 01:00:00
#SBATCH -J convertBB
#SBATCH --output=%x.out
#SBATCH --error=%x.err

## Once you have chosen a network of interest according to the ROC reports, you can export it to tsv with this command

export OMP_NUM_THREADS=12

SEIDRCONTAINER=$(realpath YOUR_SEIDR_CONTAINER)

apptainer exec ${SEIDRCONTAINER} seidr view \
 -c -D -d $'\t' \
CHOSEN_NETWORK.sf \
 > CHOSEN_NETWORK.tsv
 
