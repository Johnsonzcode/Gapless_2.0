TRANSCRIPT      transdecoder    10
PROTEIN miniprot        5
PROTEIN exonerate:protein2genome:local  3
ABINITIO_PREDICTION     AUGUSTUS        2
ABINITIO_PREDICTION     GeneMark.hmm3   1
ABINITIO_PREDICTION     gmst    1
ABINITIO_PREDICTION     Helixer 1

# ~/Software/EVidenceModeler/EvmUtils/misc/miniprot_GFF_2_EVM_GFF3.py
d=/storage-01/poultrylab1/yin/software/EVidenceModeler/EvmUtils/
$d/partition_EVM_inputs.pl --genome CAU_Silkie_2.0_final.fa.masked \
        --gene_predictions helixer_braker.gff3 --protein_alignments minimap2_exonerate.gff3 \
         --transcript_alignments sptranscripts.fasta.transdecoder.genome.gff3 \
         --segmentSize 100000 --overlapSize 10000 \
        --partition_listing partitions_list.out && echo "partion done!!!"

$d/write_EVM_commands.pl --genome CAU_Silkie_2.0_final.fa.masked \
        --protein_alignments minimap2_exonerate.gff3 --gene_predictions helixer_braker.gff3 \
        --transcript_alignments sptranscripts.fasta.transdecoder.genome.gff3 \
        --weights `pwd`/weights.txt --output_file_name evm.out \
        --partitions partitions_list.out >  commands.list && echo "write cmd done!!!"

$d/execute_EVM_commands.pl commands.list && echo "execute done!!!"

$d/recombine_EVM_partial_outputs.pl --partitions partitions_list.out \
        --output_file_name evm.out && echo "recombine done!!!"

$d/convert_EVM_outputs_to_GFF3.pl  --partitions partitions_list.out \
        --output_file_name evm.out --genome CAU_Silkie_2.0_final.fa.masked && echo "convert done!!!"

find . -regex ".*evm.out.gff3" -exec cat {} \; > EVM.all.gff3