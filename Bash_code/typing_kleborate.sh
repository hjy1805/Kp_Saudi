#!/bin/bash

#SBATCH --job-name=kleborate
#SBATCH --time=72:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --array=1-50
#SBATCH --mem=64GB
#SBATCH --error=typing_kleborate.err
#SBATCH --output=typing_kleborate.out

#conda activate kleborate

run_acc=$(awk '{print $0}' ./tag_list | awk "NR == $SLURM_ARRAY_TASK_ID")

kleborate -a ./${run_acc}/assembly_unicycler/assembly.fasta --all -o ./${run_acc}/${run_acc}_kleborate.txt
