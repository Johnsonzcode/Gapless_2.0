###Ab-initio
##Running braker3 singularity, soft-masked assembly required
cp -r /home/miniconda3/envs/braker/config/ ./
export AUGUSTUS_CONFIG_PATH=./config/
singularity exec -B $PWD:$PWD braker3.sif braker.pl --genome=wild2.final2.fasta.masked --species=wild2 --prot_seq=birds.homo.faa --bam=merged.bam --gff3 --threads 32 --AUGUSTUS_CONFIG_PATH=./config/