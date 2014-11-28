# Simulate some data:
library(ape)
library(phangorn)
library(cluster)
source('functions.R')

# 57 branches for unrooted trees of 30 taxa
#k=1, 2, 5, 10, 15, 100, N 
mammal_data <- read.table('R2_analyses/classification_data.csv', head = T, sep = ',', as.is = T)

gene_names <- mammal_data$X[!is.na(mammal_data$length)]
bfs_tl <- mammal_data[!is.na(mammal_data$length), c(3, 4, 5, 6, 10)]
s_lens <- mammal_data[!is.na(mammal_data$length), 2]
gene_sim_dat <- cbind(gene_names, bfs_tl, s_lens)

generate_data <- function(PM, f_name){
pms <- lapply(1:PM, function(x) rlnorm(57, meanlog = -4.6, sdlog = 0.5))
pms <- rep(pms, length(gene_names))[1:nrow(gene_sim_dat)]

tree_topo <- unroot(rtree(30))
trees_sim <- list()

#Generate trees for the mammals
for(i in 1:nrow(gene_sim_dat)){
      tr_temp <- tree_topo
      tr_temp$edge.length <- pms[[i]]
      tr_temp$edge.length <- tr_temp$edge.length / sum(tr_temp$edge.length) * gene_sim_dat$tree_length[i]
      trees_sim[[i]] <- tr_temp
}

# consider pasting pm names for k > 1
names(trees_sim) <- gene_sim_dat$gene_names
write.tree(tree_topo, file = paste0(f_name, '/tree_topo.tree'))
for(i in 1:length(trees_sim)){
  sim_temp <- as.DNAbin(simSeq(trees_sim[[i]], l = gene_sim_dat$s_lens[i], bf = as.numeric(gene_sim_dat[i, c(2, 3, 4, 5)])))
  write.dna(sim_temp, file = paste0(f_name, '/sim_', gene_sim_dat$gene_names[i]), format = 'fasta', nbcol = -1, colsep = '')
}
return(trees_sim)
}

k1 <- generate_data(1, 'k1')
k2 <- generate_data(2, 'k2')
k5 <- generate_data(5, 'k5')
k10 <- generate_data(10, 'k10')
k15 <- generate_data(15, 'k15')
k100 <- generate_data(100, 'k100')
kN <- generate_data(431, 'kN')

############################







##########
# Confirm that the new metric works, by visually inspecting the mds
#scaled_brs <- get_scaled_brs(trees_sim)

#dist_trees <- dist(scaled_brs)
#col_points <- rainbow(10)[rep(1:10, 10)]
#library(rgl)
#plot3d(cmdscale(dist_trees, k = 3), col = col_points, type = 's')
############

#####
# Test clustering
#tc5 <- system.time(optim_clusters_coord(scaled_brs, n_clusters = 5, plot_clustering = T, kmax = 350, b_reps = 50))

#tc10 <- system.time(optim_clusters_coord(scaled_brs, n_clusters = 10, plot_clustering = T, kmax = 350, b_reps = 50))

#tc_test <- cl_clusGap(scaled_brs, K.max = 50, B = 10 , n_clusters = 5)
#tc_coord <- optim_clusters_coord(scaled_brs, n_clusters = 5, plot_clustering = T, kmax = 50, b_reps = 50)
