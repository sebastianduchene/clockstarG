
run.clara <- function(clus.matrix.name, out.clus.name = "out_clus_test.txt", k.range = NULL){

  dat.clus <- as.matrix(read.table(clus.matrix.name, row.names = 1, head = T))

  require(cluster)


  if(is.null(k.range)) k.range <- 2:(nrow(dat.clus) - 1)


  print("I WILL START COMPUTING LOGW WITH CLARA")

  for(i in k.range){
      w.temp <- log10(clara(dat.clus, k = i)$silinfo$avg.width)
      res.temp <- paste(i, w.temp, collapse = " ")
      cat(res.temp, file = out.clus.name, sep = "\n", append = T)
      print(paste("k =", res.temp))
  }
  print(paste("CLUSTERING DATA SAVED IN", out.clus.name))
}