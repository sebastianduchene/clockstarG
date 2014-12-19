source('../functions.R')
library(ape)
library(rgl)

mammal_trees_all <- read.tree('empirical_mammal.trees')
gene_data_table <- read.table('classification_data.csv', head = T, sep = ',', as.is = T)
gene_names_keep <- gene_data_table$X[!is.na(gene_data_table$length)]

mammal_trees <- mammal_trees_all[names(mammal_trees_all) %in% gene_names_keep]
br_matrix <- get_scaled_brs(mammal_trees)
write.table(br_matrix, file = 'mammal_br_matrix.txt')

reg_gap <- optim_clusters_coord(br_matrix, kmax = 430, b_reps = 100, n_clusters = 15, plot_clustering = T)
