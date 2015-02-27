#!/bin/bash

source ../../config

# Perform GWAS on BMI, hypertension, CRP
# We can use an appropriate linear model with covariates included
# This way we can account for population stratification
# Takes much longer than the approximate statistics



# --bfile     The location of the genotype data
# --linear    Run full linear model
# --covar     Location of covariates to be included
# --pheno     Location of phenotype file
# --mpheno    Which column in phen file to analyse
# --out       Where to save results



# BMI

plink1.90 \
	--bfile ${datadir}/geno_qc \   
	--linear \                     
	--covar ../data/covs.txt \     
	--pheno ../data/phen.txt \     
	--mpheno 1 \                   
	--out ${datadir}/results/bmi   

# The output has a row for each SNP's additive effect
# but also the effects of all covariates on all SNPs.
# We just need the additive effects
# this code can be used to extract the first row 
# and all subsequent rows that have "ADD" in them

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

awk 'NR==1 || /ADD/' ${datadir}/results/hypertension.assoc.logistic | grep -v "NA" | less > ${datadir}/results/hypertension.assoc.logistic.add
