#!/bin/bash

script=$(readlink -f "$0")
scriptpath=$(dirname "$script") 

# USAGE:  rldd.sh <folder containing executable and .so files>


TMP_DIR=$(mktemp -d /tmp/rldd-tmp-XXXXXX)
RESULT_DIR=$(mktemp -d /tmp/rldd-result-XXXXXX)

TARGET_DIR="$1"

find $TARGET_DIR -type f -name "*.so" >> $TMP_DIR/binaryfiles.txt
find $TARGET_DIR -type f -name "*.so.*" >> $TMP_DIR/binaryfiles.txt
find $TARGET_DIR -type f -exec file {} \; | grep -E "\bELF\b" | grep -E "shared object|executable" | cut -d: -f1 >> $TMP_DIR/binaryfiles.txt

function sortuniq()
{
    local FILE="$1"
    local TMPF=$(mktemp /tmp/XXXXXXXX.txt)
    
    cat "$FILE" | sort | uniq | sort | uniq | sort > "$TMPF"
    mv "$TMPF" "$FILE"
}

sortuniq $TMP_DIR/binaryfiles.txt

# ldd (循环）
# lddtree (循环）
# objdump -T (仅自身)
# readelf -d (仅自身)

while read -r line
do
    ldd "$line" 2>/dev/null | grep " => " | grep -v " => not found" \
        | sed 's/(.*)//g' \
        | sed 's/^.* => //g'  >> $RESULT_DIR/rldd.txt
    objdump -T "$line" | grep -E "\(.*\)" -o | sed 's/\[//g' | sed 's/\]//g' >> $RESULT_DIR/rlibver.txt
done < $TMP_DIR/binaryfiles.txt
sortuniq $RESULT_DIR/rldd.txt
sortuniq $RESULT_DIR/rlibver.txt

echo "$RESULT_DIR"
