\name{fill.matrix}
\alias{fill.matrix}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
fill.matrix(matrix.name, new.matrix.name = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{matrix.name}{
%%     ~~Describe \code{matrix.name} here~~
}
  \item{new.matrix.name}{
%%     ~~Describe \code{new.matrix.name} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

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
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
