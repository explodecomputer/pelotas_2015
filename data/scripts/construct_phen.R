set.seed(1002)
library(fGarch)

workdir <- commandArgs(T)

standardise <- function(x)
{
	(x - mean(x, na.rm=T)) / sd(x, na.rm=T)
}

# Execute ${workdir}/randomise_data/generate_randomised_shuffled.sh
# Execute ${workdir}/randomise_data/phen/genetic_values.sh

# Read in genetic profiles

sbp_gen <- read.table(file.path(workdir, "data/scratch/sbp.profile"), he=T)
dbp_gen <- read.table(file.path(workdir, "data/scratch/dbp.profile"), he=T)
crp_gen <- read.table(file.path(workdir, "data/scratch/crp.profile"), he=T)
bmi_gen <- read.table(file.path(workdir, "data/scratch/bmi.profile"), he=T)

bp_poly <- read.table(file.path(workdir, "data/scratch/bp_poly.profile"), he=T)
crp_poly <- read.table(file.path(workdir, "data/scratch/crp_poly.profile"), he=T)
bmi_poly <- read.table(file.path(workdir, "data/scratch/bmi_poly.profile"), he=T)

gen <- data.frame(FID=sbp_gen$FID, IID=sbp_gen$IID, sbp=sbp_gen$SCORE, dbp=dbp_gen$SCORE, crp=crp_gen$SCORE, bmi=bmi_gen$SCORE, bmip=bmi_poly$SCORE, bpp=bp_poly$SCORE, crpp=crp_poly$SCORE)

fam <- read.table(file.path(workdir, "data/geno/geno.fam"))
n <- nrow(gen)

sex <- as.numeric(as.character(fam$V5))
age <- as.integer(rnorm(n, 45, 3))
smoke <- round(rbinom(n, 1, 0.6) + age * -4e-2 + sex * 0.5)


pcs <- read.table(file.path(workdir, "data/geno/geno.eigenvec"))

# Simulate BMI
# Assume genetic profile explains 8% of variance and poly explains 15%
# Give BMI skewed distribution

bmi <- standardise(gen$bmi) * sqrt(0.06) + 
	standardise(gen$bmip) * sqrt(0.15) + 
	standardise(smoke) * sqrt(0.001) +
	standardise(pcs$V3) * sqrt(0.06) +
	standardise(pcs$V4) * sqrt(0.06) +
	standardise(pcs$V6) * sqrt(0.06) +
	standardise(pcs$V8) * sqrt(0.06) +
	rsnorm(n, 0, sqrt(1-0.06-0.15-0.24), 10)

bmi <- (bmi - mean(bmi))/sd(bmi)

bmi[sex == 1] <- bmi[sex == 1] * 6.15 + 27.7
bmi[sex == 2] <- bmi[sex == 2] * 4.73 + 29.0

sbmi <- sd(bmi)
mbmi <- mean(bmi)
bmi <- (bmi - mean(bmi))/sd(bmi)




## The network looks something like this:

## Age is not a confounder for any of the variables
## Sex is associated (2% var) with sbp and dbp
## BMI causes CRP and BP
## CRP and BP are associated but not causally
## BMI explains all but 0.01 of sbp-crp correlation and 0.001 dbp-crp correlation
# bmi -> crp 0.125
# bmi -> sbp 0.058
# bmi -> dbp 0.061
# crp <-> sbp 0.01
# crp <-> dbp 0.001
# h2 of BMI

# rg_bmi-crp = 0.3
# rg_bmi-bp = 0.3
# rg_bp-crp=0

# smoking has a small association with
# age -4e-5 days
# sex 0.08
# bmi 0.001
# crp r=0.002
# sbp 0.0004

# Create BMI-independent confounders for crp-bp
crpsbp <- rnorm(n, sd=sqrt(0.01))
crpdbp <- rnorm(n, sd=sqrt(0.001))

