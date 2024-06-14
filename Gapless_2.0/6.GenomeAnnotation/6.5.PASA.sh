#PASA update annotation and add UTR
#cp Trinity-GG.fasta all_transcripts.fasta
#makeblastdb -in UniVec -dbtype nucl -parse_seqids -title UniVec -out UniVec

#/storage-01/poultrylab1/yin/software/anaconda3/envs/pasa/opt/pasa-2.5.2/bin/seqclean sptranscripts.fasta -v UniVec -c 16

#Launch_PASA_pipeline.pl -c alignassembly.config -C -R -g CAU_Silkie_2.0_final.fa.masked -t sptranscripts.fasta.clean -T -u sptranscripts.fasta --ALIGNERS blat,minimap2 --CPU 64 --TRANSDECODER

#Load_Current_Gene_Annotations.dbi -c alignassembly.config -g CAU_Silkie_2.0_final.fa.masked -P EVM.all.gff3
#SQLite path in alignAssembly.config and annotCompare.config
#Launch_PASA_pipeline.pl -c annotCompare.config -A -g CAU_Silkie_2.0_final.fa.masked -t sptranscripts.fasta.clean --CPU 64
#2nd 
Load_Current_Gene_Annotations.dbi -c alignassembly.config -g CAU_Silkie_2.0_final.fa.masked -P silkie2.sqlite.gene_structures_post_PASA_updates.36593.gff3

Launch_PASA_pipeline.pl -c annotCompare.config -A -g CAU_Silkie_2.0_final.fa.masked -t sptranscripts.fasta.clean --CPU 64