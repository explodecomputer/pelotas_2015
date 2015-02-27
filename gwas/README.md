Genome wide association studies
===============================

# Objectives

1. Get familiar with the data, the software, and working in a Unix environment
2. Perform quality control routines for genetic and phenotypic data
3. Perform GWAS
4. Interpret results


# Instructions

Here you'll find information about all the above objectives and some questions at the bottom of the page. All the scripts to perform the analysis are provided, but

> **please read through the scripts** 

so that you understand what is being done and how it is being implemented.


## Setup

After you have logged into the server you should find a folder called `pelotas_2015` in your home directory:

	ls -l

This folder has all the scripts you'll need for the GWAS practical. If the folder is not there you can download it with the following command:

	git clone https://github.com/explodecomputer/pelotas_2015.git

It will take a few moments to download. When it's finished navigate to the `gwas` folder:

	cd pelotas_2015/gwas

The folder structure has been written in a way to mimic how one might set up the analysis for a real GWAS. Scripts are located in the `scripts/` folder, graphs will be saved to `images/`, output from the various analysis in `results/` and any data generated for the analysis will be in `data/`.


# Background

Genome wide association studies aim to identify genetic variants that are associated with a trait of interest, leading to a number of possible outcomes such as

- Deepening biological understanding of the genome and pharmacological targets
- Disease prediction
- Epidemiological application in causal inference
- Evolutionary understanding of genotype - phenotype relationships

In this practical you will have a simple example of how to perform GWAS. We begin with a slightly mundane but very important aspect, quality control, whose objective is ensuring only high quality data is being used to make any scientific inferences. 

Next we'll perform the GWAS. This is a simple routine where the PLINK software performs a regression for every SNP in the data, testing association between the SNP and the trait. We'll perform the GWAS twice, once using a fast and approximate method using the original raw and uncleaned data, and once using the cleaned data using proper linear or logistic regression. This way we get to see what a good and a bad GWAS result looks like.

Finally we'll draw some graphs to visualise the results, identify significant associations and perform lookups with online tools to get more information about the SNPs and regions implicated by the GWAS.


## A note about Plink2

