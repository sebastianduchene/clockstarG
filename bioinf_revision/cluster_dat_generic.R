source('../functions.R')
library(ape)
library(methods)

trees_all <- read.tree('gene_trs.trees')

br_matrix <- get_scaled_brs(trees_all)
write.table(br_matrix, file = 'br_matrix.txt')

<<<<<<< HEAD
reg_gap <- optim_clusters_coord(br_matrix, kmax = 50, b_reps = 50, n_clusters = 2, plot_clustering = T)
=======
reg_gap <- optim_clusters_coord(br_matrix, kmax = 430, b_reps = 100, n_clusters = 10, plot_clustering = F)
>>>>>>> 14a74436b0a960c2b1b72935650cc311bd1d775c
