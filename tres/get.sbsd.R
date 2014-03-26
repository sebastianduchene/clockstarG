
trees.file <- "out.trees"
comps.file <- "treecomps.txt"
out.file <- "sbsd.txt"

range.comps <- NULL
##



require(ClockstaR2)

n.comps <- as.numeric(strsplit(system(paste("wc -l", comps.file), intern = T), " ")[[1]][6])
if(is.null(range.comps)) range.comps <- 1:n.comps

# Lite version
################
if(method == "lite"){

print("Memory lite version")

t1 <- proc.time()
n <- 0
for(i in range.comps){
      n <- n + 1
      trees.comps.temp <- system(paste0("awk 'NR==", i,"' " ,  comps.file), intern = T)
      names.temp <- strsplit(trees.comps.temp, " ")[[1]][1:2]
      tree1.comp <- read.tree(text = system(paste0("awk /", names.temp[1], "/ ", trees.file), intern = T))
      tree2.comp <- read.tree(text = system(paste0("awk /", names.temp[2], "/ ", trees.file), intern = T))      
      print(paste("ESTIMATING sBSDmin for", names.temp[1], names.temp[2]))
      print(paste("COMPLETED", n, "of", length(range.comps))) 
      dist.temp <- bsd.dist(tree1.comp, tree2.comp)
            
      
      #trees1.comp <- 
      #save in a text file after estimating each sbsdmin
}
t2 <- proc.time()
print("ESTIMATING THE bBSDmin TOOK:")
print( t2 - t1)
}



# Memory intensive version
##########################
if(method == "memory"){

print("Memory intensive version")
print("reading trees and comps file")
trees.comp <- read.tree(trees.file)
names.comp <- readLines(comps.file)

t1 <- proc.time()
n <- 0
for(i in range.comps){
      n <- n + 1
      names.temp <- strsplit(names.comp[i], " ")[[1]][1:2]
      tree1.comp <- trees.comp[[names.temp[1]]]
      tree2.comp <- trees.comp[[names.temp[2]]]
      print(paste("ESTIMATING sBSDmin for", names.temp[1], names.temp[2]))
      print(paste("COMPLETED", n, "of", length(range.comps))) 
      dist.temp <- bsd.dist(tree1.comp, tree2.comp)
            
      
      #trees1.comp <- 

}
t2 <- proc.time()

print("ESTIMATING THE sBSDmin TOOK:")
print(t2 - t1)
}