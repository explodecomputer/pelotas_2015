#!/bin/bash

# the ../ is a shortcut for specifying the directory above the current working directory
# an alternative way of writing ../ would be to write the full path, in this instance:
# ~/pelotas_2015/gwas/ is being substitute by ../

# The data directory and the work directory are imported from the ../../config file using this line of code. They are stored in the variables ${datadir} and ${workdir}

source ../../config


# Here we use the gwas_graphs.R script to generate Q-Q and Manhattan plots
# We pass to R the GWAS results file and the filename for the graphs to be saved to

# CRP full and approx models
Rscript gwas_graphs.R ${datadir}/results/crp.assoc.linear.add ../images/crp_full
Rscript gwas_graphs.R ${datadir}/results/crp.qassoc ../images/crp_approx

# BMI full and approx models
Rscript < what goes here? >
Rscript < what goes here? >

# Hypertension full and approx models
Rscript < what goes here? >
Rscript < what goes here? >
