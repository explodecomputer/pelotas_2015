Genome wide association studies
===============================

# Objectives

1. Get familiar with the data and software
2. Perform quality control routines for genetic and phenotypic data
3. Perform GWAS
4. Interpret results


# Instructions

Here you'll find information about all the above objectives and some questions at the bottom of the page. All the scripts to perform the analysis are provided, but

> **please read through the scripts** 

so that you understand what is being done and how it is being implemented.

The folder structure has been written in a way to mimic how one might set up the analysis for a real GWAS. Scripts are located in the `scripts/` folder, graphs will be saved to `images/`, output from the various analysis in `results/` and any data generated for the analysis will be in `data/`.


# Background

Genome wide association studies aim to identify genetic variants that are associated with a trait of interest, leading to a number of possible outcomes such as

- Deepening biological understanding of the genome and pharmacological targets
- Disease prediction
- Epidemiological application in causal inference
- Evolutionary understanding of genotype - phenotype relationships

In this practical you will have a simple introduction on how to conduct GWAS. We begin with a slightly mundane but very important aspect, quality control, whose objective is ensuring only high quality data is being used to make any scientific inferences. 

Next we'll use PLINK software to perform the GWAS. This is a simple routine where the software performs a regression for every SNP in the data, testing association between the SNP and the trait. We'll perform the GWAS twice, once using the original raw and uncleaned data, and once using the cleaned data. This way we get to see what a good and a bad GWAS result looks like.

Finally we'll draw some graphs to visualise the results, identify significant associations and perform lookups with online tools to get more information about the SNPs and regions implicated by the GWAS.


## A note about Plink2

Most of the data manipulation and some of the analysis will be run using [plink2](https://www.cog-genomics.org/plink2/). It is currently in beta (technically still `plink1.90`), but for most functions is stable and is extremely fast compared to the [original plink](http://pngu.mgh.harvard.edu/~purcell/plink/). It can be used for the vast majority of genetic analyses that are routinely performed, and the syntax is pretty simple and straightforward. Refer to the documentation to get more details about what it can do and how routines are implemented.


## Data

The data is in 'binary plink' format data, which requires 3 files for each dataset. The `.fam` file has information about the individuals - family ID, individual ID, father, mother, sex, phenotype. Note that we can specify a different phenotype file to analyse a different phenotype so that we don't have to change the genotype data.

The `.bim` file has information about the SNPs in the data - chromosome, SNP name, genetic position, physical position, minor allele, major allele.

The `.bed` file is a binary file which encodes the genotypes for every individual and every SNP, representing an *n* individual x *m* SNP matrix. This is not human readable because the data is packed for fast loading and low memory usage.

Some things to consider before starting the analysis:

- How many individuals are there?
- How many SNPs?
- How many chromosomes?
- Genotyped or imputed?
- What is the SNP density?
- Is there population structure?
- Are there related individuals?


### Phenotype data

- Is the trait continuous or dichotomous?
- How have the subjects been chosen?
- Are there covariates?
- How many individuals with genotype, trait and covariate data?


## Quality control

Performing QC is very important, here are some routine things to consider:

- Are SNPs in Hardy Weinburg Equilibrium
- Remove low MAF SNPs (e.g. < 0.01)
- Remove individuals and SNPs with high missingness (e.g. > 0.05)
- Phenotypes should be normalised
- Some variables should be adjusted for variance effects
- Identify population outliers


### Things that need reporting
- Genotyping call rate after exclusions
- Number of individuals and SNPs after exclusions
- Trait distribution


## Performing GWAS

Ideally we would use a proper linear model but in the interests of time we will use a fast score statistic

Should include covariates and PCs

## Post processing

- Significance thresholds
- Manhattan plot
- Q-Q plot
- Clumping


## Questions

1. Find the genotype data and find out how many SNPs and how many individuals are present.

		wc -l /panfs/panasas01/shared/alspac/pelotas_teaching_material/data/geno.bim
		wc -l /panfs/panasas01/shared/alspac/pelotas_teaching_material/data/geno.fam

2. Calculate summary statistics on the genotype data including

	- Allele frequency distribution
	- Hardy-Weinberg Equilibrium
	- Genotype missingness

			cd ~/pelotas_2015/gwas/scripts
			./summary_stats.sh

	- Generate some graphs from the summary statistics

			R --no-save --args ../results/geno < summary_stats.R

3. Look at the script to perform QC steps for the genotype data, and save the cleaned genotype data with filename `geno_qc`

		./qc.sh

4. Perform QC steps for the phenotype data. What is being done here and why?

        R --no-save < qc.R

5. Perform the GWAS twice, once with and once without covariates. Note: running with covariates will be very slow, the important thing is to understand the script, but the results are already generated in the `../results` directory

        ./run_gwas.sh

6. Generate graphs to visualise the data. Look at the Manhattan plots in `../images` - how many significant signals are there? Is there a difference between GWAS results from cleaned and uncleaned data? Look at the Q-Q plots - is there evidence for signals being driven by population stratification?

		R --no-save < gwas_graphs.R

7. There are many SNPs under each significance peak, this is most likely due to a single **causal variant** with a large number of SNPs that have large test statistics simply because they are in linkage disequilibrium with the causal variant. We can simplify the results by generating a list of independent signals by 'clumping' the data

		./clump.sh


### Bioinformatics session

8. Let's take a closer look at the significant hits. Look at the `results/*.clumped` files, and feed the top few hits into the [http://genome.ucsc.edu/cgi-bin/hgGateway](UCSC genome browser).

9. We can see if there are genomic annotations in the same region as our hits. Navigate to the [http://www.broadinstitute.org/mammals/haploreg/haploreg_v3.php](Haploreg) website and enter the top few hits into the search box.

10. Going deeper, we could test our results for pathway enrichment, e.g. using the [http://david.abcc.ncifcrf.gov/summary.jsp](DAVID functional annotation tool)

11. What is the best way to verify whether these signals are real?

12. Are the effect size estimates likely to be accurate?
