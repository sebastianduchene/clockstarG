# Simulate some data:
library(ape)
library(cluster)

# 57 branches for unrooted trees of 30 taxa

pms <- lapply(1:10, function(x) rlnorm(57, meanlog = -4.6, sdlog = 0.2))
pms <- rep(pms, 10)

tree_topo <- unroot(rtree(30))
trees_sim <- list()

#Generate 100 trees with the 10 pms
for(i in 1:100){
      tr_temp <- tree_topo
      tr_temp$edge.length <- abs(pms[[i]] + rnorm(57, 0.001, 0.001))
      trees_sim[[i]] <- tr_temp
}
names(trees_sim) <- paste0(paste0('pm_', 1:10, '_'), 1:100)

############
# This would replace the sbsdmin. NOTE: CONSIDER USING LOG FOR THE DISTANCES

scaled_brs <- function(tree){
  lad_tree <- ladderize(tree)
  br_lens_scaled <- lad_tree$edge.length / sum(lad_tree$edge.length)
  return(br_lens_scaled)
}

get_scaled_brs <- function(tree_list){
  br_lens_matrix <- matrix(NA, nrow = length(tree_list), ncol = length(tree_list[[1]]$edge.length))
  rownames(br_lens_matrix) <- names(tree_list)
  colnames(br_lens_matrix) <- paste0('br', 1:length(tree_list[[1]]$edge.length)) 
  for(i in 1:length(tree_list)){
    br_lens_matrix[i, ] <- scaled_brs(tree_list[[i]])
  }
  return(br_lens_matrix)
}
##############


##########
# Confirm that the new metric works, by visually inspecting the mds
scaled_brs <- get_scaled_brs(trees_sim)

dist_trees <- dist(scaled_brs)
col_points <- rainbow(10)[rep(1:10, 10)]
library(rgl)
plot3d(cmdscale(dist_trees, k = 3), col = col_points, type = 's')
############

#####
# Test standard clustering
cl1 <- clusGap(scaled_brs, clara, K.max = 90, B = 50)
