#!/bin/bash

source ../../config


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
