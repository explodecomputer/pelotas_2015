#!/bin/bash

source ../../config

# Perform GWAS on BMI, hypertension, CRP

plink1.90 \
	--bfile ${datadir}/geno_qc \
	--clump ../results/bmi.assoc.linear.add \
	--clump-kb 1000 \
	--clump-r2 0.1 \
	--out ../results/bmi

plink1.90 \
	--bfile ${datadir}/geno_qc \
	--clump ../results/crp.assoc.linear.add \
	--clump-kb 1000 \
	--clump-r2 0.1 \
	--out ../results/crp

plink1.90 \
	--bfile ${datadir}/geno_qc \
	--clump ../results/hypertension.assoc.logistic.add \
	--clump-kb 1000 \
	--clump-r2 0.1 \
	--out ../results/hypertension
