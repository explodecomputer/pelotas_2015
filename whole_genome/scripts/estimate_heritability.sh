#!/bin/bash

# the ../ is a shortcut for specifying the directory above the current working directory
# an alternative way of writing ../ would be to write the full path, in this instance:
# ~/pelotas_2015/gwas/ is being substitute by ../

# The data directory and the work directory are imported from the ../../config file using this line of code. They are stored in the variables ${datadir} and ${workdir}

source ../../config


# We will calculate the SNP-heritability using GCTA
# It has very similar syntax to PLINK
# We specify the GRM, phenotype data, covariate data and it performs REML


# --grm           Location of the GRM files
# --reml          Perform REML analysis
# --reml-no-lrt   Don't run the likelihood test at the end of the REML
# --pheno         Location of phenotype file
# --mpheno        Which column in phen file to analyse
# --qcovar        Location of covariates file
# --out           Where to save output
# --thread        How many threads to use



# BMI
gcta64 \
	--grm ../data/geno_qc \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 1 \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/bmi_covar \
	--thread-num 8

gcta64 \
	--grm ../data/geno_qc \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 1 \
	--out ../results/bmi_nocovar \
	--thread-num 8


# CRP
gcta64 \
	--grm ../data/geno_qc \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 2 \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/crp_covar \
	--thread-num 8

gcta64 \
	--grm ../data/geno_qc \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 2 \
	--out ../results/crp_nocovar \
	--thread-num 8


# Hypertension
gcta64 \
	--grm ../data/geno_qc \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 3 \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/hypertension_covar \
	--thread-num 8

gcta64 \
	--grm ../data/geno_qc \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 3 \
	--out ../results/hypertension_nocovar \
	--thread-num 8
