matrix.name <- "sbsdtest2.txt"


dat.mat <- read.table(matrix.name, head = F, row.names = 1)

dat.mat <- rbind(rep(NA, ncol(dat.mat)), dat.mat)

dat.mat <- cbind(dat.mat , V19=rep(NA, nrow(dat.mat)))

