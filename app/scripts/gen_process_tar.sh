#!/bin/sh
app=$1
blocks=$2
size=$3
procs=$4

echo "
d=\$(find . -maxdepth 1 -type d -name 'run*' | xargs ls -dt | head -n 1)

rm -rf \$d/data
rm core*

mkdir -p ~/res_campaign/$app
tar -cvf ~/res_campaign/$app/$blocks-$size-${procs}_\$(date +%Y%m%d-%H%M%S).tar.gz \${d}* out-run-$app.*
"

