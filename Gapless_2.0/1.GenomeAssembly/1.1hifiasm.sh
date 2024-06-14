h=hifi.reads.fq
ul=ont.fq
hic1=hic_1.fq
hic2=hic_2.fq
hifiasm -o ${h/%.*}_hic_ul -t $t --ul $ul \
        --h1 $hic1 \
        --h2 $hic2 \
        --ul-cut 50000 \
        $h --write-ec --write-paf 