\name{get.sbsd}
\alias{get.sbsd}
\title{
get.sbsd calculates the sBSDmin distance for pairs of trees. It is similar to the function bsd.dist in ClockstaR2, but it can handle data sets with many trees.
}
\description{
get.sbsd calculates the sBSDmin distance for pairs of trees. It is similar to the function bsd.dist in ClockstaR2, but it can handle data sets with many trees.
}
\usage{
get.sbsd(trees.file, comps.file, method = "lite", range.comps = NULL, out.file = "sbsd.txt")
}
\arguments{
  \item{trees.file}{
The name of the file with the gene trees. This is a newick with a list of the gene trees with branch lengths. The trees can include names. See the tutorial and example files for details.
}
  \item{comps.file}{
The name of the file with the tree comparissons.
}
  \item{method}{
There are two methods available: 'memory' and 'lite'. Use 'memory' to load all the trees in RAM. Use 'lite' to read the trees one at a time, so it can be parallelised over different machines or processors. The method 'memory' is faster, i the analysis is not run in parallel. 
}
  \item{range.comps}{
This is useful for the 'lite' method. In this case it is possible to run several instances of the analysis, each for a range of sBSDmin distances among trees.
}
  \item{out.file}{
The name of the file to write the output.
}
}
\details{
Please see the tutorial for instructions.
}
\value{
This function does not return a value to the prompt. It saves the output to a text file.
}
\author{
Sebastian Duchene
}
\note{
NONE
}

\seealso{
NONE
}
