library(randomForest)

class_data_raw <- as.matrix(read.table('classification_data.csv', sep = ',', head = T, stringsAsFactors = F))

clustering_r2 <- as.matrix(read.table('opt_clus_id.txt', head = T, stringsAsFactors = F))


class_data_merge <- cbind(class_data_raw, clustering_r2[match(class_data_raw[, 1], rownames(clustering_r2)), ])

class_data_merge <- as.data.frame(class_data_merge[which(!is.na(class_data_merge[, 2])), ], stingsAsFactors = F)
colnames(class_data_merge)[13] <- 'cluster_r2'

#class_data_merge <-  class_data_merge[-which(is.na(class_data_merge$gen

clean_data_vars <- data.frame(g_length = as.numeric(class_data_merge$length), cg_cont = as.numeric(class_data_merge$cg_content), t_length = as.numeric(class_data_merge$tree_length), cv_tree = as.numeric(class_data_merge$tree_cv), g_name  = class_data_merge$gene_name, chromosome = as.factor(class_data_merge$chromosome), cluster = factor(class_data_merge$cluster_r2))

clean_data_vars <- clean_data_vars[-which(is.na(clean_data_vars$g_name)), ]


#> cbind(mat1, mat2[match(mat1[, 1], mat2[, 1]), ])
#     [,1] [,2] [,3] [,4] [,5] [,6]
#[1,] "a"  "d"  "g"  "a"  "d"  "g"
#[2,] "b"  "e"  "h"  "b"  "e"  "h"
#[3,] "c"  "f"  "i"  "c"  "f"  "i"
#[4,] "f"  "tt" "aa" NA   NA   NA

cat('fitting RF\n')
rf1 <- randomForest(cluster ~ cg_cont + t_length + g_length, data = clean_data_vars, importance = T, maxnodes = 4 , ntree = 30)
#40% oob error rate
#         MeanDecreaseAccuracy MeanDecreaseGini
#cg_cont            -0.7652881         3.150150
#t_length           -0.1578527         4.162437
#g_length           -1.4346393         3.356445


library(tree)

cat('Fitting class tree\n')
tr1 <- tree(cluster ~ cg_cont + t_length + g_length, data = clean_data_vars)
tr_1.dev <- cv.tree(tr1)
tr_1.p <- prune.misclass(tr1, best = 2)

#misclass 37.6%
#vars retained tlength, cgcont