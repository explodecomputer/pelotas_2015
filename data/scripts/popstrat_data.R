pcs <- read.table("~/repo/pelotas_2015/data/scratch/als_hm3_pruned.eigenvec", stringsAsFactors=FALSE)
pops <- read.table("~/repo/pelotas_2015/data/scratch/relationships_w_pops_121708.txt", he=T, stringsAsFactors=FALSE)

dat <- merge(subset(pops, select=c(IID, population)), pcs, by.x="IID", by.y="V2", all=TRUE)

dat$population[is.na(dat$population)] <- "Our data"

popstrat <- dat
popstrat <- subset(popstrat, select=c(V1, IID, population, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12))
names(popstrat) <- c("FID", "IID", "population", paste("PC", 1:10, sep=""))

save(popstrat, file="~/repo/pelotas_2015/data/geno/popstrat.RData")



# library(ggplot2)

# ggplot(dat, aes(x=V3, y=V4)) +
# geom_point(aes(colour=population))

# plot(V3 ~ V4, dat)
# points(V3 ~ V4, subset(dat, population=="Our data"), col="red")
