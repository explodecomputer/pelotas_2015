#!/bin/bash

source ../../config


R --no-save --args ${datadir}/results/bmi.assoc.linear.add ../images < gwas_graphs.R
R --no-save --args ${datadir}/results/crp.assoc.linear.add ../images < gwas_graphs.R
R --no-save --args ${datadir}/results/hypertension.assoc.logistic.add ../images < gwas_graphs.R

R --no-save --args ${datadir}/results/bmi.qassoc ../images < gwas_graphs.R
R --no-save --args ${datadir}/results/crp.qassoc ../images < gwas_graphs.R
R --no-save --args ${datadir}/results/hypertension.assoc ../images < gwas_graphs.R
