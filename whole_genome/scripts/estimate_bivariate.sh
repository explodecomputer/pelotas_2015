#!/bin/bash

source ../../config


# Bivariate analysis
# Each one takes about 20 minutes with 8 cores

# BMI vs CRP
gcta64 \
	--grm ../data/geno_qc \
	--reml-bivar 1 2 \
	--pheno ../../gwas/data/phen.txt \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/bivariate_bmi_crp \
	--thread-num 8

# BMI vs hypertension
gcta64 \
	--grm ../data/geno_qc \
	--reml-bivar 1 3 \
	--pheno ../../gwas/data/phen.txt \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/bivariate_bmi_hypertension \
	--thread-num 8

# CRP vs hypertension
gcta64 \
	--grm ../data/geno_qc \
	--reml-bivar 2 3 \
	--pheno ../../gwas/data/phen.txt \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/bivariate_crp_hypertension \
	--thread-num 8
