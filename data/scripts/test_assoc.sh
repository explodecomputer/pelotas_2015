#!/bin/bash

set -e

source ../../config
genofile="${workdir}/data/geno/geno"
phenfile="${workdir}/data/phen/phen.txt"
covfile="${workdir}/data/phen/covars.txt"
scratchdir="${workdir}/data/scratch"

mkdir -p ${scratchdir}/testresults

# Perform GWAS on BMI, hypertension, CRP

plink1.90 --bfile ${genofile} --assoc --pheno ${phenfile} --mpheno 1 --out ${scratchdir}/testresults/bmi
gcta64 --thread-num 10 --grm ${genofile} --reml --reml-no-lrt --pheno ${phenfile} --mpheno 1 --out ${scratchdir}/testresults/bmi
Rscript ${workdir}/gwas/scripts/gwas_graphs.R ${scratchdir}/testresults/bmi.qassoc BMI FALSE

plink1.90 --bfile ${genofile} --linear --pheno ${phenfile} --mpheno 1 --covar ${covfile} --out ${scratchdir}/testresults/bmi_cov --threads 10
gcta64 --thread-num 10 --grm ${genofile} --reml --reml-no-lrt --pheno ${phenfile} --mpheno 1 --qcovar ${covfile} --out ${scratchdir}/testresults/bmi_cov
Rscript ${workdir}/gwas/scripts/gwas_graphs.R ${scratchdir}/testresults/bmi_cov.assoc.linear BMI_cov FALSE


plink1.90 --bfile ${genofile} --assoc --pheno ${phenfile} --mpheno 1 --out ${scratchdir}/testresults/crp
gcta64 --thread-num 10 --grm ${genofile} --reml --reml-no-lrt --pheno ${phenfile} --mpheno 1 --out ${scratchdir}/testresults/crp
Rscript ${workdir}/gwas/scripts/gwas_graphs.R ${scratchdir}/testresults/crp.qassoc CRP FALSE

plink1.90 --bfile ${genofile} --linear --pheno ${phenfile} --mpheno 1 --covar ${covfile} --out ${scratchdir}/testresults/crp_cov --threads 10
gcta64 --thread-num 10 --grm ${genofile} --reml --reml-no-lrt --pheno ${phenfile} --mpheno 1 --qcovar ${covfile} --out ${scratchdir}/testresults/crp_cov
Rscript ${workdir}/gwas/scripts/gwas_graphs.R ${scratchdir}/testresults/crp_cov.assoc.linear CRP_cov FALSE


plink1.90 --bfile ${genofile} --assoc --pheno ${phenfile} --mpheno 1 --out ${scratchdir}/testresults/hypertension
gcta64 --thread-num 10 --grm ${genofile} --reml --reml-no-lrt --pheno ${phenfile} --mpheno 1 --out ${scratchdir}/testresults/hypertension
Rscript ${workdir}/gwas/scripts/gwas_graphs.R ${scratchdir}/testresults/hypertension.qassoc Hypertension FALSE

plink1.90 --bfile ${genofile} --logistic --pheno ${phenfile} --mpheno 1 --covar ${covfile} --out ${scratchdir}/testresults/hypertension_cov --threads 10
gcta64 --thread-num 10 --grm ${genofile} --reml --reml-no-lrt --pheno ${phenfile} --mpheno 1 --qcovar ${covfile} --out ${scratchdir}/testresults/hypertension_cov
Rscript ${workdir}/gwas/scripts/gwas_graphs.R ${scratchdir}/testresults/hypertension_cov.assoc.logistic Hypertension_cov FALSE


plink1.90 --bfile ${genofile} --clump ${scratchdir}/testresults/bmi_cov.assoc.linear --clump-kb 1000 --clump-r2 0.1 --out ${scratchdir}/testresults/bmi_cov
plink1.90 --bfile ${genofile} --clump ${scratchdir}/testresults/crp_cov.assoc.linear --clump-kb 1000 --clump-r2 0.1 --out ${scratchdir}/testresults/crp
plink1.90 --bfile ${genofile} --clump ${scratchdir}/testresults/hypertension.assoc.logistic --clump-kb 1000 --clump-r2 0.1 --out ${scratchdir}/testresults/hypertension

