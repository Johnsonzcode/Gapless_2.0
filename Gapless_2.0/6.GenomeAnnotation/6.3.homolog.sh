###homology

miniprot -t8 --gff wild2.final2.fasta wild1.faa > wild2.mini.gff
grep -e "stop_codon" wild2.mini.gff > miniprot.compelte.list
grep -o "MP[0-9]*" miniprot.compelte.list > miniprot.compelte.id
#https://github.com/jorvis/biocode/blob/9f043705e436db4a17dace4a2f70be0da5dfc3b5/gff/filter_gff3_by_id_list.py
python filter_gff3_by_id_list.py -l miniprot.compelte.id -i wild2.mini.gff -o wild2.mini.complete.gff


ls ./homology.fa.split/* | parallel -N 1 -j 80 -k '/storage-01/poultrylab1/mambaforge/envs/braker3/bin/exonerate --model protein2genome --querychunkid {#} --querychunktotal 100 --showvulgar no --showalignment no --showquerygff no --showtargetgff yes --ryo "AveragePercentIdentity: %pi\n" --bestn 1 --query {} --target CAU_Silkie_2.0_final.fa.masked > {/.}.gff3'