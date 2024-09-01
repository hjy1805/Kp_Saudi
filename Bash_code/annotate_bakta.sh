#!/bin/bash

#SBATCH --job-name=bakta
#SBATCH --time=48:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --array=59,69,104,106,112,816,818
#SBATCH --mem=64GB
#SBATCH --error=annotate_bakta.err
#SBATCH --output=annotate_bakta.out

#conda activate bakta

acc=$(awk -F '[\t]' '{print $0}' tag_list | awk "NR == $SLURM_ARRAY_TASK_ID")

mkdir ./${acc}/bakta_annotation
bakta --db /ibex/project/c2205/databases/bakta_db --prefix ${acc} -f -o ./${acc}/bakta_annotation --genus Klebsiella --verbose -t 8 ./${acc}/assembly_unicycler/assembly.fasta
