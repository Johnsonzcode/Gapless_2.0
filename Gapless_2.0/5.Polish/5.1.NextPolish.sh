#Set input and parameters
round=2
threads=64
read=hifi.fasta
mapping_option="map-hifi" # (["clr"]="map-pb" ["hifi"]="map-hifi" ["ont"]="map-ont")
input=xx.fa
o=xx_hifi_2.fa


for ((i=1; i<=${round};i++)); do
        minimap2  --sam-hit-only -Y -t $threads -ax ${mapping_option} $input $read \
        | samtools sort -m 2G -@ $threads -o lgs.sort.bam -
    samtools index lgs.sort.bam;
    ls `pwd`/lgs.sort.bam > lgs.sort.bam.fofn;
    python ~/zhaoqiangsen/software/NextPolish/lib/nextpolish2.py -g ${input} -l lgs.sort.bam.fofn -r ${read_type} -p ${threads} -sp -o genome.nextpolish.fa;
    if ((i!=${round}));then
        mv genome.nextpolish.fa genome.nextpolishtmp.fa;
        input=genome.nextpolishtmp.fa;
    fi;
done
mv genome.nextpolish.fa $o