\name{fill.matrix}
\alias{fill.matrix}
\title{
Fill the diagonal and upper triangle of the matrix
}
\description{
Fill the distance pairwise matrix above and bellow diagonals
}
\usage{
fill.matrix(matrix.name, new.matrix.name = NULL)
}
\arguments{
  \item{matrix.name}{
The name of a matrix with the pairwise distances.
}
  \item{new.matrix.name}{
The name of the output file for the matrix with diagonal and upper diagonal values complete.
}
}
\details{
See examples
}
\value{
No returned value. This function only saves a tab delimited file with the name and path in new.matrix.name
}
\author{
Sebastian Duchene
}


\seealso{
fold.sbsd
}
\examples{

\dontrun{
fill.matrix(matrix.name = "example_sbsdtest.fold.txt", new.matrix.name = "example_fill_sbsd.txt")
}

## The function is currently defined as
function (matrix.name, new.matrix.name = NULL) 
{
    if (is.null(new.matrix.name)) 
        new.matrix.name <- matrix.name
    dat.mat <- read.table(matrix.name, head = F, row.names = 1)
    dat.mat <- cbind(dat.mat, VX = rep(NA, nrow(dat.mat)))
    dat.mat <- as.matrix(dat.mat)
    for (i in 1:nrow(dat.mat)) {
        dat.mat[i, i:ncol(dat.mat)] <- dat.mat[i:ncol(dat.mat), 
            i]
    }
    diag(dat.mat) <- 0
    colnames(dat.mat) <- rownames(dat.mat)
    write.table(dat.mat, file = new.matrix.name, append = F, 
        row.names = T, col.names = T)
  }
}
\keyword{ clockstar }
