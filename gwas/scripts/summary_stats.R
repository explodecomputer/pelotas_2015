# Generate graphs for missingness, HWD, allele freq

freq <- read.table("../results/geno_unclean.frq", he=T)

pdf(file="../images/unclean_maf.pdf")
hist(freq$MAF, breaks=50)
dev.off()

png(file="../images/unclean_maf2.png")
plot(-log10(freq$MAF))
abline(h=-log10(0.01))
dev.off()


# HWD

hwe <- read.table("../results/geno_unclean.hwe", he=T)

png(file="../images/unclean_hwe.png")
plot(-log10(hwe$P))
dev.off()


# Missingness

miss <- read.table("../results/geno_unclean.lmiss", he=T)
table(miss$F_MISS > 0.05)

