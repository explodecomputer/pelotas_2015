#!/bin/bash

source ../../config

# Probably takes about 5 minutes

plink1.90 \
	--bfile ${datadir}/geno_qc \
	--make-grm-bin \
	--maf 0.01 \
	--out ../data/geno_qc

