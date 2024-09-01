#!/bin/bash

#SBATCH --job-name=mapping
#SBATCH --time=72:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --array=1-50
#SBATCH --mem=64GB
#SBATCH --error=mapping.err
#SBATCH --output=mapping.out

module load snippy/4.4.3

run_acc=$(awk -F '[\t]' '{print $0}' ./tag_list | awk "NR == $SLURM_ARRAY_TASK_ID")

mkdir ./${run_acc}/mapping
snippy --cpus 16 --force --outdir ./${run_acc}/mapping --ref ./reference.gbk.gb --R1 ./${run_acc}/${run_acc}_1.fq.gz --R2 ./${run_acc}/${run_acc}_2.fq.gz
rm -rf ./${run_acc}/mapping/snps.bam
