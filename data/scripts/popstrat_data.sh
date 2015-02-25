#!/bin/bash

set -e

source ../../config

scratchdir="${workdir}/data/scratch"
outfile="${workdir}/data/geno/geno_1kg"
outfile2="${workdir}/data/geno/geno"

# get data from
# ftp://ftp.ncbi.nlm.nih.gov/hapmap/genotypes/2009-01_phaseIII/plink_format/
# turn into bed file
# extract SNPs and merge with sample data

plink1.90 --bfile hapmap3_r2_b36_fwd.consensus.qc.poly --extract ~/repo/pelotas_2015/data/scratch/snpchiplist.txt --make-bed --out ${scratchdir}/hm3_extr

plink1.90 --bfile ${outfile2} --bmerge ${scratchdir}/hm3_extr --make-bed --out ${scratchdir}/als_hm3

plink1.90 --bfile ${scratchdir}/hm3_extr --exclude ${scratchdir}/als_hm3-merge.missnp --make-bed --out ${scratchdir}/hm3_extr2

plink1.90 --bfile ${outfile2} --bmerge ${scratchdir}/hm3_extr2 --make-bed --out ${scratchdir}/als_hm3


plink1.90 --bfile ${scratchdir}/als_hm3 --indep 50 10 1 --out ${scratchdir}/als_hm3

plink1.90 --bfile ${scratchdir}/als_hm3 --extract ${scratchdir}/als_hm3.prune.in --make-bed --out ${scratchdir}/als_hm3_pruned

plink1.90 --bfile ${scratchdir}/als_hm3_pruned --make-grm-bin --out ${scratchdir}/als_hm3_pruned

gcta64 --grm ${scratchdir}/als_hm3_pruned --pca 10 --out ${scratchdir}/als_hm3_pruned
