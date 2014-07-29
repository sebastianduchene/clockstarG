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

#########
pdf("upm_plots.pdf")
par(mfrow = c(2, 2))
par(mar = c(4, 4, 2.5, 4))
plot((true_boot_150[, 1]), true_boot_150[, 2], pch = 20, col = rgb(0, 0, 0.5, 0.1), ylim = c(-0.7, -0.15), xlab = "Number of clusters", ylab = "Silhouette width")
mtext("Mammal genome data set", adj = 0)
lines(true_cluster_150, lwd = 1.5, col = "red")
plot(true_points[, 1:2], pch = 20, col = cluster_id$clustering + 1)


plot(sim_boot_150[, 1], sim_boot_150[, 2], pch = 20, col = rgb(0, 0, 0.5, 0.1), xlab = "Number of clusters", ylab = "Silhouette width")
mtext("UPM simulation", adj = 0)
lines(sim_cluster_150, lwd = 1.5, col = "red")
plot(sim_points[, 1:2], pch = 20, xlim = c(-0.07, 0.07), ylim = c(-0.07, 0.07))

dev.off()






