optim.trees.g <-
function(data.folder, init.alin = NULL, end.alin = NULL, out.trees = "out.trees"){

  require(ape)
  require(phangorn)

  wd.init <- getwd()
  setwd(data.folder)

  alin.names <- grep("fasta", dir(), value = T)
  tree.name <- grep("[.]tre", dir(), value = T)

  if(is.null(init.alin) || is.null(end.alin)){
    init.alin <- 1
    end.alin <- length(alin.names)
  }

  range.alin <- init.alin:end.alin
  fix.tree <- read.tree(tree.name)
  fix.tree <- unroot(fix.tree)

  if(is.null(fix.tree$edge.length)){
	fix.tree$edge.length <- rtree(n = length(fix.tree$tip.label))$edge.length
  }

  for(i in range.alin){
      print(paste("OPTIMISING FOR", alin.names[i]))
      dat.temp <- read.phyDat(alin.names[i], format = "fasta")
      pml.temp <- pml(tree = fix.tree, data = dat.temp)
      optim.temp <- optim.pml(pml.temp)
      write.tree(phy = optim.temp$tree, file  = out.trees, append  = T, tree.names = alin.names[i])
      rm(list = c("dat.temp", "pml.temp", "optim.temp"))
  }

  setwd(wd.init)

}
