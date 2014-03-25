#The first command line argument is the dir with the fasta and the tree file
#The second command line arg is whether the program should run in parallel or not

library(clockstar)
args <- commandArgs(TRUE)

data.file <- args[1]

if(!is.na(args[2])){
      dopar <- as.logical(args[2])
      ncore <- 4
      }else{
	dopar <- F
	ncore <- 1
	}

setwd(data.file)

fix.tree <- read.tree(grep("tre", dir(), value = T)[1])

optim.edge.lengths(directory = ".", fixed.tree = fix.tree, save.trees = T, para = dopar, ncore = ncore)

