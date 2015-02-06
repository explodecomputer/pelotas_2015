#!/bin/bash

set -e

source ../../config
impfile="${workdir}/data/geno/geno_1kg"
genofile="${workdir}/data/geno/geno"
scratchdir="${workdir}/data/scratch"



## GWAS results

plink1.90 --bfile ${genofile} --score ~/repo/phenome_mining/profiles/gwas/diastolic_blood_pressure.txt --out ${scratchdir}/dbp

plink1.90 --bfile ${genofile} --score ~/repo/phenome_mining/profiles/gwas/systolic_blood_pressure.txt --out ${scratchdir}/sbp

plink1.90 --bfile ${genofile} --score ~/repo/phenome_mining/profiles/gwas/bmi.txt --out ${scratchdir}/bmi

plink1.90 --bfile ${genofile} --score ~/repo/phenome_mining/profiles/gwas/crp.txt --out ${scratchdir}/crp


## Polygenic effects

R --no-save --args ${genofile}.bim 10000 ${scratchdir}/bp_poly.effects < ${scratchdir}/polygenic_effects.R
plink1.90 --bfile ${genofile} --score ${scratchdir}/bp_poly.effects --out ${scratchdir}/bp_poly

R --no-save --args ${genofile}.bim 10000 ${scratchdir}/bmi_poly.effects < ${scratchdir}/polygenic_effects.R
plink1.90 --bfile ${genofile} --score ${scratchdir}/bmi_poly.effects --out ${scratchdir}/bmi_poly

R --no-save --args ${genofile}.bim 10000 ${scratchdir}/crp_poly.effects < ${scratchdir}/polygenic_effects.R
plink1.90 --bfile ${genofile} --score ${scratchdir}/crp_poly.effects --out ${scratchdir}/crp_poly


