set.seed(12345)

dat <- data.frame(
	chr = sample(1:22, 500, replace=T), 
	rs  = paste("rs", sample(100000:9999999, 500), sep=""), 
	pos = sample(1:5000000, 500, replace=F))

dat <- dat[order(dat$chr, dat$pos), ]

write.table(dat, file="~/repo/pelotas_2015/unix_tutorial/data/snpdata.txt", row=F, col=F, qu=F)
