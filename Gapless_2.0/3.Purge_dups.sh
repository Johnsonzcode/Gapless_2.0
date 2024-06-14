t=40
ref=xx.fa
readstype=hifi
reads=chicken_hifi_3cell_hic_ul.ec.fa


if [ ! -f aln.paf.gz ];then 
if [ "$readstype" == "ont" ]; then
        minimap2 --secondary=no --sam-hit-only --MD -t $t -x map-ont $ref $reads | pigz -c - > aln.paf.gz
else
        minimap2 --secondary=no --sam-hit-only --MD -t $t -x map-hifi $ref $reads | pigz -c - > aln.paf.gz
fi
fi

if [ ! -f PB.stat ];then
        pbcstat aln.paf.gz
        calcuts PB.stat > cutoffs 2> calcults.log
fi

if [ ! -f asm.split.self.paf.gz ];then
        split_fa $ref > ${ref}.split

        minimap2 --sam-hit-only --MD -t $t -xasm5 -DP ${ref}.split ${ref}.split | pigz -c > asm.split.self.paf.gz
fi

# check cut-offs
~/zhaoqiangsen/software/purge_dups-1.2.6/scripts/hist_plot.py -c cutoffs PB.stat PB.stat.png

exit 0

# set like this
# https://github.com/dfguan/purge_dups/issues/38
# https://github.com/dfguan/purge_dups/issues/36
# https://github.com/dfguan/purge_dups/issues/75, -l lowest, -m 0.75*cov, -u 3*cov
# ~/zhaoqiangsen/software/purge_dups-1.2.6/bin/calcuts -l 18 -u 309 -m 93 PB.stat > cutoffs 

# purge haplotigs or at most including overlap
purge_dups -2 -T cutoffs -c PB.base.cov asm.split.self.paf.gz > dups.bed 2> purge_dups.log

# get the purged primary and haplotigs sequences from draft assembly
get_seqs -e dups.bed $ref

# BUSCO to test