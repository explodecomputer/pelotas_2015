#!/bin/bash

source ../../config

# Get summary statistics on original data

plink1.90 \
	--bfile ${datadir}/geno \
	--freq \
	--missing \
	--hardy \
	--out ../results/geno


# Perform simple QC
# Don't need to run this!!

plink1.90 \
	--bfile ${datadir}/geno \
	--maf 0.01 \
	--hwe 1e-6 \
	--geno 0.05 \
	--make-bed \
	--out ${datadir}/geno_qc


# Get summary statistics on QC'd data

plink1.90 \
	--bfile ${datadir}/geno_qc \
	--freq \
	--missing \
	--hardy \
	--out ../results/geno_qc


# Estimate principal components
# Don't need to run this either!!

plink1.90 \
	--bfile ${datadir}/geno_qc \
	--make-grm-bin \
	--maf 0.01 \
	--out ${datadir}/geno_qc

gcta64 \
	--grm ${datadir}/geno_qc \
	--pca \
	--out ../results/geno_qc
