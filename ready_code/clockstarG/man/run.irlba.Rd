\name{run.irlba}
\alias{run.irlba}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
run.irlba(matrix.name, out.irlba.name = "test_irlba.txt")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{matrix.name}{
%%     ~~Describe \code{matrix.name} here~~
}
  \item{out.irlba.name}{
%%     ~~Describe \code{out.irlba.name} here~~
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
function (matrix.name, out.irlba.name = "test_irlba.txt") 
{
    require(irlba)
    dat.matrix <- as.matrix(read.table(matrix.name, head = T, 
        row.names = 1))
    dat.irlba <- irlba(dat.matrix, nu = 3, nv = 1)
    dat.clus <- dat.irlba$u
    rownames(dat.clus) <- rownames(dat.matrix)
    write.table(dat.clus, file = paste0("u_", out.irlba.name), 
        row.names = T, col.names = T)
    write.table(dat.irlba$d, file = paste0("d_", out.irlba.name), 
        row.names = T, col.names = T)
    write.table(dat.irlba$v, file = paste0("v_", out.irlba.name), 
        row.names = T, col.names = T)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
