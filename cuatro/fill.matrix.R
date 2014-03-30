


#matrix.name <- "sbsdmindat.txt"

fill.matrix <- function(matrix.name, new.matrix.name = NULL){

	    if(is.null(new.matrix.name)) new.matrix.name <- matrix.name

	    dat.mat <- read.table(matrix.name, head = F, row.names = 1)


	    dat.mat <- cbind(dat.mat , VX=rep(NA, nrow(dat.mat)))

	    dat.mat <- as.matrix(dat.mat)

	    for(i in 1:nrow(dat.mat)){
	      dat.mat[i, i:ncol(dat.mat)] <- dat.mat[i:ncol(dat.mat), i]
	   }

	   diag(dat.mat) <- 0
	   colnames(dat.mat) <- rownames(dat.mat)

	   write.table(dat.mat, file = new.matrix.name, append = F, row.names = T, col.names = T)
} 

#fill.matrix("sbsdmindat.txt", new.matrix.name = "fullmat.txt")