r=wild2.fa
bowtie2-build -f ${r} ${r/%.fa}
digest_genome.py -r "DpnII" -o ${r}.bed ${r}
samtools faidx ${r} && awk '{print $1 "\t" $2}' ${r}.fai > ${r}.sizes
cp ~/WORKSPACE/Software/hicpro3.1/HiC-Pro_3.1.0/config-hicpro.txt .

HiC-Pro -i duck_hic -o duck_AB_compartment -c config-hicpro.txt -p