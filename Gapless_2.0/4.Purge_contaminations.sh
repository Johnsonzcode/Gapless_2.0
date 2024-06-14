# download krakenuniq_archaea_bacteria_viral_human_UniVec_Core from krakenuniq main page

# download Contaminant sequences from UniVec and EmVec, plus the human reference genome
#krakenuniq-download --db Contaminant_DBDIR refseq/vertebrate_mammalian/Chromosome/species_taxid=9606 --threads 104
# download All microbial (including eukaryotes) sequences in the NCBI nt database
# krakenuniq-download --db microbial_DBDIR --dust microbial-nt --threads 52

target=final_dedup.fa

#krakenuniq-build --db Contaminant_DBDIR --kmer-len 31 --threads $SLURM_NPROCS --taxids-for-genomes --taxids-for-sequences
# only use --preload for the first time
db=~/WORKSPACE/Software/krakenuniq_Standard_dbdir_archaea_bacteria_viral_human_UniVec_Core
krakenuniq --preload-size 128G --db $db --threads $SLURM_NPROCS --report-file REPORTFILE.tsv $target > READCLASSIFICATION.tsv
krakenuniq-translate  --db $db --mpa-format READCLASSIFICATION.tsv > READCLASSIFICATION_labels.tsv
# awk '$8=="species"&&$4>2000{print $0}' REPORTFILE.tsv
# krakenuniq-extract-reads -a -f -i -t ~/WORKSPACE/Software/krakenuniq_Standard_dbdir_archaea_bacteria_viral_human_UniVec_Core 32630,93465 READCLASSIFICATION.tsv first_filled_final_sort_split.fa > first_filled_final_sort_split_noPollution.fa