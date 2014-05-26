library(phangorn)
library(ClockstaR2)

all_trees <- read.tree("empirical_data/out1.trees")

# getting the tree stats

res_mat  <- matrix(NA, nrow = length(all_trees), ncol = 2)

for(i in 1:length(all_trees)){
    res_mat[i, ] <- c(sum(all_trees[[i]]$edge.length), sd(all_trees[[i]]$edge.length) / mean(all_trees[[i]]$edge.length))
    if(i %% 10 == 0){
      	print(paste(paste("trees", names(all_trees)[i]), res_mat[i, ]))
    }
}

rownames(res_mat) <- names(all_trees)
colnames(res_mat) <- c("tree_length", "tree_cv")


write.table(res_mat, file = "tree_stats.csv", sep = ",")