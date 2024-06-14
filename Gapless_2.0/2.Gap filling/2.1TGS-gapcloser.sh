# Following the order of sequence length : ONT HiFi CLR

~/zhaoqiangsen/software/TGS-GapCloser/TGS-GapCloser.sh  \
        --scaff  $scaf \
        --reads  $reads \
        --output $output \
        --ne \
        --tgstype $tgstype\
        --minmap_arg '-x map-hifi' \
        --thread $t

#--tgstype type_of _reads, when type is HiFi:--minmap_arg ‘-x map-hifi’,