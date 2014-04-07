

boot.clara <- function(clus.matrix.name, out.boot.name = "out_boot.txt", nboot = 10, k.range = NULL){
  dat <- read.table(clus.matrix.name, head = T, row.name = 1)
  dat.boot <- dat
  for(k in 1:nboot){
    for(i in 1:ncol(dat.boot)){
      dat.boot[,i] <- runif(nrow(dat), min(dat[, i]), max(dat[, i])) 
    }
    write.table(dat.boot, "boot.temp.txt")
    run.clara(clus.matrix.name = "boot.temp.txt", out.clus.name = out.boot.name, k.range = k.range)  
  }
}

