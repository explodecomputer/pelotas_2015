library(qqman)
library(GenABEL)

qqplotpval <- function(P, filename=NULL)
{
        require(GenABEL)
        l <- estlambda(P, method="median")
        nom <- paste("lambda = ", round(l$estimate, 3), sep="")
        if(!is.null(filename))
        {
                png(filename)
        }
        estlambda(P, method="median", plot=TRUE, main=nom)
        if(!is.null(filename))
        {
                dev.off()
        }
}

arguments <- commandArgs(T)
infile <- arguments[1]
outdir <- arguments[2]

a <- read.table(infile, he=T)
a$CHR <- as.numeric(a$CHR)
a <- subset(a, P != 0)


qqfilename <- paste(file.path(outdir, basename(infile)), "_qqplot.png", sep="")
manhattanfilename <- paste(file.path(outdir, basename(infile)), "_manhattan.png", sep="")

qqplotpval(a$P, qqfilename)

png(file=manhattanfilename)
manhattan(a, main=paste(basename(infile), "Manhattan plot"))
dev.off()

