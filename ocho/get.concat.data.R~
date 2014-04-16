library(phangorn)

# Generate concatenated alignment

files.fasta <- grep("fasta", dir(), value = T) 

recur.concat <- function(x, y, ...){
	     if(missing(...)){
		 cbind(x, y)
		 }else{
		 cbind(x, recur.concat( y, ...))
		 }
}

dat <- read.dna(files.fasta[1], format = "fasta")

for(i in 2:length(files.fasta)){
      dat <- recur.concat(dat, read.dna(files.fasta[i], format = "fasta"))
}

write.dna(dat, file = "all_concat.txt", nbcol = -1, colsep = "")

#files.tre <- read.tree(grep("[.]tre", dir(), value = T))

#dat.pml <- pml(phyDat(dat), tree = files.tre)

#dat.opt <- optim.pml(dat.pml)

