#Script to unfold the sbsdmin distances and format them for the clustering algo in clockstar
# Edited on Feb 22 2014 at 13:53
# This is a faster version of unforld. It reads the distances as a big matrix object instead of reading each line from the file. 
# This is efficient because bigmatrix objects do not consume as much ram as loading the object in R, and it is faster than 
# invoquing awk commands from R


args <- commandArgs(TRUE)

library(bigmemory)
#options(bigmemory.allow.dimnames = TRUE)

trees.file <- args[1]
comps.file <- args[2]

#n.comps <- as.numeric(gsub("[A-Z]|[a-z]|[.]| |_", "", system(paste("wc -l", comps.file), intern = T)))
#print("The number of comparisons is ")
#print(n.comps - 1)

n.trees <- gsub("[A-Z]|[a-z]|[.]| |_[0-9]*", "", system(paste0("wc -l ", trees.file), intern = T))
print("The number of trees is ")
print(as.numeric(n.trees))

print("creating big matrix")
res.mat <- big.matrix(nrow = n.trees, ncol = n.trees, type = "double")

mat.names <- system(paste("awk '{print $1}' FS=\"(\" ", trees.file), intern = T)

print("reading tree distance file as a big matrix")
comps <- read.big.matrix(comps.file, type = "double", sep = " ", head = F)
print("The number of rows in the distances file is:")
print(nrow(comps))

for(i in 1:nrow(comps)){
      comp.temp <- comps[i, ]
      res.mat[which(mat.names == comp.temp[1])[1], which(mat.names == comp.temp[2])[1]] <- as.numeric(comp.temp[3])
      if(i %% 1000 == 0){
            print("getting the distances for trees")
      	    print(as.character(comp.temp))
	    print("The current progress is:")
	    print(paste(100 * round(i/nrow(comps), 5), "%"))
     }
}


write.big.matrix(res.mat, file = "res_mat.txt")
cat(paste(mat.names, collapse = ","), file = "res_mat_1.txt")
cat("\n", file = "res_mat_1.txt", append = T)
system("cat res_mat.txt >> res_mat_1.txt")
system("rm res_mat.txt")
system("mv res_mat_1.txt res_mat.txt")

