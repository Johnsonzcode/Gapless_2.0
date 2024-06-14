ref=hap1
reads=one.gt30k.fq
o=ont.hap1.bam
minimap2 --secondary=no --sam-hit-only -ax $t -t $threads $ref $reads | samtools sort -m 2G -@ $threads -o $o
ref=hap2
reads=one.gt30k.fq
o=ont.hap2.bam
minimap2 --secondary=no --sam-hit-only -ax $t -t $threads $ref $reads | samtools sort -m 2G -@ $threads -o $o
bedtools bamtofastq -i ont.hap1.bam -fq ont.hap1.fq
bedtools bamtofastq -i ont.hap2.bam -fq ont.hap2.fq