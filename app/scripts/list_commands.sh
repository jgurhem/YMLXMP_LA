#!/bin/sh

echocmd(){
	echo bash compile_in_batch.sh $@
}

nbhosts=1025
nbnodes=65
machine=Poincare
savedir="/tmp"


app=$1
matrixSize=$2
maxBlock=16
minPPT=16
maxPPT=1024
minD1=4
minD2=4


i=1
blocks=( )
sizes=( )
while [ $i -le $maxBlock ]
do
	blocks+=($i)
	sizes+=($[$matrixSize/$i])
	i=$[$i*2]
done

i=$minPPT
a=$minD1
b=$minD2
alt=1
procs=( )
while [ $i -le $maxPPT ]
do
	procs+=($i)
	d1+=($a)
	d2+=($b)
	i=$[$i*2]
	if [ $alt -eq 1 ]
	then
		alt=0
		a=$[$a*2]
	else
		b=$[$b*2]
		alt=1
	fi
done

echo blocks : ${blocks[*]}
echo sizes : ${sizes[*]}
echo procs : ${procs[*]}
echo d1 : ${d1[*]}
echo d2 : ${d2[*]}


for myapp in $app
do
	i=1
	for item in ${blocks[*]}
	do
		if [ $item -eq 1 ]
		then
			echocmd $myapp $item ${sizes[0]} ${procs[${#procs[*]} - 1]} ${d1[${#d1[*]} - 1]} ${d2[${#d2[*]} - 1]} $nbhosts $nbnodes $machine $savedir
			continue
		fi
		for (( p = 0; p < ${#procs[*]} - 1; p++ ))
		do
			echocmd $myapp $item ${sizes[$i]} ${procs[$p]} ${d1[$p]} ${d2[$p]} $nbhosts $nbnodes $machine $savedir
		done
		i=$[$i+1]
	done
done
