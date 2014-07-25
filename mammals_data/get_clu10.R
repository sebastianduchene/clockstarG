clu_10 <- read.table('cluster_10.txt', head = T, as.is = T)

class_dat <- read.table('classification_data.csv', sep = ',', head = T, as.is = T)

for(i in 1:nrow(clu_10)){
      class_dat[class_dat[, 1] == clu_10[i, 1], 7] <- clu_10[i, 2]
}