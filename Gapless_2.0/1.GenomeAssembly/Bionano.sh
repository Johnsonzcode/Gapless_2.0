fa=filled.fa
q=bionano_ctg.cmap
#enzyme_site
E="BssSI"
memory=256
genome_size=1200
t=64
bnx=mallard_bionano_cacgag_BSSSI.bnx
o=filled_vs_bionano_B2N2

# need locattion of "RefAligner/1.0"
S=~/zhaoqiangsen/software/runBNG/tools_3.6.1/pipeline/Solve3.6.1_11162020/
R=~/zhaoqiangsen/software/runBNG/tools_3.6.1/pipeline/Solve3.6.1_11162020/RefAligner/1.0

#runBNG2.01 fa2cmap -f $fa -o ./ -e BssSI -s $S
mkdir $o
cp /storage-01/poultrylab1/zhaoqiangsen/software/runBNG/Examples/exp_optArguments.xml .
runBNG2.01 hybrid -s $S -R $R -r $fa -b $bnx -e BssSI -B 2 -N 2 -f $q -c "8.33e-9" -t $t -M $memory -o $o -x exp_optArguments.xml
# ref_vs_bionano_ctg_B1_N1/assignAlignType/cut_conflicts/conflicts_cut_status.txt