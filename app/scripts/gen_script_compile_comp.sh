#!/bin/sh

blocks=$1
size=$2
procs=$3
dis1=$4
dis2=$5

echo "
hometmp=\$(pwd)

cd ../abst
for i in *.query
do
	yml_component --force \$i
done

cd ../impl
mkdir impl-tmp
cp -r impl_SIZE/* impl-tmp
cd impl-tmp

sed -i \"s/SIZE/$size/g;s/DISTMAT1/$dis1/g;s/DISTMAT2/$dis2/g;s/DISTVECT/$procs/g\" *.query
#sed -i \"s/lang=\\\"XMP\\\"/lang=\\\"XMP\\\" libs=\\\"include_lib_intel\\\"/g\" *
for i in *.query
do
	yml_component --force \$i
done

cd ..
rm -r impl-tmp

cd \$hometmp
"

