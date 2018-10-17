#!/bin/sh

if [ $# -ne 10 ]
then
	echo wrong number of parameters !
	exit 1
fi

app=$1
blocks=$2
size=$3
procs=$4
dis1=$5
dis2=$6
nbhosts=$7
nbnodes=$8
machine=$9
savedir=${10}

if [ $machine = "bash" ]
then
	echo "#!/bin/bash" > compile.sh
	bash scripts/gen_script_compile_comp.sh $blocks $size $procs $dis1 $dis2 $savedir >> compile.sh
	bash scripts/gen_script_compile_app.sh $app $blocks >> compile.sh
	echo "#!/bin/bash" > launch.sh
	bash scripts/gen_script_run.sh $app $nbhosts >> launch.sh
	bash scripts/gen_process_analyse.sh $app $blocks $size $procs $nbhosts $nbnodes $machine >> launch.sh
	echo "rm -r run*" >> launch.sh
	echo "rm out-run-$app*" >> launch.sh
	echo "rm core.*" >> launch.sh

fi

if [ $machine = "Poincare" ]
then
	echo "#!/bin/bash" > submit-run-$app-$blocks-$size-$procs.sh
	bash scripts/gen_header_run_poincare.sh $app $nbhosts $nbnodes >> submit-run-$app-$blocks-$size-$procs.sh
	echo ". ~/env_yml-xmp_impi.sh" >> submit-run-$app-$blocks-$size-$procs.sh
	bash scripts/gen_script_run.sh $app $nbhosts >> submit-run-$app-$blocks-$size-$procs.sh
	bash scripts/gen_process_analyse.sh $app $blocks $size $procs $nbhosts $nbnodes $machine >> submit-run-$app-$blocks-$size-$procs.sh
	bash scripts/gen_process_tar.sh $app $blocks $size $procs >> submit-run-$app-$blocks-$size-$procs.sh
	bash scripts/gen_process_next.sh >> submit-run-$app-$blocks-$size-$procs.sh

	echo "#!/bin/bash" > submit-compile-$app-$blocks-$size-$procs.sh
	bash scripts/gen_header_compile_poincare.sh $app $blocks $size $procs >> submit-compile-$app-$blocks-$size-$procs.sh
	echo ". ~/env_yml-xmp_impi.sh" >> submit-compile-$app-$blocks-$size-$procs.sh
	bash scripts/gen_script_compile_app.sh $app $blocks >> submit-compile-$app-$blocks-$size-$procs.sh
	echo "llsubmit submit-run-$app-$blocks-$size-$procs.sh" >> submit-compile-$app-$blocks-$size-$procs.sh

	echo "#!/bin/bash" > submit-compile-comp-$blocks-$size-$procs.sh
	bash scripts/gen_header_compile_poincare.sh comp $blocks $size $procs >> submit-compile-comp-$blocks-$size-$procs.sh
	echo ". ~/env_yml-xmp_impi.sh" >> submit-compile-comp-$blocks-$size-$procs.sh
	bash scripts/gen_script_compile_comp.sh $blocks $size $procs $dis1 $dis2 /gpfsdata/jgurhem/res >> submit-compile-comp-$blocks-$size-$procs.sh
	echo "llsubmit submit-compile-$app-$blocks-$size-$procs.sh" >> submit-compile-comp-$blocks-$size-$procs.sh

	llsubmit submit-compile-comp-$blocks-$size-$procs.sh
fi

if [ $machine = "Romeo" ]
then
	echo "Romeo script (todo)"
fi

