#!/bin/bash

source ../../config


# Get SNP IDs from chr1-8
awk '{ if ($1 < 9) print $2}' ${datadir}/geno_qc.bim > ../data/chr1-8.txt

# Create GRM using SNPs only from chr1-8
plink1.90 \
	--bfile ${datadir}/geno_qc \
	--make-grm-bin \
	--maf 0.01 \
	--extract ../data/chr1-8.txt \
	--out ../data/geno_1-8

# Create GRM using SNPs only from chr9-22
plink1.90 \
	--bfile ${datadir}/geno_qc \
	--make-grm-bin \
	--maf 0.01 \
	--exclude ../data/chr1-8.txt \
	--out ../data/geno_9-22

# Create the MGRM file (contains the filepaths for the two GRMs above)
echo -e "${workdir}/whole_genome/data/geno_1-8\n${workdir}/whole_genome/data/geno_9-22" > ../data/mgrm.txt


# Perform REML using chr1-8 (partition1), chr9-22 (partition2), or both partitions together (partition)
# If there is pop strat influencing the trait then the SNPs will be confounded with common environmental effects
# The common environmental effect will be the same whether chr1-8 are used or chr9-22. 
# Therefore, the sum of estimates of h2 from chr1-8 and chr9-22 will be greater than the estimate from the combined data.
# This can be used as a test to see if pop strat is being accounted for.

# BMI with covariates
gcta64 \
	--grm ../data/geno_1-8 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 1 \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/partition1_bmi_covar \
	--thread-num 8

gcta64 \
	--grm ../data/geno_9-22 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 1 \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/partition2_bmi_covar \
	--thread-num 8

gcta64 \
	--mgrm ../data/mgrm.txt \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 1 \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/partition_bmi_covar \
	--thread-num 8

# BMI without covariates
gcta64 \
	--grm ../data/geno_1-8 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 1 \
	--out ../results/partition1_bmi_nocovar \
	--thread-num 8

gcta64 \
	--grm ../data/geno_9-22 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 1 \
	--out ../results/partition2_bmi_nocovar \
	--thread-num 8

gcta64 \
	--mgrm ../data/mgrm.txt \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 1 \
	--out ../results/partition_bmi_nocovar \
	--thread-num 8


# CRP with covariates
gcta64 \
	--grm ../data/geno_1-8 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 2 \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/partition1_crp_covar \
	--thread-num 8

gcta64 \
	--grm ../data/geno_9-22 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 2 \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/partition2_crp_covar \
	--thread-num 8

gcta64 \
	--mgrm ../data/mgrm.txt \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 2 \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/partition_crp_covar \
	--thread-num 8

# CRP without covariates
gcta64 \
	--grm ../data/geno_1-8 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 2 \
	--out ../results/partition1_crp_nocovar \
	--thread-num 8

gcta64 \
	--grm ../data/geno_9-22 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 2 \
	--out ../results/partition2_crp_nocovar \
	--thread-num 8

gcta64 \
	--mgrm ../data/mgrm.txt \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 2 \
	--out ../results/partition_crp_nocovar \
	--thread-num 8

# Hypertension with covariates
gcta64 \
	--grm ../data/geno_1-8 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 3 \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/partition1_hypertension_covar \
	--thread-num 8

gcta64 \
	--grm ../data/geno_9-22 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 3 \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/partition2_hypertension_covar \
	--thread-num 8

gcta64 \
	--mgrm ../data/mgrm.txt \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 3 \
	--qcovar ../../gwas/data/covs.txt \
	--out ../results/partition_hypertension_covar \
	--thread-num 8

# Hypertension without covariates
gcta64 \
	--grm ../data/geno_1-8 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 3 \
	--out ../results/partition1_hypertension_nocovar \
	--thread-num 8

gcta64 \
	--grm ../data/geno_9-22 \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 3 \
	--out ../results/partition2_hypertension_nocovar \
	--thread-num 8

gcta64 \
	--mgrm ../data/mgrm.txt \
	--reml \
	--reml-no-lrt \
	--pheno ../../gwas/data/phen.txt \
	--mpheno 3 \
	--out ../results/partition_hypertension_nocovar \
	--thread-num 8
