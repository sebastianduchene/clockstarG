plot.clusters <- function(dat, nclus, cols.range = NULL,...){
  require(rgl)
  require(cluster)
  if(is.null(cols.range)) cols.range <- rainbow(nclus)
  clara.clus <- clara(dat, k = nclus)
  dat.clus <- clara.clus$clustering
  
  plot3d(dat$V1, dat$V2, dat$V3, col = cols.range[dat.clus], ...)
}