# Simulate some data:
library(ape)
library(cluster)
source('functions.R')


# 57 branches for unrooted trees of 30 taxa

pms <- lapply(1:1, function(x) rlnorm(57, meanlog = -4.6, sdlog = 0.2))
pms <- rep(pms, 100)

tree_topo <- unroot(rtree(30))
trees_sim <- list()

#Generate 100 trees with the 10 pms but different absolute rates
for(i in 1:100){
      tr_temp <- tree_topo
      tr_temp$edge.length <- abs(pms[[i]] + rnorm(57, 0.001, 0.001)) * runif(1, 0.5, 10)
      trees_sim[[i]] <- tr_temp
}
names(trees_sim) <- paste0(paste0('pm_', 1:4, '_'), 1:100)



##########
# Confirm that the new metric works, by visually inspecting the mds
scaled_brs <- get_scaled_brs(trees_sim)

dist_trees <- dist(scaled_brs)
col_points <- rainbow(10)[rep(1:10, 10)]
library(rgl)
#plot3d(cmdscale(dist_trees, k = 3), col = col_points, type = 's')
############

#####
# Test clustering
#tc5 <- system.time(optim_clusters_coord(scaled_brs, n_clusters = 5, plot_clustering = T, kmax = 350, b_reps = 50))

#tc10 <- system.time(optim_clusters_coord(scaled_brs, n_clusters = 10, plot_clustering = T, kmax = 350, b_reps = 50))

#tc_test <- cl_clusGap(scaled_brs, K.max = 50, B = 10 , n_clusters = 5)
tc_coord <- optim_clusters_coord(scaled_brs, n_clusters = 5, plot_clustering = T, kmax = 50, b_reps = 50)
