#!/bin/bash

source ../../config

# Perform GWAS on BMI, hypertension, CRP
# This uses an approximation to linear regression to run much faster than a normal GWAS
# The approximation does not allow covariates to be included in the GWAS


# BMI

plink1.90 \
	--bfile ${datadir}/geno_qc \
	--assoc \
	--pheno ../data/phen.txt \
	--mpheno 1 \
	--out ../results/bmi


# CRP

plink1.90 \
	--bfile ${datadir}/geno_qc \
	--assoc \
	--pheno ../data/phen.txt \
	--mpheno 2 \
	--out ../results/crp


# Hypertension

plink1.90 \
	--bfile ${datadir}/geno_qc \
	--assoc \
	--pheno ../data/phen.txt \
	--mpheno 3 \
	--out ../results/hypertension


# We can use an appropriate linear model with covariates included instead
# This way we can account for population stratification

# BMI

plink1.90 \
	--bfile ${datadir}/geno_qc \
	--linear \
	--covar ../data/covs.txt \
	--pheno ../data/phen.txt \
	--mpheno 1 \
	--out ../results/bmi


# CRP

plink1.90 \
	--bfile ${datadir}/geno_qc \
	--linear \
	--covar ../data/covs.txt \
	--pheno ../data/phen.txt \
	--mpheno 2 \
	--out ../results/crp


# Hypertension

plink1.90 \
	--bfile ${datadir}/geno_qc \
	--logistic \
	--covar ../data/covs.txt \
	--pheno ../data/phen.txt \
	--mpheno 3 \
	--out ../results/hypertension

