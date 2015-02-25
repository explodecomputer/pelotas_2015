#!/bin/bash

source ../../config

# Get summary statistics on original data
plink1.90 \
	--bfile ${datadir}/geno_unclean \
	--freq \
	--missing \
	--hardy \
	--out ../results/geno_unclean


# This will generate some graphs that summarise the HWE and frequencies
R --no-save < summary_stats.sh
