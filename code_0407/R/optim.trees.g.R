optim.trees.g <-
function(data.folder, init.alin = NULL, end.alin = NULL, out.trees = "out.trees", model.test = F, out.models = "out.models.txt"){

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
      dat.temp <- tryCatch(read.phyDat(alin.names[i], format = "fasta"), error = function(x) "file not read")
      if(class(dat.temp) == "character"){
        print(paste("file", alin.names[i], "not read"))
	cat(alin.names[i], file = "errors.log", sep = "\n", append = T)
        next
      }
      pml.temp <- pml(tree = fix.tree, data = dat.temp)

      if(model.test){
        print(paste("Tesing models for", alin.names[i]))
        model.temp <- modelTest(pml.temp, model = c("GTR", "HKY"))
        model.temp <- model.temp[order(model.temp$BIC), ][1, 1]	
	print(paste("The model for", alin.names[i], "is", model.temp))
	cat(paste(alin.names[i], model.temp, collapse = " "), file = "models.test.txt", sep = "\n", append = T)
	optim.temp <- optim.pml(pml.temp, model = c("GTR", "HKY")[1+as.numeric(grepl("HKY", model.temp))], optInv = grepl("[+]I", model.temp), optGamma = grepl("[+]G", model.temp))
      }else{
	optim.temp <- optim.pml(pml.temp)
      }
      write.tree(phy = optim.temp$tree, file  = out.trees, append  = T, tree.names = alin.names[i])
      rm(list = c("dat.temp", "pml.temp", "optim.temp"))
  }

  setwd(wd.init)

}
