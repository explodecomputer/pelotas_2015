#!/bin/bash

R --no-save --args ../results/bmi.assoc.linear.add ../images < gwas_graphs.R
R --no-save --args ../results/crp.assoc.linear.add ../images < gwas_graphs.R
R --no-save --args ../results/hypertension.assoc.logistic.add ../images < gwas_graphs.R

R --no-save --args ../results/bmi.qassoc ../images < gwas_graphs.R
R --no-save --args ../results/crp.qassoc ../images < gwas_graphs.R
R --no-save --args ../results/hypertension.assoc ../images < gwas_graphs.R
