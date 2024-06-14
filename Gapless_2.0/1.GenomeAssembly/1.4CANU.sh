reads=ont.fq
canu \
 -p silkie -d silkie-ont \
genomeSize=1.1G -nanopore $reads 
