# see https://github.com/Johnsonzcode/CAU_Silkie_code/blob/master/repeat_sequence_masking/mask.sh

d=/storage-01/poultrylab1/Software/ClassifyTE

fa=Unknown_repeat.fa
python ${d}/generate_feature_file.py -f $fa -d features 

python ${d}/evaluate.py -f feature_file.csv -n node.txt -d features -m ClassifyTE_combined.pkl -a lcpnb