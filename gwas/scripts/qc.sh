#!/bin/bash

source ../../config

# Perform simple QC
# Don't need to run this!!

plink1.90 \
	--bfile ${datadir}/geno \
	--maf 0.01 \
	--hwe 1e-6 \
	--geno 0.05 \
	--make-bed \
	--out ${datadir}/geno_qc


# Get summary statistics

plink1.90 \
	--bfile ${datadir}/geno_qc \
	--freq \
	--missing \
	--hardy \
	--out ../results/geno_qc


