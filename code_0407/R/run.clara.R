run.clara <-
function(clus.matrix.name, out.clus.name = "out_clus_test.txt", k.range = NULL, ...){

  dat.clus <- as.matrix(read.table(clus.matrix.name, row.names = 1, head = T))

  require(cluster)

  if(is.null(k.range)) k.range <- 1:(nrow(dat.clus) - 1)

  print("I WILL START COMPUTING LOGW WITH CLARA")

# The code for this function is taken from cluster
    ii <- 1:nrow(dat.clus)
#    FUNcluster <- clara
    W.k <- function(X, kk) {
        clus <- if (kk > 1)
            clara(X, kk, ...)$cluster
        else rep.int(1L, nrow(X))
        0.5 * sum(vapply(split(ii, clus), function(I) {
            xs <- X[I, , drop = FALSE]
            sum(dist(xs)/nrow(xs))
        }, 0))
    }

  for(i in k.range){
      w.temp <- log10(W.k(X = dat.clus, kk = i, ...)) 
      res.temp <- paste(i, w.temp, collapse = " ")
      cat(res.temp, file = out.clus.name, sep = "\n", append = T)
      print(paste("k =", res.temp))
  }
  print(paste("CLUSTERING DATA SAVED IN", out.clus.name))
}
