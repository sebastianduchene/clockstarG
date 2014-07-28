\name{run.mds}
\alias{run.mds}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
run.mds(matrix.name, out.mds.name = "test_mds.txt")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{matrix.name}{
%%     ~~Describe \code{matrix.name} here~~
}
  \item{out.mds.name}{
%%     ~~Describe \code{out.mds.name} here~~
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
function (matrix.name, out.mds.name = "test_mds.txt") 
{
    dat.matrix <- as.matrix(read.table(matrix.name, head = T, 
        row.names = 1))
    dat.mds <- cmdscale(dat.matrix, k = 3, eig = T)
    dat.clus <- dat.mds$points
    write.table(dat.clus, file = paste0("points_", out.mds.name), 
        row.names = T, col.names = T)
    write.table(dat.mds$eig, file = paste0("eig_", out.mds.name), 
        row.names = T, col.names = T)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
