library(tree)

data_classify <- read.table('classification_data.csv', sep = ',', head= T, row.names = 1, as.is = T)
data_classify$chromosome <- as.factor(data_classify$chromosome)
data_classify <- data_classify[!is.na(data_classify$length), ]


tr1 <- tree(factor(cluster) ~ cg_content + tree_cv + tree_length, data = data_classify)
plot(tr1)
text(tr1)

tr1.cv <- cv.tree(tr1) # choose the lowest deviance

tr1.p <- prune.misclass(tr1, best = 2)
plot(tr1.p)
text(tr1.p)


#library(rpart)
#r2 <- rpart(factor(cluster) ~ cg_content + tree_cv + tree_length + length, data = data_classify)
#tr2.p <- prune(tr2, cp = 0.01)
#printcp(tr2.p)


library(randomForest)

rf1 <- randomForest(factor(cluster) ~ cg_content + tree_cv + tree_length , data = data_classify, na.action = na.omit, prox = T)

print(rf1)
importance(rf1)
