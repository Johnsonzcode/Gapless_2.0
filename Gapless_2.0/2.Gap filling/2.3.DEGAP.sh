for i in chrxx chrx
do

python /storage-02/zhaoqiangsen/software/DEGAP/DEGAP.py --mode gapfiller \
        --seqleft ${i}_gap_left_20kb.fa \
        --seqright ${i}_gap_right_20kb.fa \
        --reads chicken_hifi_3cell.ec.fa \
        -o ${i}_gap_20kb_from_right --flag right -t 40

done

# --flag right and --flag left separately, then check with LINKVIEW2 and https://github.com/ZhouQiLab/DuckGenome/tree/master/anchoring_chr