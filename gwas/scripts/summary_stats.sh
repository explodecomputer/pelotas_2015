#!/bin/bash

# the ../ is a shortcut for specifying the directory above the current working directory
# an alternative way of writing ../ would be to write the full path, in this instance:
# ~/pelotas_2015/gwas/ is being substitute by ../

# The data directory and the work directory are imported from the ../../config file using this line of code. They are stored in the variables ${datadir} and ${workdir}

source ../../config

# Options:
# --bfile    Location of genotype file
# --freq     Estimate allele frequencies
# --missing  Missingness for each SNP and person
# --hardy    Estimate HWE departure
# --out      Where to save the results


# Get summary statistics on original data
plink1.90 \
	--bfile ${datadir}/geno_unclean \
	--freq \
	--missing \
	--hardy \
	--out ../results/geno_unclean      


# This will run an R script that will generate some graphs that summarise the HWE and frequencies
R --no-save < summary_stats.R

# The graphs can be found in the 
# ../images/unclean_hwe.png
# ../images/unclean_maf.pdf
# ../images/unclean_maf2.png
