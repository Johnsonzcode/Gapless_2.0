# Place of fasta and database
input_faa=800_miss_prot.faa
target=chicken_hifi_3cell.ec.fa
outprefix=${input_faa}_vs_${target}_mmseqs_rbh.tsv
tmp_folder=./tmp/mmseqs_rbh

if [ ! -d ${tmp_folder} ]
then
        mkdir -p ${tmp_folder}
fi

echo $SLURM_NPROCS

mmseqs easy-rbh $input_faa $target $outprefix $tmp_folder -s 7.5 --cov-mode 0 --search-type 0 --format-mode 4 --threads $SLURM_NPROCS