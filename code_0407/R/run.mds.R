run.mds <-
function(matrix.name, out.mds.name = "test_mds.txt"){

  dat.matrix <- as.matrix(read.table(matrix.name, head = T, row.names = 1))

  dat.mds <- cmdscale(dat.matrix, k = 3, eig = T)

  dat.clus <- dat.mds$points

  write.table(dat.clus, file = paste0("points_",out.mds.name), row.names = T, col.names = T)
  write.table(dat.mds$eig, file = paste0("eig_", out.mds.name), row.names = T, col.names = T)
}
