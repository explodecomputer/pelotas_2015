#!/bin/bash

source ../../config

############################
# Don't need to run this!! #
############################

# This is how to calculate the principal components from genotype data
# They have actually already been calculated and are in the phen.RData file that you load in for QC etc
# This is just a script to show how PCs can be calculated for future reference

# First create the genetic relationship matrix from all SNPs
plink1.90 \
	--bfile ${datadir}/geno_qc \
	--make-grm-bin \
	--maf 0.01 \
	--out ${datadir}/geno_qc

# Next use the genetic relationship matrix to estimate principal components
gcta64 \
	--grm ${datadir}/geno_qc \
	--pca \
	--out ../results/geno_qc
