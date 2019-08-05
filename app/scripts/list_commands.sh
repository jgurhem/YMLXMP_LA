#!/bin/sh

echocmd(){
	echo bash compile_in_batch.sh $@
}

f=()
intfact(){
	n=$1
	f=()
	for prim in 2 3 5 7 11 13 17 19
	do
		let "d = n % prim"
		while [ $d -eq 0 ]
		do
			f+=($prim)
			let "n = n / prim"
			let "d = n % prim"
		done
		if [ $n -eq 1 ]
		then
			break
		fi
		if [ $[$prim*$prim] -gt $n ]
		then
			f+=($n)
			break
		fi
	done
}


nbnodes=$3
nbhosts=$(($nbnodes * 16 + 1))
nbnodes=$(($nbnodes + 1))
machine=Poincare
jobtype=LoadLeveler
savedir="/gpfsdata/jgurhem/res/"
resfile=$4

app=$1
matrixSize=$2
maxBlock=8
maxPPT=$(($nbhosts - 1))
minPPT=$(($3 * 2))

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
procs=( )
while [ $i -le $maxPPT ]
do
	procs+=($i)
	intfact $i
	a=1
	b=1
	for fp in ${f[*]}
	do
		if [ $a -lt $b ]
		then
			a=$[$a*$fp]
		else
			b=$[$b*fp]
		fi
	done
	if [ $a -lt $b ]
	then
		tmp=$a
		a=$b
		b=$tmp
	fi
	d1+=($a)
	d2+=($b)
	i=$[$i*2]
done

echo blocks : ${blocks[*]} >&2
echo sizes : ${sizes[*]} >&2
echo procs : ${procs[*]} >&2
#echo d1 : ${d1[*]}
#echo d2 : ${d2[*]}


for myapp in $app
do
	i=1
	for item in ${blocks[*]}
	do
		if [ $item -eq 1 ]
		then
			echocmd $myapp $item ${sizes[0]} ${procs[${#procs[*]} - 1]} ${d1[${#d1[*]} - 1]} ${d2[${#d2[*]} - 1]} $nbhosts $nbnodes $machine $jobtype $savedir $resfile 1
			continue
		fi
		for (( p = 0; p < ${#procs[*]} - 1; p++ ))
		do
			echocmd $myapp $item ${sizes[$i]} ${procs[$p]} ${d1[$p]} ${d2[$p]} $nbhosts $nbnodes $machine $jobtype $savedir $resfile 1
		done
		i=$[$i+1]
	done
done
