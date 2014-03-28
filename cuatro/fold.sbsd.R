#trees.file <- "out.trees"
#comps.file <- "sbsd.txt"
#out.name <- "test.fold.txt"
#comps.range <- 1:5

#NEED TO ADD THE FIRST TREE NAME WITH NAS



fold.sbsd <- function(trees.file, comps.file, out.name = "test.fold.txt", method = "lite", comps.range = NULL){

  tree.names <- system(paste("awk '{print $1}' FS='('", trees.file), intern = T)

  if(is.null(comps.range)) comps.range <- 1:length(tree.names)

  if(method == "lite"){
  # Memory lite version
  #####################

  t1 <- proc.time()

  for(i in comps.range[2:length(comps.range)]){
    comps.names <- paste(tree.names[i], tree.names[1:i-1])
    dat.name <- tree.names[i]
    comps.awk <- system(paste0("awk '", paste0("/", comps.names, "/", collapse = " || "), "' ", comps.file), intern = T)

    comps.text <- strsplit(comps.awk, " ")

    dat.all <- sapply(1:length(comps.text), function(x) return(comps.text[[x]][3:4]), USE.NAMES = F)

    dat.sbsd <- dat.all[1, ]
    dat.s <- dat.all[2, ]

    dat.sbsd <- c(dat.sbsd, rep(NA, length(tree.names) - i))
    dat.s <- c(dat.s, rep(NA, length(tree.names) - i))

    cat(paste(dat.name, paste(dat.sbsd, collapse = " ")), file = paste0("sbsd", out.name), append = T, sep = "\n")
    cat(paste(dat.name, paste(dat.s, collapse = " ")), file = paste0("s", out.name), append = T, sep = "\n")

    print(paste("WRITTING DISTANCES FOR TREE", dat.name))  
    print(paste(dat.sbsd, collapse = " "))
    print(paste(dat.s, collapse = " "))
  }

  t2 <- proc.time()
  print("FOLDING THE DISTANCES FOR WITH LITE MODE TOOK")
  print(t2 - t1)
  }

  # Memory intensive version
  ##########################
  if(method == "memory"){
    # the comps file is loaded in R, but the data sholud be exported sequentially
    t1 <- proc.time()
    comps.dat.raw <- read.table(comps.file, head = F, as.is = T)
    comps.dat <- data.frame(V1=paste(comps.dat.raw[, 1], comps.dat.raw[, 2]), V2 = comps.dat.raw[, 3], V3 = comps.dat.raw[, 4])
    rm("comps.dat.raw")

    for(i in comps.range[2:length(comps.range)]){
      comps.names <- paste(tree.names[i], tree.names[1:i-1])
      dat.name <- tree.names[i]
      dat.all <- sapply(comps.names, function(x) return(comps.dat[comps.dat[,1]== x, 2:3]), USE.NAMES = F)
      dat.sbsd <- c(unlist(dat.all[1, ]), rep(NA, length(tree.names) - i))
      dat.s <- c(unlist(dat.all[2, ]), rep(NA, length(tree.names) - i))
      cat(paste(dat.name, paste(dat.sbsd, collapse = " ")), file = paste0("sbsd", out.name), append = T, sep = "\n")
      cat(paste(dat.name, paste(dat.s, collapse = " ")), file = paste0("s", out.name), append = T, sep = "\n")
      print(paste("WRITTING DISTANCES FOR TREE", dat.name))
      print(paste(dat.sbsd, collapse = " "))
      print(paste(dat.s, collapse = " "))
    }
    t2 <- proc.time()
    print("FOLDING THE DISTANCES FOR WITH MEMORY MODE TOOK")
    print(t2 - t1)
  }

}

# To read the matrix use read.table(data file name, head = F, row.names = 1)
# then add the missing rows, add column names and fill in NAs