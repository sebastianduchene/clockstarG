#######
## Clustering and MDS
######

library(cluster)

true_cluster <- read.table("empirical_data/out_clus_sil.txt")
true_boot <- read.table("empirical_data/out_boot1.txt")
true_points <- read.table("empirical_data/points_mds.txt")

true_cluster_150 <- true_cluster[true_cluster[, 1] <= 150, ]
true_boot_150 <- true_boot[true_boot[, 1] <= 150, ]

sim_cluster <- read.table("upm_simulations/sim_clus_sil.txt")
sim_boot <- read.table("upm_simulations/out_boot1.sil.txt")
sim_points <- read.table("upm_simulations/points_points_sim_mds.txt")

sim_cluster_150 <- sim_cluster[sim_cluster[, 1] <= 150, ]
sim_boot_150 <- sim_boot[sim_boot[, 1] <= 150, ]
boot_ranges <- matrix(NA, nrow(true_cluster), 3)
for(i in 1:nrow(true_cluster)){
      boot_ranges[i, ] <- c(i + 1, range(true_boot[true_boot[, 1]==(i + 1), 2]))
}
signiff_clusters <- sapply(1:nrow(true_cluster), function(x) (true_cluster[x, 2] > boot_ranges[x, 3]))

cluster_id <- clara(true_points, k = 9)

#Start with mds plot

#plot3d(true_points, type = 's', size = 0.7, ylab = '', xlab = '', zlab = '', col = rainbow(9)[cluster_id$clustering])


#plot(true_points[, 1], true_points[, 2], pch = 20, xlab = 'MDS coordinate 1', ylab = 'MDS coordinate 2', cex = 1.4, ylim = c(-3, 2), xlim = c(-4, 2), col = rainbow(9)[cluster_id$clustering])

# Get silhouette plots


pdf('Fig3.pdf')
par(mfrow = c(2, 1))
par(mar = c(4, 4, 4, 4))
plot(true_boot_150[, 1], true_boot_150[, 2], pch = 20, col = rgb(0, 0, 1, 0.5), ylab = '', xlab = '', ylim = c(-0.7, -0.1))
lines(true_cluster_150[, 1], true_cluster_150[, 2], col = 'red', lwd = 1.5)
legend(x = 100, y = -0.18, legend = c(expression(paste(italic(W[k]), " of trees")), expression(paste(italic(W[k])," of bootstrap replicates"))), fill = c('red', rgb(0, 0, 1, 0.5)), cex = 0.7, bty = 'n')

plot(sim_boot_150[, 1], sim_boot_150[, 2], pch = 20, col = rgb(0, 0, 1, 0.5), xlab = 'Number of pacemakers',  ylab = expression(paste('Silhouette width ', italic(W[k]))), ylim = c(-0.7, -0.1))
lines(sim_cluster_150[, 1], sim_cluster_150[, 2], col = 'red', lwd = 1.5)
dev.off()