Most of the data manipulation and some of the analysis will be run using [plink2](https://www.cog-genomics.org/plink2/). It is currently in beta (technically still `plink1.90`), but for most functions is stable and is extremely fast compared to the [original plink](http://pngu.mgh.harvard.edu/~purcell/plink/). It can be used for the vast majority of genetic analyses that are routinely performed, and the syntax is pretty simple and straightforward. 

Refer to the documentation in the links above to get more details about what it can do and how routines are implemented.


# Practical

## Cleaning genotype data

The data is in 'binary plink' format data, which requires 3 files for each dataset. The `.fam` file has information about the individuals - family ID, individual ID, father, mother, sex, phenotype. Note that we can specify a different phenotype file to analyse a different phenotype so that we don't have to change the genotype data files.

The `.bim` file has information about the SNPs in the data - chromosome, SNP name, genetic position, physical position, minor allele, major allele.

The `.bed` file is a binary file which encodes the genotypes for every individual and every SNP, representing an *n* individual x *m* SNP matrix. This is not human readable because the data is packed for fast loading and low memory usage.


### Exercise 1

Familiarise ourselves with the data:

- How many individuals are there?

		wc -l /pelotas_data/geno.fam

- How many SNPs?

		wc -l /pelotas_data/geno.bim

- How many chromosomes?

		awk '{ print $1 }' /pelotas_data/geno.bim | uniq



### Exercise 2

Calculate summary statistics on the genotype data including

- Allele frequency distribution
- Hardy-Weinberg Equilibrium
- Genotype missingness

		cd ~/pelotas_2015/gwas/scripts
		./summary_stats.sh

- Generate some graphs from the summary statistics

		R --no-save --args ../results/geno < summary_stats.R

Use WinSCP to download these graphs to your local computer to view them. They are:

- `../images/unclean_maf.pdf`
- `../images/unclean_maf2.pdf`
- `../images/unclean_hwe.png`

**_Questions:_**

> 1. What are reasonable exclusion thresholds for
> 	- MAF?
>	- HWE?
>	- Genotype missingness?
> 2. Can you explain why the allele frequency distribution is the way it is?


### Exercise 3

Clean the genotype data. This means:

- Remove SNPs in Hardy Weinberg Disequilibrium
- Remove rare SNPs
- Remove SNPs that have high rates of missing information

We can do this using the `qc_geno.sh` script. **NOTE:** This has already been run once you just need to understand what the script is doing

	less qc_geno.sh

The pre-generated QC'd data can be found at `/pelotas_data/geno_qc.*`.


## Cleaning phenotype data

### Exercise 4

Work through the commands in the R script called `qc_phen.R` to visualise and clean the phenotype data.

This file will generate some graphs, transform phenotypes and remove outliers, test for associations between traits and covariates, and save the cleaned phenotype data to a text file.

**_Questions:_**

> 1. For continuous traits are they normally distributed?
> 2. Are there any outliers?
> 3. Are the covariates associated with the traits?
> 4. How will each of these factors influence the performance of our GWAS?


## Performing GWAS

We are going to compare the way GWAS results are influenced if we use: **a.** uncleaned data and no covariates (approx model) and **b.** Cleaned data with covariates (full model).


### Exercise 5

Because **b.** is fitting a proper linear model for each SNP the routine can take quite a long to run (e.g. > 30 minutes for our dataset) so the results have already been generated using the `run_gwas_full.sh` command, the results can be found at:

- `/pelotas_data/gwas/bmi.assoc.linear.add`
- `/pelotas_data/gwas/crp.assoc.linear.add`
- `/pelotas_data/gwas/hypertension.assoc.logistic.add`

However, the results for **a.** can be generated quickly. Perform the GWAS using an approximate association test which runs very fast but doesn't fit covariates.

	less run_gwas_fast.sh
	./run_gwas_fast.sh

Look at the `run_gwas_full.sh` script. What are the main syntax differences?

	less run_gwas_full.sh

### Exercise 6

We now have two GWAS results for each trait - let's compare them. To visualise the results we will generate Manhattan plots and Q-Q plots. Run the `gwas_graphs.sh` script to do this.

	less gwas_graphs.sh
	less gwas_graphs.R
	./gwas_graphs.sh

The Manhattan plots allow us to visualise if there are any genome-wide significant signals, and to get an idea of how well behaved the analysis has been. The Manhattan plots for BMI can be found here:

- `../images/bmi_approx_manhattan.png`
- `../images/bmi_full_manhattan.png`

The first is for the approx analysis and the second is for the full analysis. The plots for the other traits are in the same directory. Use WinSCP to download them to your local computer to view them.

**_Questions:_**

> 1. What is the significance threshold and why?
> 2. We see rather different results from the two methods. How might the differences occur due to:
> 	- Including covariates?
> 	- QC on the phenotypes?
> 	- QC on the genotypes?
> 	- Using an approximate test statistic?
> 3. Why do we see many significant SNPs under each peak?

The Q-Q plots are in the same directory:

- `../images/bmi_approx_qqplot.png`
- `../images/bmi_full_qqplot.png`

Use WinSCP to download them to your local computer to view them.

**_Questions:_**

> 1. What shape Q-Q plot do we expect to see under the null hypothesis?
> 2. What value of lambda do we expect to see under the null hypothesis?
> 3. What technical artifacts can cause lambda to have a higher than expected value?
> 3. Are there any scenarios where we could have a large value of lambda due to real biological causes?



### Exercise 7

There are hundreds of 'significant' SNPs, but only a few significantly associated regions in the genome. This is most likely due to a single **causal variant** with a large number of SNPs that have large test statistics simply because they are in linkage disequilibrium with the causal variant. 

It is convenient to identify the top SNP from each region in order to use in subsequent analysis such as functional annotation or Mendelian randomisation. We can use a process called 'clumping' to do this. This takes the top hit in the genome, and then removes all SNPs that are in LD with it (above a specified $r^2$ threshold and within a specified distance). It then does the same for the next top hit, and continues until there are no more significant hits apart from the iteratively selected significant independent SNPs.

We can clump our results using the `clump.sh` script/

	less clump.sh
	./clump.sh

Look at the results in `../results/*.clumped`. How many significant independent SNPs are there? We can estimate the proportion of the phenotypic variance explained by that SNP using the following code in R (e.g. supposing our sample size is 8000 and the p-value is $1e^{-8}$:

	p <- 1e-8
	n <- 8000
	Fval <- qf(p, 1, n-1, lower.tail=FALSE)
	varexp <- Fval / (n - 1 + Fval)

**_Questions:_**
> 1. How much variance has been explained by our significantly detected SNPs?
> 2. What does this tell us about the genetic architecture of our phenotype?


# Bioinformatics session

1. Let's take a closer look at the significant hits. Look at the `results/*.clumped` files, and feed the top few hits into the [http://genome.ucsc.edu/cgi-bin/hgGateway](UCSC genome browser).

2. We can see if there are genomic annotations in the same region as our hits. Navigate to the [http://www.broadinstitute.org/mammals/haploreg/haploreg_v3.php](Haploreg) website and enter the top few hits into the search box.

3. What steps can we take to verify whether our GWAS signals are real?
