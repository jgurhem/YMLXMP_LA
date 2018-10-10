#!/bin/sh
array=( blockLU gaussJordan_inv blockGaussJordan blockGauss blockLUsolveLS )
app=$1

blocks=$2
size=$3
procs=$4
dis1=$5
dis2=$6

#nbhosts=17
#nbnodes=2
nbhosts=1040
nbnodes=65
#nbhosts=336
#nbnodes=21

machine="Poincare"

if [ $machine = "Poincare" ]
then
	echo "#!/bin/bash" > submit-run-$app-$blocks-$size-$procs.sh
	./scripts/gen_header_run_poincare.sh $app $nbhosts $nbnodes >> submit-run-$app-$blocks-$size-$procs.sh
	./scripts/gen_script_run.sh $app $nbhosts >> submit-run-$app-$blocks-$size-$procs.sh
	./scripts/gen_process_run.sh $app $blocks $size $procs $nbhosts $nbnodes $machine >> submit-run-$app-$blocks-$size-$procs.sh

	echo "#!/bin/bash" > submit-compile-$app-$blocks-$size-$procs.sh
	./scripts/gen_header_compile_poincare.sh $app $blocks $size $procs >> submit-compile-$app-$blocks-$size-$procs.sh
	./scripts/gen_script_compile_app.sh $app $blocks >> submit-compile-$app-$blocks-$size-$procs.sh
	echo "llsubmit submit-run-$app-$blocks-$size-$procs.sh" >> submit-compile-$app-$blocks-$size-$procs.sh

	echo "#!/bin/bash" > submit-compile-comp-$blocks-$size-$procs.sh
	./scripts/gen_header_compile_poincare.sh comp $blocks $size $procs >> submit-compile-comp-$blocks-$size-$procs.sh
	./scripts/gen_script_compile_comp.sh $blocks $size $procs $dis1 $dis2 >> submit-compile-comp-$blocks-$size-$procs.sh
	echo "llsubmit submit-compile-$app-$blocks-$size-$procs.sh" >> submit-compile-comp-$blocks-$size-$procs.sh

	llsubmit submit-compile-comp-$blocks-$size-$procs.sh
fi

if [ $machine = "r" ]
then
	echo "#!/bin/bash" > submit-run-$app-$blocks-$size-$procs.sh
	. scripts/gen_header_run.sh $app $blocks $size $procs $dis1 $dis2 $nbhosts $nbnodes >> submit-run-$app-$blocks-$size-$procs.sh
	. scripts/gen_script_run.sh $app $blocks $size $procs $dis1 $dis2 $nbhosts $nbnodes >> submit-run-$app-$blocks-$size-$procs.sh
	. scripts/gen_process_run.sh $app $blocks $size $procs $dis1 $dis2 $nbhosts $nbnodes >> submit-run-$app-$blocks-$size-$procs.sh

	echo "#!/bin/bash" > submit-compile-$blocks-$size-$procs.sh
	. scripts/gen_header_compile.sh $blocks $size $procs >> submit-compile-$blocks-$size-$procs.sh
	. scripts/gen_script_compile.sh $blocks $size $procs $dis1 $dis2 >> submit-compile-$blocks-$size-$procs.sh
	echo "sbatch submit-run-$app-$blocks-$size-$procs.sh" >> submit-compile-$blocks-$size-$procs.sh

	#sbatch submit-compile-$blocks-$size-$procs.sh
fi

