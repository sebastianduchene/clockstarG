source('../functions.R')
library(ape)
library(methods)

trees_all <- read.tree('gene_trs.trees')

br_matrix <- get_scaled_brs(trees_all)
write.table(br_matrix, file = 'br_matrix.txt')

reg_gap <- optim_clusters_coord(br_matrix, kmax = 430, b_reps = 100, n_clusters = 10, plot_clustering = F)
