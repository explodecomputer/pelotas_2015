#!/bin/bash

source ../../config

awk '{ if ($1 < 9) print $2}' ${datadir}/geno_qc.bim > ../data/chr1-8.txt

plink1.90 \
	--bfile ${datadir}/geno_qc \
	--make-grm-bin \
	--maf 0.01 \
	--extract ../data/chr1-8.txt \
	--out ../data/geno_1-8

plink1.90 \
	--bfile ${datadir}/geno_qc \
	--make-grm-bin \
	--maf 0.01 \
	--exclude ../data/chr1-8.txt \
	--out ../data/geno_9-22


echo -e "${workdir}/whole_genome/data/geno_1-8\n${workdir}/whole_genome/data/geno_9-22" > ../data/mgrm.txt


# With covariates

# BMI with covariates
gcta64 \
	--grm ../data/geno_1-8 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 1 \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/chr1-8_bmi_covar \
	--thread-num 8

gcta64 \
	--grm ../data/geno_9-22 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 1 \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/chr9-22_bmi_covar \
	--thread-num 8

gcta64 \
	--mgrm ../data/mgrm.txt \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 1 \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/chr1-22_bmi_covar \
	--thread-num 8

# BMI without covariates
gcta64 \
	--grm ../data/geno_1-8 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 1 \
	--out ../results/chr1-8_bmi_covar \
	--thread-num 8

gcta64 \
	--grm ../data/geno_9-22 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 1 \
	--out ../results/chr9-22_bmi_covar \
	--thread-num 8

gcta64 \
	--mgrm ../data/mgrm.txt \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 1 \
	--out ../results/chr1-22_bmi_covar \
	--thread-num 8


# CRP with covariates
gcta64 \
	--grm ../data/geno_1-8 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 2 \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/chr1-8_crp_covar \
	--thread-num 8

gcta64 \
	--grm ../data/geno_9-22 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 2 \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/chr9-22_crp_covar \
	--thread-num 8

gcta64 \
	--mgrm ../data/mgrm.txt \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 2 \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/chr1-22_crp_covar \
	--thread-num 8

# CRP without covariates
gcta64 \
	--grm ../data/geno_1-8 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 2 \
	--out ../results/chr1-8_crp_covar \
	--thread-num 8

gcta64 \
	--grm ../data/geno_9-22 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 2 \
	--out ../results/chr9-22_crp_covar \
	--thread-num 8

gcta64 \
	--mgrm ../data/mgrm.txt \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 2 \
	--out ../results/chr1-22_crp_covar \
	--thread-num 8

# Hypertension with covariates
gcta64 \
	--grm ../data/geno_1-8 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 3 \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/chr1-8_hypertension_covar \
	--thread-num 8

gcta64 \
	--grm ../data/geno_9-22 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 3 \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/chr9-22_hypertension_covar \
	--thread-num 8

gcta64 \
	--mgrm ../data/mgrm.txt \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 3 \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/chr1-22_hypertension_covar \
	--thread-num 8

# Hypertension without covariates
gcta64 \
	--grm ../data/geno_1-8 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 3 \
	--out ../results/chr1-8_hypertension_covar \
	--thread-num 8

gcta64 \
	--grm ../data/geno_9-22 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 3 \
	--out ../results/chr9-22_hypertension_covar \
	--thread-num 8

gcta64 \
	--mgrm ../data/mgrm.txt \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 3 \
	--out ../results/chr1-22_hypertension_covar \
	--thread-num 8
