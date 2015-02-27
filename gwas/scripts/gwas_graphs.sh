#!/bin/bash

# the ../ is a shortcut for specifying the directory above the current working directory
# an alternative way of writing ../ would be to write the full path, in this instance:
# ~/pelotas_2015/gwas/ is being substitute by ../

# The data directory and the work directory are imported from the ../../config file using this line of code. They are stored in the variables ${datadir} and ${workdir}

source ../../config


# Here we use the gwas_graphs.R script to generate Q-Q and Manhattan plots
# We pass to R the GWAS results file and the filename for the graphs to be saved to

Rscript gwas_graphs.R ${datadir}/results/bmi.assoc.linear.add ../images/bmi_full
Rscript gwas_graphs.R ${datadir}/results/crp.assoc.linear.add ../images/crp_full
Rscript gwas_graphs.R ${datadir}/results/hypertension.assoc.logistic.add ../images/hypertension_full

Rscript gwas_graphs.R ${datadir}/results/bmi.qassoc ../images/bmi_approx
Rscript gwas_graphs.R ${datadir}/results/crp.qassoc ../images/crp_approx
Rscript gwas_graphs.R ${datadir}/results/hypertension.assoc ../images/hypertension_approx
