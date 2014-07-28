\name{fold.sbsd}
\alias{fold.sbsd}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
fold.sbsd(trees.file, comps.file, out.name = "test.fold.txt", method = "lite", comps.range = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{trees.file}{
%%     ~~Describe \code{trees.file} here~~
}
  \item{comps.file}{
%%     ~~Describe \code{comps.file} here~~
}
  \item{out.name}{
%%     ~~Describe \code{out.name} here~~
}
  \item{method}{
%%     ~~Describe \code{method} here~~
}
  \item{comps.range}{
%%     ~~Describe \code{comps.range} here~~
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
function (trees.file, comps.file, out.name = "test.fold.txt", 
    method = "lite", comps.range = NULL) 
{
    tree.names <- system(paste("awk '{print $1}' FS='('", trees.file), 
        intern = T)
    if (is.null(comps.range)) 
        comps.range <- 1:length(tree.names)
    if (1 \%in\% comps.range) {
        cat(paste(c(tree.names[1], rep(NA, length(tree.names) - 
            1)), collapse = " "), file = paste0("sbsd", out.name), 
            append = T, sep = "\n")
        cat(paste(c(tree.names[1], rep(NA, length(tree.names) - 
            1)), collapse = " "), file = paste0("s", out.name), 
            append = T, sep = "\n")
    }
    if (method == "lite") {
        t1 <- proc.time()
        for (i in comps.range[2:length(comps.range)]) {
            comps.names <- paste(tree.names[i], tree.names[1:i - 
                1])
            print(comps.names)
            dat.name <- tree.names[i]
            comps.awk <- system(paste0("awk '", paste0("/", comps.names, 
                "/", collapse = " || "), "' ", comps.file), intern = T)
            if (length(comps.awk) == 0) {
                dat.sbsd <- rep(NA, length(tree.names) - 1)
                dat.s <- rep(NA, length(tree.names) - 1)
                print(paste("sBSDmin and s for tree", tree.names[i], 
                  "not found. Filling with NA"))
            }
            else {
                comps.text <- strsplit(comps.awk, " ")
                dat.all <- sapply(1:length(comps.text), function(x) return(comps.text[[x]][3:4]), 
                  USE.NAMES = F)
                dat.sbsd <- dat.all[1, ]
                dat.s <- dat.all[2, ]
            }
            dat.sbsd <- c(dat.sbsd, rep(NA, length(tree.names) - 
                i))
            dat.s <- c(dat.s, rep(NA, length(tree.names) - i))
            cat(paste(dat.name, paste(dat.sbsd, collapse = " ")), 
                file = paste0("sbsd", out.name), append = T, 
                sep = "\n")
            cat(paste(dat.name, paste(dat.s, collapse = " ")), 
                file = paste0("s", out.name), append = T, sep = "\n")
            print(paste("WRITTING DISTANCES FOR TREE", dat.name))
            print(paste(dat.sbsd, collapse = " "))
            print(paste(dat.s, collapse = " "))
        }
        t2 <- proc.time()
        print("FOLDING THE DISTANCES FOR WITH LITE MODE TOOK")
        print(t2 - t1)
    }
    if (method == "memory") {
        t1 <- proc.time()
        comps.dat.raw <- read.table(comps.file, head = F, as.is = T)
        comps.dat <- data.frame(V1 = paste(comps.dat.raw[, 1], 
            comps.dat.raw[, 2]), V2 = comps.dat.raw[, 3], V3 = comps.dat.raw[, 
            4])
        rm("comps.dat.raw")
        for (i in comps.range[2:length(comps.range)]) {
            comps.names <- paste(tree.names[i], tree.names[1:i - 
                1])
            dat.name <- tree.names[i]
            if (all(comps.names \%in\% comps.dat[, 1])) {
                dat.all <- sapply(comps.names, function(x) return(comps.dat[comps.dat[, 
                  1] == x, 2:3]), USE.NAMES = F)
                dat.sbsd <- c(unlist(dat.all[1, ]), rep(NA, length(tree.names) - 
                  i))
                dat.s <- c(unlist(dat.all[2, ]), rep(NA, length(tree.names) - 
                  i))
            }
            else {
                dat.sbsd <- rep(NA, length(tree.names) - 1)
                dat.s <- rep(NA, length(tree.names) - 1)
                print(paste("sBSDmin for tree", tree.names[i], 
                  "not found. Filling with NA"))
            }
            cat(paste(dat.name, paste(dat.sbsd, collapse = " ")), 
                file = paste0("sbsd", out.name), append = T, 
                sep = "\n")
            cat(paste(dat.name, paste(dat.s, collapse = " ")), 
                file = paste0("s", out.name), append = T, sep = "\n")
            print(paste("WRITTING DISTANCES FOR TREE", dat.name))
            print(paste(dat.sbsd, collapse = " "))
            print(paste(dat.s, collapse = " "))
        }
        t2 <- proc.time()
        print("FOLDING THE DISTANCES FOR WITH MEMORY MODE TOOK")
        print(t2 - t1)
    }
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
