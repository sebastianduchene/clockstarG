#######
## Clustering and MDS
######

library(cluster)

true_cluster <- read.table("empirical_data/out_clus_sil.txt")
true_boot <- read.table("empirical_data/out_boot1.txt")
true_points <- read.table("empirical_data/points_mds.txt")

true_cluster_150 <- true_cluster[true_cluster[, 1] <= 100, ]
true_boot_150 <- true_boot[true_boot[, 1] <= 100, ]

sim_cluster <- read.table("upm_simulations/sim_clus_sil.txt")
sim_boot <- read.table("upm_simulations/out_boot1.sil.txt")
sim_points <- read.table("upm_simulations/points_points_sim_mds.txt")

sim_cluster_150 <- sim_cluster[sim_cluster[, 1] <= 100, ]
sim_boot_150 <- sim_boot[sim_boot[, 1] <= 100, ]
boot_ranges <- matrix(NA, nrow(true_cluster), 3)
for(i in 1:nrow(true_cluster)){
      boot_ranges[i, ] <- c(i + 1, range(true_boot[true_boot[, 1]==(i + 1), 2]))
}
signiff_clusters <- sapply(1:nrow(true_cluster), function(x) (true_cluster[x, 2] > boot_ranges[x, 3]))

cluster_id <- clara(true_points, k = 9)

pdf("upm_summary_results.pdf", width = 20, height = 13)
#########
#pdf("upm_plots.pdf")
par(mfrow = c(2, 2))
par(mar = c(4, 4, 2.5, 4))
smoothScatter((true_boot_150[, 1]), true_boot_150[, 2], pch = "", col = rgb(0, 0, 0.5, 0.1), ylim = c(-0.7, -0.15), xlab = "Number of clusters", ylab = "Silhouette width")
mtext("Mammal genome data set", adj = 0)
lines(true_cluster_150, lwd = 1.5, col = "red")
plot(true_points[, 1:2], pch = 20, col = rainbow(9)[cluster_id$clustering], cex = 2)

smoothScatter(sim_boot_150[, 1], sim_boot_150[, 2], pch = "", col = rgb(0, 0, 0.5, 0.1), xlab = "Number of clusters", ylab = "Silhouette width")
mtext("UPM simulation", adj = 0)
lines(sim_cluster_150, lwd = 1.5, col = "red")
plot(sim_points[, 1:2], pch = 20, xlim = c(-0.07, 0.07), ylim = c(-0.07, 0.07), col = rgb(0, 0, 0, 0.5), cex = 2)

#dev.off()

###########
##########
# hierarchical clustering
###########
##########
library(ape)
par(mfrow = c(1, 1))
mds_matrix <- dist(read.table("empirical_data/points_mds.txt"))
#sbsd_matrix <- read.table("fill_sbsdout.txt", head = T)
hclu <- as.phylo(hclust(mds_matrix))
plot(hclu, tip.color = rainbow(9)[cluster_id$clustering], direction = "downwards", cex = 0.4)

###################
##################
# tree classifier
################
################
library(rpart)

data_classify <- read.table('classification_data.csv', sep = ',', head= T, row.names = 1)

tr2 <- rpart(cluster ~ cg_content + tree_cv + tree_length, data = data_classify)
tr2.p <- prune(tr2, cp = 0.024)
printcp(tr2.p)

par(mfrow = c(1, 2))
plot(tr2)
text(tr2, cex = 0.7)
plot(tr2.p)
text(tr2.p, cex = 0.7)

dev.off()



