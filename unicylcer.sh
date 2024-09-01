#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=12
#SBATCH --job-name=uncycler
#SBATCH --error=myjob.%J.err
#SBATCH --time=12:00:00

module load unicycler/0.5.0
module load spades/3.15.5
module load racon/1.5.0

unicycler -1 *_1.fastq -2 *_2.fastq  -l *_l.fastq  -o out_unicylcer --mode conservative
