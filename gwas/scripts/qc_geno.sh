#!/bin/bash

############################
# Don't need to run this!! #
############################

# the ../ is a shortcut for specifying the directory above the current working directory
# an alternative way of writing ../ would be to write the full path, in this instance:
# ~/pelotas_2015/gwas/ is being substitute by ../

# The data directory and the work directory are imported from the ../../config file using this line of code. They are stored in the variables ${datadir} and ${workdir}


source ../../config


# This is how to filter genotype data on maf, hwe and missingness
# Don't need to actually run it because a QC'd data set has already been generated
# But think about what values should be used for each of the exclusion filters


plink1.90 \
 	--bfile ${datadir}/geno_unclean \
 	--maf 0.01 \
 	--hwe 1e-6 \
 	--geno 0.05 \
 	--mind 0.05 \
 	--make-bed \
 	--out ${datadir}/geno_qc