# Construct CRP
crp <- crpsbp + 
	crpdbp + 
	bmi * sqrt(0.125) + 
	standardise(gen$crpp) * sqrt(0.3) + 
	standardise(gen$crp) * sqrt(0.06) + 
	standardise(smoke) * sqrt(0.002) +
	standardise(pcs$V5) * sqrt(0.1) +
	rnorm(n, 0, sqrt(1 - 0.01 - 0.001 - 0.125 - 0.3 - 0.06 - 0.1))


# Simulate SBP and DBP

# Simple method without using BMI and unknown confounders
# dbp <- rnorm(n, 83.3, 11.7) + bmi * sqrt(0.061) + crpsbp
# ds <- abs(rnorm(n, 57.7, 16.5))
# sbp <- dbp + ds + bmi * sqrt(0.058)
# cor(dbp, sbp)

dbp <- rnorm(n, 0, sqrt(1 - 0.061 - 0.001 - 0.5)) + 
	standardise(bmi) * sqrt(0.061) + 
	crpsbp + 
	gen$dbp +
	standardise(gen$bpp) * sqrt(0.5) +
	sex * 0.1

ds <- abs(rnorm(n, 0, sqrt(1/0.21-1)))

sbp <- dbp + 
	ds + 
	standardise(bmi) * sqrt(0.02) + 
	gen$sbp + 
	standardise(smoke) * sqrt(0.001) +
	sex * 0.1

cor(dbp, sbp)


# Scale phenotypes

bmi <- bmi * sbmi + mbmi
dbp <- dbp * 11.7 + 80.3
sbp <- sbp * 20.4 + 120.97
crp <- crp * 0.838 + 0.560
hscrp <- exp(crp)
hypertension <- as.numeric(dbp > 90 | sbp > 140) + 1
table(hypertension)







phen <- data.frame(fid=fam$V1, iid=fam$V2, bmi=bmi, dbp=dbp, sbp=sbp, crp=hscrp, hypertension=hypertension)

covars <- pcs[,1:12]
covars$age <- age
covars$sex <- sex
covars$smoke <- smoke

# Check that instruments are associated with what we expect

# summary(lm(crp ~ gen$crp))
# summary(lm(crp ~ gen$bmip + gen$bmi))
# summary(lm(crp ~ gen$crp + gen$crpp))
# summary(lm(bmi ~ gen$bmip + gen$bmi))
# summary(lm(sbp ~ gen$sbp))
# summary(lm(dbp ~ gen$dbp))

# Check other relationships

# Should be significant

# summary(lm(sbp ~ gen$bmi))
# summary(lm(dbp ~ gen$bmi))
# summary(lm(hypertension ~ gen$bmi))


# Should be null

# summary(lm(bmi ~ gen$crp))
# summary(lm(sbp ~ gen$crp))
# summary(lm(dbp ~ gen$crp))
# summary(lm(crp ~ gen$dbp))
# summary(lm(crp ~ gen$sbp))


# Smoking associates with everything except dbp

# summary(lm(bmi ~ smoke))
# summary(lm(age ~ smoke))
# summary(lm(sex ~ smoke))
# summary(lm(crp ~ smoke))
# summary(lm(hypertension ~ smoke))
# summary(lm(sbp ~ smoke))
# summary(lm(dbp ~ smoke))


# Check covariances

# Expected 0.125
# cor(bmi, crp)^2

# Expected 0.06
# cor(bmi, sbp)^2

# Expected 0.06
# cor(bmi, dbp)^2

# Expected 0.01
# cor(crp, sbp)^2

# Expected 0.01
# cor(crp, dbp)^2



save(phen, covars, file=file.path(workdir, "data/phen/phen.RData"))
write.table(phen, file.path(workdir, "data/phen/phen.txt"), row=F, col=F, qu=F)
write.table(covars, file.path(workdir, "data/phen/covars.txt"), row=F, col=F, qu=F)
