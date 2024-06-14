ref=CAU_Silkie_2.0_final.fa
fq=SilkieA_cleandata.fq
f5=fast5
s=summray
threads=64
o=100X_part1.bam

#nanopolish index -d $f5 -f $s $fq

#minimap2 --secondary=no --sam-hit-only -f 0.02 --eqx --MD -Y -t $threads -ax map-ont $ref $fq  \
#        | samtools sort -T tmp -m 2G -@ $threads -o $o -
#
#samtools index -@ $threads $o
#nanopolish call-methylation -q cpg -t $threads -r $fq -b $o -g $ref  > methylation_calls1.tsv
python /storage-02/zhaoqiangsen/software/nanopolish/scripts/calculate_methylation_frequency.py -s methylation_calls_chr_merged1.tsv > methylation_calls_chr_merged1_split.tsv