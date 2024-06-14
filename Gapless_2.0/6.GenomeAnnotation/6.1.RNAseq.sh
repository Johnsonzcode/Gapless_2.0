ls *.R1.fastq.gz | cut -f 1-2 -d '.'| while read loc;do
spname=`ls ${loc}.R1.fastq.gz | cut -f 9 -d '/'`
fastp -i ${loc}.R1.fastq.gz -I ${loc}.R2.fastq.gz -o ${loc}.R1.clean.fastq.gz -O ${loc}.R2.clean.fastq.gz -q 20
hisat2 -x wild2 -1 ${loc}.R1.clean.fastq.gz -2 ${loc}.R2.clean.fastq.gz --dta -p 16 | samtools sort -@ 16 -O BAM -o ${spname}.sort.bam  
echo ${loc} ${spname} >> suc.samples
done

samtools merge -@ 16 merged.bam *.sort.bam
stringtie merged.bam -p 10 -o merged.gtf

#soft-masked or no mask assembly
gawn/01_scripts/TransDecoder/util/cufflinks_gtf_genome_to_cdna_fasta.pl merged.gtf sp.fasta.masked > sptranscripts.fasta
gawn/01_scripts/TransDecoder/util/cufflinks_gtf_to_alignment_gff3.pl merged.gtf > sptranscripts.gff3
TransDecoder.LongOrfs -t sptranscripts.fasta
TransDecoder.Predict -t sptranscripts.fasta
gawn/01_scripts/TransDecoder/util/cdna_alignment_orf_to_genome_orf.pl sptranscripts.fasta.transdecoder.gff3 sptranscripts.gff3 sptranscripts.fasta > sptranscripts.fasta.transdecoder.genome.gff3