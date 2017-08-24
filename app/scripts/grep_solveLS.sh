grep -v -E "^host|^Task|^--" run1/exec_log | sed -E '/genMat|prodDiffMV|genVect|prodDiff|prodMat2|inversion/,+9d'
