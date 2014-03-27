trees.file <- "out.trees"
comps.file <- "sbsd.txt"
out.name <- "test.fold.txt"
comps.range <- 1:5


tree.names <- system(paste("awk '{print $1}' FS='('", trees.file), intern = T)

if(is.null(comps.range)) comps.range <- 1:length(tree.names)

# Memory lite version
#####################

for(i in comps.range[2:length(comps.range)]){
  comps.names <- paste(tree.names[i], tree.names[1:i-1])
  dat.name <- tree.names[i]
  dat.sbsd <- vector()
  dat.s <- vector()
  for(k in 1:length(comps.names)){
    comps.dat <- strsplit(system(paste0("awk '/", comps.names[k], "/' ", comps.file), intern =T), split = " ")[[1]]
    dat.sbsd <- c(dat.sbsd, comps.dat[3])
    dat.s <- c(dat.s, comps.dat[4])
  }
  dat.sbsd <- c(dat.sbsd, rep(NA, length(tree.names) - i))
  dat.s <- c(dat.s, rep(NA, length(tree.names) - i))

  cat(paste(dat.name, paste(dat.sbsd, collapse = " ")), file = paste0("sbsd", out.name), append = T, sep = "\n")
  cat(paste(dat.name, paste(dat.s, collapse = " ")), file = paste0("s", out.name), append = T, sep = "\n")

  print(paste(dat.name, paste(dat.sbsd, collapse = " ")))
  print(paste(dat.name, paste(dat.s, collapse = " ")))

}


# Memory intensive version
##########################

# the comps file is loaded in R, but the data sholud be exported sequentially


# To read the matrix use read.table(data file name, head = F, row.names = 1)
# then add the missing rows, add column names and fill in NAs