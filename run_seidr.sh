#!/bin/bash -l
#SBATCH --account=HPC2N2025-131
#SBATCH --ntasks=1
#SBATCH --time=12:00:00
#SBATCH --mem=2G
#SBATCH --output=nextflow.out
#SBATCH --error=nextflow.err
#SBATCH -J nextflow_seidr


set -u -o pipefail

ml Nextflow GCCcore/11.3.0 Graphviz/5.0.0


nextflow run main.nf -work-dir data/workdir  -c nextflow.config   -with-trace -with-report data/report_$(date "+%Y_%m_%d_%H_%M").html
