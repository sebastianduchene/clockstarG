library(clockstar)
library(bigmemory)

args <- commandArgs(TRUE)

tree.file.name <- args[1]

comp.file.name <- args[2]


comps <- read.big.matrix(comp.file.name, type = "integer", sep = " ")

for(i in 1:nrow(comps)){
      trees.names <- as.character(c(comps[i, 1], comps[i, 2]))
print(paste("Estimating distances for trees", paste(trees.names, collapse = " "), i,"of", nrow(comps)))
      tree.1 <- read.tree(text = system(paste0("awk '/^", trees.names[1], "[(]/{print}' ", tree.file.name), intern = T))
      tree.2 <- read.tree(text = system(paste0("awk '/^", trees.names[2], "[(]/{print}' ", tree.file.name), intern = T))
      res.vec <- t(as.matrix(c(trees.names, min.dist.topo(tree.1, tree.2))))
      write.table(res.vec, file = "dist.res.out.txt", append = T, row.names = F, col.names = F)
print(res.vec)
}

system("sed -i.bak 's/\"//g' dist.res.out.txt")

