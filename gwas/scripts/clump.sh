#!/bin/bash

source ../../config

# Perform GWAS on BMI, hypertension, CRP

plink1.90 \
	--bfile ${datadir}/geno_qc \
	--clump ${datadir}/results/bmi.assoc.linear.add \
	--clump-kb 5000 \
	--clump-r2 0.0001 \
	--clump-p1 5e-8 \
	--out ../results/bmi

plink1.90 \
	--bfile ${datadir}/geno_qc \
	--clump ${datadir}/results/crp.assoc.linear.add \
	--clump-kb 5000 \
	--clump-r2 0.0001 \
	--clump-p1 5e-8 \
	--out ../results/crp

plink1.90 \
	--bfile ${datadir}/geno_qc \
	--clump ${datadir}/results/hypertension.assoc.logistic.add \
	--clump-kb 5000 \
	--clump-r2 0.0001 \
	--clump-p1 5e-8 \
	--out ../results/hypertension
