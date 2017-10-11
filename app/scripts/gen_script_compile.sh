#!/bin/sh

blocks=$1
size=$2
procs=$3
dis1=$4
dis2=$5

echo "
. ~/env_yml-xmp_impi.sh

hometmp=\$(pwd)

rm -r ../impl/impl_size*

cd ../impl/impl_SIZE
. changesize $size

cd ../impl_size$size
. changep $procs $dis1 $dis2

cd impl_p$procs/

#sed -i \"s/lang=\\\"XMP\\\"/lang=\\\"XMP\\\" libs=\\\"include_lib_intel\\\"/g\" *
sed -i \"s%DIR%/tmp/res%g\" *
. compile

cd \$hometmp
" >> submit-compile-$blocks-$size-$procs.sh

