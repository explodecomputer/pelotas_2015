#!/bin/bash

set -e

source ../../config

scratchdir="${workdir}/data/scratch"
outfile="${workdir}/data/geno/geno_1kg"
outfile2="${workdir}/data/geno/geno"

# Extract unrelated kids from imputed data
# Permute fam file rows for each chromosome
for i in {1..22}
do
	plink1.90 \
		--bfile ~/1kg_scratch/chr${i}/alspac_1kg_p1v3_${i}_maf0.01_info0.8 \
		--keep ~/1kg_scratch/docs/Unrelateds/CHILDREN_UNRELATED_PLINK.txt \
		--make-bed \
		--out ${scratchdir}/chr${i}
	cp ${scratchdir}/chr${i}.fam ${scratchdir}/chr${i}.fam.orig
	cat ${scratchdir}/chr${i}.fam.orig | shuf > ${scratchdir}/chr${i}.fam
done

# Don't shuffle X chromosome - sex should relate to genotype
plink1.90 \
	--bfile ~/1kg_scratch/chr23/alspac_1kg_p1v3_23_maf0.01_info0.8 \
	--keep ~/1kg_scratch/docs/Unrelateds/CHILDREN_UNRELATED_PLINK.txt \
	--make-bed \
	--out ${scratchdir}/chr23

# Create merge file
echo "${scratchdir}/chr2.bed ${scratchdir}/chr2.bim ${scratchdir}/chr2.fam" > mergefile.txt
for i in {3..23}
do
	echo "${scratchdir}/chr${i}.bed ${scratchdir}/chr${i}.bim ${scratchdir}/chr${i}.fam" >> mergefile.txt
done

# Merge chromosomes into one file
plink1.90 --bfile ${scratchdir}/chr1 --merge-list mergefile.txt --make-bed --out ${outfile}

# Make fake IDs
cp ${outfile}.fam ${outfile}.fam.orig
nl ${outfile}.fam.orig | awk '{ print "id"$1, "id"$1, "0", "0", $6, $7 }' > ${outfile}.fam

# Check sex
plink1.90 --bfile ${outfile} --check-sex --out ${outfile}

# Create SNP chip dataset

plink1.90 --bfile ${outfile} --extract ${scratchdir}/snpchiplist.txt --out ${outfile2}


# Create GRM (10 minutes, 15 threads)
plink1.90 --bfile ${outfile2} --make-grm-bin --maf 0.01 --out ${outfile2}

# Construct PCs (7 minutes)
gcta64 --grm ${outfile2} --pca --out ${outfile2}
