#!/bin/sh
test=$1

blocks=$2
size=$3
procs=$4
dis1=$5
dis2=$6

nbhosts=$7
nbnodes=$8

echo "localhost" > hosts
i=1
while [ $i -lt $nbhosts ]  
do
        echo "localhost" >> hosts
        i=$[$i+1]
done

cp hosts ~/.omrpc_registry/nodes

sed -e "s/BC/$blocks/g" model/$test.query > $test.query

echo "#!/bin/bash
#SBATCH --comment \"Hello ROMEO!\"
#SBATCH -J \"compil\"

#SBATCH --error=out-compile-$test.%J-$blocks-$size-$procs.err
#SBATCH --output=out-compile-$test.%J-$blocks-$size-$procs.out

#SBATCH --reservation=jegurhem_5403
#SBATCH --qos=short
#SBATCH -p romeo

#SBATCH --time=00:30:00

#SBATCH -n 1
#SBATCH -N 1

. ~/env_yml-xmp_impi.sh

cd /scratch_p/jegurhem/test_xmp/app

hometmp=\$(pwd)

rm -r ../impl/impl_size*

cd ../impl/impl_SIZE
./changesize $size

cd ../impl_size$size
./changep $procs $dis1 $dis2

cd impl_p$procs/

sed -i \"s/lang=\\\"XMP\\\"/lang=\\\"XMP\\\" libs=\\\"include_lib_intel\\\"/g\" *
./compile

cd \$hometmp

yml_compiler $test.query

omrpc-register-yml $test.query.yapp | grep ^$test > stubs
echo \" \" >> stubs

cp stubs  ~/.omrpc_registry

sbatch submit-run-$test-$blocks-$size-$procs.sh
" > submit-compile-$test-$blocks-$size-$procs.sh

