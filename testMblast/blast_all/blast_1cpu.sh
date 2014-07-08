#!/bin/bash

# ----------------QSUB Parameters----------------- #
#PBS -S /bin/bash
#PBS -q default
#PBS -l nodes=1:ppn=1,mem=10000mb
# ----------------Load Modules-------------------- #
module load blast
# ----------------Your Commands------------------- #
$inputFile =
