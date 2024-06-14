nextflow run WarrenLab/hic-scaffolding-nf \
    --contigs hifi.pri.fa \
    --r1Reads hic_reads_R1.fastq.gz \
    --r2Reads hic_reads_R2.fastq.gz \
    -profile conda,lewis \
    --extra-yahs-args "-e dpnii"