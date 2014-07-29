\name{fold.sbsd}
\alias{fold.sbsd}
\title{
fold.sbsd formats the sBSDmin distances calculated with get.sbsd to be used in clustering algorithms.
}
\description{
fold.sbsd folds the output of get.sbsd into a pairwise matrix that can be used in clustering algorithms. 
}
\usage{
fold.sbsd(trees.file, comps.file, out.name = "test.fold.txt", method = "lite", comps.range = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{trees.file}{
The file with the gene trees, as produced in optim.trees.g
}
  \item{comps.file}{
The file with the sBSDmin distances among pairs of trees.
}
  \item{out.name}{
The name of the output file.
}
  \item{method}{
There are two methods available: 'memory' and 'lite'. The 'memory' method loads all the sBSDmin distances into RAM, while the 'lite' method reads one at a time. The 'memory' method is faster, but with 'lite' it is possible to overcome memory limitations from very large files.
}
  \item{comps.range}{
  A sequence of integers. This is the range of sBSDmin distances to read and format into the pairwise matrix. Use this for very large files that are difficult to read into RAM.
}
}
\details{
None. See the tutorial for instructions and deatails on some of the settings.
}
\value{
This function does not return a value to the prompt. Instead, it writes a text file with the pairwise distance matrix. Note that it only prints the below diagonal values of the matrix, and the rest is filled with NA. To complete these values in the matrix use fill.matrix. This is a requirement of some clusteing algorithms.
}
\author{
Sebastian Duchene
}
\note{
See the tutorial for instructions and deatails on some of the settings.
}
