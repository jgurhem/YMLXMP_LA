#!/bin/sh

blocks=$1
size=$2
procs=$3
dis1=$4
dis2=$5
dir=$6

echo "
hometmp=\$(pwd)

mkdir -p $dir/init $dir/lu

cd ../abst
bash compile

cd ../impl/impl_SIZE
bash changesize $size

cd ../impl_size$size
bash changep $procs $dis1 $dis2

cd impl_p$procs/

#sed -i \"s/lang=\\\"XMP\\\"/lang=\\\"XMP\\\" libs=\\\"include_lib_intel\\\"/g\" *
sed -i \"s%DIR%$dir%g\" *.query
. compile

cd ../..
rm -r impl_size*

cd \$hometmp
"

