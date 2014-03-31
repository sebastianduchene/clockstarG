
########################

run.irlba <- function(matrix.name, out.irlba.name = "test_irlba.txt"){

  require(irlba)

  dat.matrix <- as.matrix(read.table(matrix.name, head = T, row.names = 1))

  dat.irlba <- irlba(dat.matrix, nu = 3, nv = 1)

  dat.clus <- dat.irlba$u

  rownames(dat.clus) <- rownames(dat.matrix)

  write.table(dat.clus, file = paste0("u_",out.irlba.name), row.names = T, col.names = T)
  write.table(dat.irlba$d, file = paste0("d_", out.irlba.name), row.names = T, col.names = T)
  write.table(dat.irlba$v, file = paste0("v_", out.irlba.name), row.names = T, col.names = T)
}

