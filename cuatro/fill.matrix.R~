matrix.name <- "sbsdtest2.txt"



dat.mat <- read.table(matrix.name, head = F, row.names = 1)

#dat.mat <- rbind(rep(NA, ncol(dat.mat)), dat.mat)

dat.mat <- cbind(dat.mat , V19=rep(NA, nrow(dat.mat)))


for(i in 1:nrow(dat.mat)){
dat.mat[i, i:ncol(dat.mat)] <- dat.mat[i:ncol(dat.mat), i]
}




#diag.dim <- length(diag(as.matrix(dat.mat)))




dat.mat <- as.matrix(dat.mat)

diag(dat.mat) <- 0



#for(k in 1:diag.dim){
#dat.mat[1:diag.dim, 1:diag.dim] <- 0
#}