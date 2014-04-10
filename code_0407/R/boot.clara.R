

boot.clara <- function(clus.matrix.name, out.boot.name = "out_boot.txt", nboot = 10, k.range = NULL, boot.temp.name = "boot.temp.txt", FUNboot = run.clara.wk){
  dat <- read.table(clus.matrix.name, head = T, row.name = 1)
  dat.boot <- dat
  for(k in 1:nboot){
    for(i in 1:ncol(dat.boot)){
      #dat.boot[, i] <- rnorm(nrow(dat), mean = mean(dat[, i]), sd = sd(dat[, i]))
      dat.boot[,i] <- runif(nrow(dat), min(dat[, i]), max(dat[, i])) 
    }
    write.table(dat.boot, paste0(boot.temp.name, k))
    FUNboot(clus.matrix.name = paste0(boot.temp.name, k), out.clus.name = out.boot.name, k.range = k.range)
    system(paste0("rm ", boot.temp.name, k))  
  }
}

