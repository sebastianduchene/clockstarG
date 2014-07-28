get.sbsd <-
function(trees.file, comps.file, method = "lite", range.comps = NULL, out.file = "sbsd.txt"){

require(ClockstaR2)

n.comps <- as.numeric(strsplit(system(paste("wc -l", comps.file), intern = T), " ")[[1]])
n.comps <- n.comps[!is.na(n.comps)]


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
      #Using a single awk command
      trees.text <- system(paste0("awk '/", names.temp[1], "/ || /", names.temp[2], "/' ", trees.file), intern = T)
      tree1.comp <- read.tree(text = trees.text[1])
      tree2.comp <- read.tree(text = trees.text[2])


      dist.temp <- bsd.dist(tree1.comp, tree2.comp)
      print(paste("COMPLETED sBSDmin", n, "of", length(range.comps))) 
      res.temp <- paste(names.temp[1], names.temp[2], dist.temp[1], dist.temp[2])
      print(res.temp)           
      cat(res.temp, file = out.file, append = T, sep = "\n")
  }
  t2 <- proc.time()
  print("ESTIMATING THE bBSDmin TOOK:")
  print( t2 - t1)
  print(paste("The results are saved in", out.file))
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
      dist.temp <- bsd.dist(tree1.comp, tree2.comp)                  
      print(paste("COMPLETED sBSDmin", n, "of", length(range.comps))) 
      res.temp <- paste(names.temp[1], names.temp[2], dist.temp[1], dist.temp[2])
      print(res.temp)           
      cat(res.temp, file = out.file, append = T, sep = "\n")

  }
  t2 <- proc.time()

  print("ESTIMATING THE sBSDmin TOOK:")
  print(t2 - t1)
  print(paste("The results are saved in", out.file))
}

}
