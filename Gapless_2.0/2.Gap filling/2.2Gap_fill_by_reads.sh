assembly=xx.fa ## the name of genome assembly for gapfilling
reads=all_silkie_ONT.fasta ## the reads used to gapfill
length=100000 ## the sequence length of up- and down-stream of the gap  eg. 100000
threads=40 ## the thread for minimap eg. 30
d=~/zhaoqiangsen/software/gapfill_by_reads
t=map-ont
o=filled_by_ont

## step 1, find the gap position in genome.fasta
python3 $d/gap_position_finder.py ${assembly}

## step 2, pick the up- and down-stream sequences of the gaps
python3 $d/pick_gap_updown.py ${assembly} ${assembly}.gap.posi ${length}

## step 3, map the gap sequences to the reference read.fasta
minimap2 -x $t -t ${threads} --secondary=no ${reads} ${assembly}.gap.posi.fasta > reads_align_gap.paf

## step 4, filter the mapping paf results
python3 $d/filter_maping_paf.py reads_align_gap.paf ${length}

## step 5, replace the gaps with the mapping read seqeences
python3 $d/replace_gap.py ${reads} ${assembly} reads_align_gap.paf.gtLen.sort.select ${length}

mv *replace.fasta ${o}.fa