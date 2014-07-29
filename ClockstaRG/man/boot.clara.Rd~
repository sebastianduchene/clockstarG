\name{boot.clara}
\alias{boot.clara}
\title{
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
boot.clara(clus.matrix.name, out.boot.name = "out_boot.txt", nboot = 10, k.range = NULL, boot.temp.name = "boot.temp.txt", FUNboot = run.clara.wk)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{clus.matrix.name}{
%%     ~~Describe \code{clus.matrix.name} here~~
}
  \item{out.boot.name}{
%%     ~~Describe \code{out.boot.name} here~~
}
  \item{nboot}{
%%     ~~Describe \code{nboot} here~~
}
  \item{k.range}{
%%     ~~Describe \code{k.range} here~~
}
  \item{boot.temp.name}{
%%     ~~Describe \code{boot.temp.name} here~~
}
  \item{FUNboot}{
%%     ~~Describe \code{FUNboot} here~~
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
function (clus.matrix.name, out.boot.name = "out_boot.txt", nboot = 10, 
    k.range = NULL, boot.temp.name = "boot.temp.txt", FUNboot = run.clara.wk) 
{
    dat <- read.table(clus.matrix.name, head = T, row.name = 1)
    dat.boot <- dat
    for (k in 1:nboot) {
        for (i in 1:ncol(dat.boot)) {
            dat.boot[, i] <- runif(nrow(dat), min(dat[, i]), 
                max(dat[, i]))
        }
        write.table(dat.boot, paste0(boot.temp.name, k))
        FUNboot(clus.matrix.name = paste0(boot.temp.name, k), 
            out.clus.name = out.boot.name, k.range = k.range)
        system(paste0("rm ", boot.temp.name, k))
    }
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
