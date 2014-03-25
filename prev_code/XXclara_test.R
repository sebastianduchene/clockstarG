library(cluster)
library(clockstar)
library(bigmemory)
library(irlba)

#options(bigmemory.allow.dimnames = T)

#print("creating big matrix")
#big.mat <- big.matrix(ncol = 10000, nrow = 10000)

#big.mat <- big.matrix(ncol = 1000, nrow = 1000)


#rownames(big.mat) <- 1:nrow(big.mat)
#colnames(big.mat) <- 1:ncol(big.mat)

#print("saving values in bigmat")
#for(i in 1:10000){
#      big.mat[1:i, i] <- rnorm(i)
#}

#big.mat[,] <- rnorm(1000^2)

#print("converting bigmat to mat")
#mat <- as.matrix(big.mat)

#print("runnig clara on mat")
#test.gap.1 <- clusGap(mat, clara, K.max = 100, B = 10)


# try reducing the number of dimensions

#mat.red <- svd(mat)$u[,1:2]

#test.gap.red <- clusGap(mat.red, clara, K.max = 100, B = 10)


#######################
#######################

# Try with a smaller data set with three groups

mat <- matrix(NA, 100, 100)

mat[1:30, ] <- rnorm(30*100, 10, 5)
mat[31:60, ] <- rnorm(30*100, 0, 5)
mat[61:100, ] <- rnorm(40*100, 7, 1)

rownames(mat) <- 1:100

mat.svd <- svd(mat)

mat.red <- mat.svd$u[,c(1, 1)]

#clus1 <- clusGap(mat.red, clara, K.max = 99, B = 10)

#######################
#######################
# It appears to work only with the pc1
# Try with some simulated trees
tr.top <- rtree(20)

trs.1 <- list()
blens.1 <- abs(rnorm(38, 0, 2))
for(i in 1:10){
      trs.1[[i]] <- tr.top
      trs.1[[i]]$edge.length <- abs(blens.1 + rnorm(38, 0, 0.05))
}

trs.2 <- list()
blens.2 <- abs(rnorm(38, 0, 2))
for(i in 1:10){
      trs.2[[i]] <- tr.top
      trs.2[[i]]$edge.length <- abs(blens.2 + rnorm(38, 0, 0.05))
}

trs.3 <- list()
blens.3 <- abs(rnorm(38, 0, 2))
for(i in 1:5){
      trs.3[[i]] <- tr.top
      trs.3[[i]]$edge.length <- abs(blens.3 + rnorm(38, 0, 0.05))
}

trs.4 <- list()
blens.4 <- abs(rnorm(38, 0, 2))
for(i in 1:5){
      trs.4[[i]] <- tr.top
      trs.4[[i]]$edge.length <- abs(blens.4 + rnorm(38, 0, 0.05))
}





trs.list <- c(trs.1, trs.2, trs.3, trs.4)
names(trs.list) <- 1:length(trs.list)

di.mat <- min.dist.topo.mat(trs.list)

clus.mat <- as.matrix(di.mat[[1]])

clus.mat.irlba <- irlba(clus.mat, nv = 0, nu = 10)

#TO SELECT A NUMBER OF DIMESNIONS THAT CAN SUMMARISE THE DISTANCES CHOOSE THOSE THAT WHICH EXPLAIN >95% OF THE VARIANCE 
# also use irlba with low nv and nu
#find the pc that explain 95% of the variability
#run on clara with reduced data
#


dim.inf <- which(cumsum(clus.mat.irlba$d / sum(clus.mat.irlba$d)) > 0.95)[1]

clus.mat.red <- clus.mat.irlba$u[, 1:dim.inf]

gap1 <- clusGap(clus.mat.red, clara, K.max = nrow(clus.mat.red) - 1, B = 10)
