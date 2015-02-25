library(plyr)
set.seed(12345)

turnAtoG <- function(x, allele1, allele2)
{
	x <- as.character(x)
	x[x=="0"] <- paste(allele1, allele1)
	x[x=="1"] <- paste(allele1, allele2)
	x[x=="2"] <- paste(allele2, allele2)
	x[is.na(x)] <- "0 0"
	return(x)
}


bim <- read.table("../geno/geno.bim")

fam <- read.table("../geno/geno.fam")

makeHwd <- function(n)
{
	x <- sample(0:2, n, replace=TRUE, prob=runif(3))
	return(x)
}


makeRare <- function(n)
{
	x <- rbinom(n, 2, 0.005)
}


makeMissing <- function(n)
{
	x <- rbinom(n, 2, runif(1, 0.1, 0.5))
	p <- rbeta(1, 0.1, 5)
	index <- sample(1:n, replace=FALSE, round(n*p))
	x[index] <- NA
	return(x)
}

makeBim <- function(bim)
{
	i1 <- sample(bim$V1, 1)
	temp <- subset(bim, V1 == i1)
	i2 <- sample(2:(nrow(temp)-1), 1)
	id <- paste(temp$V2[i2], temp$V4[i2], sep="")
	pos <- round((temp$V4[i2] + temp$V4[i2+1])/2)
	d <- temp[i2,]
	d$V2 <- id
	d$V4 <- pos
	return(d)
}



# 100 missingnesses
# 25 rare
# 20 HWE

l <- matrix(0, nrow(fam), 145)

for(i in 1:100)
{
	l[,i] <- makeMissing(nrow(fam))
}

for(i in 101:125)
{
	l[,i] <- makeRare(nrow(fam))
}

for(i in 126:145)
{
	l[,i] <- makeHwd(nrow(fam))
}


b <- list()
for(i in 1:145)
{
	b[[i]] <- makeBim(bim)
}

b <- rbind.fill(b)

ord <- order(b$V1, b$V4)
l <- l[,ord]
b <- b[ord,]

g <- l

for(i in 1:ncol(g))
{
	g[,i] <- turnAtoG(g[,i], b$V5[i], b$V6[i])
}

fam <- as.matrix(fam)
ped <- cbind(fam, g)
map <- b[,1:4]

write.table(ped, file="~/repo/pelotas_2015/data/scratch/bad_snps.ped", row=F, col=F, qu=F)
write.table(map, file="~/repo/pelotas_2015/data/scratch/bad_snps.map", row=F, col=F, qu=F)
