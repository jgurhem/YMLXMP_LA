#!/bin/sh
app=$1
blocks=$2
size=$3
procs=$4

echo "
rm -rf run1/data
rm core*

mkdir -p ~/res_campaign/$app
nb=\$[\$(ls ~/res_campaign/$app/$blocks-$size-$procs* | wc -l)+1]
tar -cvf ~/res_campaign/$app/$blocks-$size-$procs---\$nb.tar.gz run* out-run-$app.*

rm -rf run*
"

