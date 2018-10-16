#!/bin/sh
array=( blockLU gaussJordan_inv blockGaussJordan blockGauss blockLUsolveLS )
app=$1
blocks=$2

echo "
sed -e \"s/BC/$blocks/g\" model/$app.query > $app.query

yml_compiler $app.query

omrpc-register-yml $app.query.yapp | grep ^$app > stubs
echo \" \" >> stubs

cp stubs  ~/.omrpc_registry
"

