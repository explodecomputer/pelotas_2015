#!/bin/bash

source ../../config


# Bivariate analysis
# Each one takes about 14 minutes with 8 cores

# BMI vs CRP
gcta64 \
	--grm ../data/geno_qc \
	--reml-bivar 1 2 \
	--pheno ../../gwas/data/phen.txt \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/bmi_crp \
	--thread-num 8

# BMI vs hypertension
gcta64 \
	--grm ../data/geno_qc \
	--reml-bivar 1 3 \
	--pheno ../../gwas/data/phen.txt \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/bmi_hypertension \
	--thread-num 8

# CRP vs hypertension
gcta64 \
	--grm ../data/geno_qc \
	--reml-bivar 1 2 \
	--pheno ../../gwas/data/phen.txt \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/crp_hypertension \
	--thread-num 8
