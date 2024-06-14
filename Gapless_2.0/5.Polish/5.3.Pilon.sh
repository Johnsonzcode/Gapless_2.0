t=96

r=polished1.fa
if [ ! -f ${r}.bwt.2bit.64 ];then
        bwa-mem2.avx512bw index ${r}
fi

cat fq | parallel -N 2 -j 1 -k "bwa-mem2.avx512bw mem -R '@RG\tID:{1/.}\tPL:illumina\tSM:{1/.}' -t $t ${r} {1} {2} | samtools view -b -@ $t - | samtools sort -m 2G -@ $t -o {1/.}.bam"

b=`ls *.bam`

samtools index -@ $t $b
sambamba markdup -t $t $b ${b/%.*}_markdup.bam
samtools view -bh -@ $t -q 30 ${b/%.*}_markdup.bam > ${b/%.*}_markdup_q30.bam
samtools index -@ $t ${b/%.*}_markdup_q30.bam

max=300
min=1
seqkit split2 -p 5 $r
ls ${r}.split/* | parallel -N 1 -j 6 -k java -Xms${min}G -Xmx${max}G -jar /storage-01/poultrylab1/yin/software/anaconda3/envs/asm_polish/share/pilon-1.24-0/pilon.jar --genome {} --frags ${b/%.*}_markdup_q30.bam \
    --output {/.}_ngs_polished1