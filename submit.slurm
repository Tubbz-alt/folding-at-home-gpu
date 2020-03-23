#!/bin/bash
 
#SBATCH --account=shared
#SBATCH --partition=shared
#SBATCH --qos=scavenger

#SBATCH --job-name=fah
#SBATCH --chdir=/gpfs/slac/cryo/fs1/u/ytl/fah/
#SBATCH --output=%j.txt
#SBATCH --error=%j.txt

#SBATCH -N 1
#SBATCH --gpus 10
#SBATCH --cpus-per-gpu=4
#SBATCH --mem=184g

#SBATCH --time=7-00:00:00

# work directory
mkdir -p ${SLURM_JOB_ID}
cd ${SLURM_JOB_ID}

# source modules 
source /etc/profile.d/modules.sh
export MODULEPATH=/usr/share/Modules/modulefiles:/opt/modulefiles:/afs/slac/package/singularity/modulefiles

# load fah
module load fah

# run!
FAHClient --user=ytl --team=243328 --gpu=true --smp=true --power=full
