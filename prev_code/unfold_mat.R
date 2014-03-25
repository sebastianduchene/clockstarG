#Script to unfold the sbsdmin distances and format them for the clustering algo in clockstar

args <- commandArgs(TRUE)

library(bigmemory)
options(bigmemory.allow.dimnames = TRUE)


trees.file <- args[1]
comps.file <- args[2]


n.comps <- as.numeric(gsub("[A-Z]|[a-z]|[.]| |_", "", system(paste("wc -l", comps.file), intern = T)))
print("The number of comparisons is ")
print(n.comps)

n.trees <- gsub("[A-Z]|[a-z]|[.]| |_[0-9]*", "", system(paste0("wc -l ", trees.file), intern = T))
print("The number of trees is ")
print(n.trees)

print("creating big matrix")
res.mat <- big.matrix(nrow = n.trees, ncol = n.trees, type = "double")


print("appending names to the big matrix")

mat.names <- system("awk '{print $1}' FS=\"(\" mp_40.trees", intern = T)

print(paste("the names are", paste(mat.names, collapse = ",")))
print(paste("this adds up to", length(mat.names), "trees"))


#rownames(res.mat) <- system("awk '{print $1}' FS=\"(\" mp_40.trees", intern = T)
#colnames(res.mat) <- rownames(res.mat)


for(i in 1:n.comps){
      comp.temp <- system(paste0("awk 'NR==", i, "' ", comps.file), intern = T)
      comp.temp <- strsplit(gsub("\"", "", comp.temp), " ")[[1]]

      res.mat[mat.names == comp.temp[1], mat.names == comp.temp[2]] <- as.numeric(comp.temp[3])
#      if(i %% 50 == 0){
            print("getting the distances for trees")
      	    print(comp.temp)
	    print("The current progress is:")
	    print(paste(100 * i/n.comps, "%"))
#      }
}


write.big.matrix(res.mat, file = "res_mat.txt", row.names = T, col.names = T)



