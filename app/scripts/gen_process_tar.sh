#!/bin/sh
app=$1
blocks=$2
size=$3
procs=$4

echo "
d=\$(find . -maxdepth 1 -type d -name 'run*' -ls | sort -r | head -n 1 | awk '{print \$NF}')

rm -rf \$d/data
rm core*

mkdir -p ~/res_campaign/$app
nb=\$[\$(ls ~/res_campaign/$app/$blocks-$size-$procs* | wc -l)+1]
tar -cvf ~/res_campaign/$app/$blocks-$size-$procs---\$nb.tar.gz \$d out-run-$app.*
"

