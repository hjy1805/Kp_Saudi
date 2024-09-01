#!/bin/bash

#SBATCH --job-name=srst
#SBATCH --time=96:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --array=1-50
#SBATCH --mem=64GB
#SBATCH --error=typing_srst.err
#SBATCH --output=typing_srst.out

source activate srst

acc=$(awk -F '[\t]' '{print $0}' ./tag_list | awk "NR == $SLURM_ARRAY_TASK_ID")

cd ./${acc}

srst2 --input_pe ${acc}_1.fq.gz ${acc}_2.fq.gz --output ${acc} --log --gene_db /ibex/project/c2205/databases/VFDB_am_clean.fasta --threads 16

srst2 --input_pe ${acc}_1.fq.gz ${acc}_2.fq.gz --output ${acc} --log --gene_db /ibex/project/c2205/databases/CARD.fasta --threads 16

srst2 --input_pe ${acc}_1.fq.gz ${acc}_2.fq.gz --output ${acc} --log --gene_db /ibex/project/c2205/databases/plasmidfinder.fasta --threads 16

srst2 --input_pe ${acc}_1.fq.gz ${acc}_2.fq.gz --output ${acc} --log --gene_db /ibex/project/c2205/databases/ResFinder.fasta --threads 16
