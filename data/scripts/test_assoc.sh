#!/bin/bash

set -e

source ../../config
genofile="${workdir}/data/geno/geno"
phenfile="${workdir}/data/phen/phen.txt"
scratchdir="${workdir}/data/scratch"

mkdir -p ${scratch}/testresults

# Perform GWAS on BMI, hypertension, CRP

plink1.90 --bfile ${genofile} --assoc --pheno ${phenfile} --mpheno 1 --out ${scratchdir}/testresults/bmi
gcta64 --thread-num 10 --grm ${genofile} --reml --reml-no-lrt --pheno ${phenfile} --mpheno 1 --out ${scratchdir}/testresults/bmi
Rscript ${workdir}/gwas/scripts/gwas_graphs.R ${scratchdir}/testresults/bmi.qassoc BMI FALSE


plink1.90 --bfile ${genofile} --assoc --pheno ${phenfile} --mpheno 4 --out ${scratchdir}/testresults/crp
gcta64 --thread-num 10 --grm ${genofile} --reml --reml-no-lrt --pheno ${phenfile} --mpheno 4 --out ${scratchdir}/testresults/crp
Rscript ${workdir}/gwas/scripts/gwas_graphs.R crp.qassoc CRP


plink1.90 --bfile ${genofile} --assoc --pheno ${phenfile} --mpheno 5 --out ${scratchdir}/testresults/hypertension
gcta64 --thread-num 10 --grm ${genofile} --reml --reml-no-lrt --pheno ${phenfile} --mpheno 5 --out ${scratchdir}/testresults/hypertension
Rscript ${workdir}/gwas/scripts/gwas_graphs.R hypertension.assoc Hypertension


plink1.90 --bfile ${genofile} --clump ${scratchdir}/testresults/bmi.qassoc --clump-kb 1000 --clump-r2 0.1 --out ${scratchdir}/testresults/bmi
plink1.90 --bfile ${genofile} --clump ${scratchdir}/testresults/crp.qassoc --clump-kb 1000 --clump-r2 0.1 --out ${scratchdir}/testresults/crp
plink1.90 --bfile ${genofile} --clump ${scratchdir}/testresults/hypertension.assoc --clump-kb 1000 --clump-r2 0.1 --out ${scratchdir}/testresults/hypertension
