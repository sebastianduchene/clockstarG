
matrix.name <- "fullmat.txt"

dat.matrix <- as.matrix(read.table(matrix.name, head = T, row.names = 1))

require(irlba)

dat.irlba <- irlba(dat.matrix, nu = 3, nv = 1)