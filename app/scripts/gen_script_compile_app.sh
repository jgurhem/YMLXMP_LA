#!/bin/sh
app=$1
blocks=$2

echo "

if [ ! -f model/$app.query ]
then
	echo \"model/$app.query doesn't exist !\"
	exit 1
fi

sed -e \"s/BC/$blocks/g\" model/$app.query > $app.query

yml_compiler $app.query

if [ ! -f $app.query.yapp ]
then
	echo \"$app.query didn't compile properly !\"
	exit 1
fi

omrpc-register-yml $app.query.yapp | grep ^$app > stubs
echo \" \" >> stubs

cp stubs  ~/.omrpc_registry
"

