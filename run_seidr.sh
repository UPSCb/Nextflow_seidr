#!/bin/bash -l
#SBATCH --account=HPC2N2025-155
#SBATCH --ntasks=1
#SBATCH --time=168:00:00
#SBATCH --mem=2G
#SBATCH --output=nextflow.out
#SBATCH --error=nextflow.err
#SBATCH -J nextflow_seidr


set -u -o pipefail

ml Nextflow/25.10.0 


nextflow run main.nf -work-dir data/workdir  -c nextflow.config   -with-trace -with-report data/report.html -resume
