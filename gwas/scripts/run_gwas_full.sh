#!/bin/bash

source ../../config

# Perform GWAS on BMI, hypertension, CRP
# We can use an appropriate linear model with covariates included
# This way we can account for population stratification
# Takes much longer than the approximate statistics

# BMI

plink1.90 \
	--bfile ${datadir}/geno_qc \
	--linear \
	--covar ../data/covs.txt \
	--pheno ../data/phen.txt \
	--mpheno 1 \
	--out ${datadir}/results/bmi

awk 'NR==1 || /ADD/' ${datadir}/results/bmi.assoc.linear > ${datadir}/results/bmi.assoc.linear.add

# CRP

plink1.90 \
	--bfile ${datadir}/geno_qc \
	--linear \
	--covar ../data/covs.txt \
	--pheno ../data/phen.txt \
	--mpheno 2 \
	--out ${datadir}/results/crp

awk 'NR==1 || /ADD/' ${datadir}/results/crp.assoc.linear > ${datadir}/results/crp.assoc.linear.add

# Hypertension

plink1.90 \
	--bfile ${datadir}/geno_qc \
	--logistic \
	--covar ../data/covs.txt \
	--pheno ../data/phen.txt \
	--mpheno 3 \
	--out ${datadir}/results/hypertension

awk 'NR==1 || /ADD/' ${datadir}/results/hypertension.assoc.logistic | grep -L "NA" > ${datadir}/results/hypertension.assoc.logistic.add
