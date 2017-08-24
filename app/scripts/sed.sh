for file in `ls model/*.query`
do
	sed -e "s/BC/4/g" $file > $file
done
