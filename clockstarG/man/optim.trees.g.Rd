\name{optim.trees.g}
\alias{optim.trees.g}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
optim.trees.g(data.folder, init.alin = NULL, end.alin = NULL, out.trees = "out.trees", model.test = F, out.models = "out.models.txt")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data.folder}{
%%     ~~Describe \code{data.folder} here~~
}
  \item{init.alin}{
%%     ~~Describe \code{init.alin} here~~
}
  \item{end.alin}{
%%     ~~Describe \code{end.alin} here~~
}
  \item{out.trees}{
%%     ~~Describe \code{out.trees} here~~
}
  \item{model.test}{
%%     ~~Describe \code{model.test} here~~
}
  \item{out.models}{
%%     ~~Describe \code{out.models} here~~
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
function (data.folder, init.alin = NULL, end.alin = NULL, out.trees = "out.trees", 
    model.test = F, out.models = "out.models.txt") 
{
    require(ape)
    require(phangorn)
    wd.init <- getwd()
    setwd(data.folder)
    alin.names <- grep("fasta", dir(), value = T)
    tree.name <- grep("[.]tre", dir(), value = T)
    if (is.null(init.alin) || is.null(end.alin)) {
        init.alin <- 1
        end.alin <- length(alin.names)
    }
    range.alin <- init.alin:end.alin
    fix.tree <- read.tree(tree.name)
    fix.tree <- unroot(fix.tree)
    if (is.null(fix.tree$edge.length)) {
        fix.tree$edge.length <- rtree(n = length(fix.tree$tip.label))$edge.length
    }
    for (i in range.alin) {
        print(paste("OPTIMISING FOR", alin.names[i]))
        dat.temp <- tryCatch(read.phyDat(alin.names[i], format = "fasta"), 
            error = function(x) "file not read")
        if (class(dat.temp) == "character") {
            print(paste("file", alin.names[i], "not read"))
            cat(alin.names[i], file = "errors.log", sep = "\n", 
                append = T)
            next
        }
        pml.temp <- pml(tree = fix.tree, data = dat.temp)
        if (model.test) {
            print(paste("Tesing models for", alin.names[i]))
            model.temp <- modelTest(pml.temp, model = c("GTR", 
                "HKY"))
            model.temp <- model.temp[order(model.temp$BIC), ][1, 
                1]
            print(paste("The model for", alin.names[i], "is", 
                model.temp))
            cat(paste(alin.names[i], model.temp, collapse = " "), 
                file = "models.test.txt", sep = "\n", append = T)
            optim.temp <- optim.pml(pml.temp, model = c("GTR", 
                "HKY")[1 + as.numeric(grepl("HKY", model.temp))], 
                optInv = grepl("[+]I", model.temp), optGamma = grepl("[+]G", 
                  model.temp), k = 4)
        }
        else {
            optim.temp <- optim.pml(pml.temp)
        }
        write.tree(phy = optim.temp$tree, file = out.trees, append = T, 
            tree.names = alin.names[i])
        rm(list = c("dat.temp", "pml.temp", "optim.temp"))
    }
    setwd(wd.init)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
