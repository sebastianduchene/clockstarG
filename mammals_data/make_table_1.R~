library(cluster)


mds_data <- read.table('points_mds.txt', head = T, as.is = T)

mds_clara <- clara(mds_data, k = 10)

clus_data <- summary(mds_clara)

table_1 <- matrix(NA, 10, 5, dimnames = list(c(1:10), c('clus_id', 'mean_tl', 'size', 'mean_diss', 'mean_isolation')))

table_1[, 1] <- 1:10
table_1[, 3] <- clus_data$clusinfo[, 1]
table_1[, 4] <- clus_data$clusinfo[, 3]
table_1[, 5] <- clus_data$clusinfo[, 4]

# Get tree info

tl_data <- read.table('classification_data.csv', head = T, sep = ',', as.is = T)

tl_data$cluster <- gsub('[A-Z]|[a-z]', '', tl_data$cluster)

tl_clusters <- tapply(as.numeric(tl_data$tree_length), tl_data$cluster, function(x) mean(x, na.rm = T))

table_1[, 2] <- tl_clusters[order(as.numeric(names(tl_clusters)))]


write.table(table_1, file = "table_1.txt", row.names = F)