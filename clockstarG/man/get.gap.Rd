\name{get.gap}
\alias{get.gap}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
get.gap(true.data, boot.data)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{true.data}{
%%     ~~Describe \code{true.data} here~~
}
  \item{boot.data}{
%%     ~~Describe \code{boot.data} here~~
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
function (true.data, boot.data) 
{
    boot.means <- sapply(true.data[, 1], function(x) mean(boot.data[boot.data[, 
        1] == x, 2]))
    gap.dat <- boot.means - true.data[, 2]
    gap.se <- vector()
    B <- table(boot.data[, 1])[1]
    for (i in true.data[, 1]) {
        boot.temp <- boot.data[boot.data[, 1] == i, 2]
        gap.temp <- boot.temp - true.data[true.data[, 1] == i, 
            2]
        gap.se <- c(gap.se, diff(quantile(gap.temp, c(0.025, 
            0.975))))
    }
    gap.se <- gap.se/true.data[, 1]
    res.mat <- cbind(gap.dat, gap.se)
    colnames(res.mat) <- c("Gap", "SE")
    rownames(res.mat) <- true.data[, 1]
    return(res.mat)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
