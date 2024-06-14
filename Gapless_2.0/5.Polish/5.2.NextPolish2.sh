r1=NDES00380_L4_1_clean.fq.gz
r2=NDES00380_L4_2_clean.fq.gz
threads=128
memory=256GB
meryldb=asm.fa.meryl
ref=xx.fa
hifi=Mallard_hifi.ec.fa

for i in `cat k.list`;
do
# produce a 21-mer dataset, remove -b 37 if you want to count singletons
echo "yak count -o k$i.yak -t $threads -k $i -b 37 <(zcat $r1) <(zcat $r2)"
yak count -o k$i.yak -t $threads -k $i -b 37 <(zcat $r1) <(zcat $r2)
done

meryl count k=15 threads=$threads memory=$memory output $meryldb $ref
meryl print greater-than distinct=0.9998 $meryldb > repetitive_k15.txt
winnowmap --sam-hit-only --MD --secondary=no -t $threads -W repetitive_k15.txt -ax map-pb $ref $hifi | samtools sort -m 2G -@ $threads -o hifi.map.sort.bam -

# indexing
samtools index -@ $threads hifi.map.sort.bam

# use -r to use all reads from two haplotypes
nextPolish2 -r -t $threads hifi.map.sort.bam $ref `ls *.yak` > asm.np2.fa