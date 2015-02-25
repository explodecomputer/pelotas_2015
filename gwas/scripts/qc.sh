#!/bin/bash

source ../../config



############################
# Don't need to run this!! #
############################

# This is how to filter genotype data on maf, hwe and missingness

# plink1.90 \
# 	--bfile ${datadir}/geno_unclean \
# 	--maf 0.01 \
# 	--hwe 1e-6 \
# 	--geno 0.05 \
# 	--mind 0.05 \
# 	--make-bed \
# 	--out ${datadir}/geno_qc



###################################
# Don't need to run this either!! #
###################################

# This is how to calculate the principal components from genotype data

# plink1.90 \
# 	--bfile ${datadir}/geno_qc \
# 	--make-grm-bin \
# 	--maf 0.01 \
# 	--out ${datadir}/geno_qc

# gcta64 \
# 	--grm ${datadir}/geno_qc \
# 	--pca \
# 	--out ../results/geno_qc
