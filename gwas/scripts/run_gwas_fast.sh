#!/bin/bash

# the ../ is a shortcut for specifying the directory above the current working directory
# an alternative way of writing ../ would be to write the full path, in this instance:
# ~/pelotas_2015/gwas/ is being substitute by ../

# The data directory and the work directory are imported from the ../../config file using this line of code. They are stored in the variables ${datadir} and ${workdir}

source ../../config


# Perform GWAS on BMI, hypertension, CRP
# This uses an approximation to linear regression to run much faster than a normal GWAS
# The approximation does not allow covariates to be included in the GWAS!


# --bfile     The location of the genotype data
# --assoc     Run fast association
# --pheno     The location of the phenotype data
# --mpheno    The column of the phenotype file to use as the phenotype
# --out       Where to store the results file



# BMI

plink1.90 \
	--bfile ${datadir}/geno_unclean \
	--assoc \
	--pheno ../data/phen.txt \
	--mpheno 1 \
	--out ../results/bmi       


# CRP

plink1.90 \
	< what goes here? >
	< what goes here? >
	< what goes here? >
	< what goes here? >
	< what goes here? >


# Hypertension

plink1.90 \
	< what goes here? >
	< what goes here? >
	< what goes here? >
	< what goes here? >
	< what goes here? >
