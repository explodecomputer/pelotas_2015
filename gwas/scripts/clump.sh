#!/bin/bash

# the ../ is a shortcut for specifying the directory above the current working directory
# an alternative way of writing ../ would be to write the full path, in this instance:
# ~/pelotas_2015/gwas/ is being substitute by ../

# The data directory and the work directory are imported from the ../../config file using this line of code. They are stored in the variables ${datadir} and ${workdir}

source ../../config

# Take GWAS results and extract only independent SNPs

# --bfile       Location of genotype data
# --clump       Perform clumping
# --clump-kb    Maximum radius to look for SNPs in LD
# --clump-r2    LD exclusion threshol
# --clump-p1    Significance threshold
# --out         Location to save results


# Hypertension
plink1.90 \
	--bfile ${datadir}/geno_qc \
	--clump ${datadir}/results/hypertension.assoc.logistic.add \
	--clump-kb 5000 \
	--clump-r2 0.0001 \
	--clump-p1 5e-8 \
	--out ../results/hypertension


# BMI
plink1.90 \
	< what goes here? >
	< what goes here? >
	< what goes here? >
	< what goes here? >
	< what goes here? >
	< what goes here? >

# CRP
plink1.90 \
	< what goes here? >
	< what goes here? >
	< what goes here? >
	< what goes here? >
	< what goes here? >
	< what goes here? >
