#!/bin/sh
echo "
if [ \$(cat todo | wc -l) != 0 ]
then
        \$(head -n 1 todo)
        sed -i '1d' todo
fi
"

