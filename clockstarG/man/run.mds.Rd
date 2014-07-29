\name{run.mds}
\alias{run.mds}
\title{
run.mds obtains a multidimensional scaling (MDS) of the pariwise sBSDmin distances between trees.
}
\description{
run.mds obtains a multidimensional scaling (MDS) of the pariwise sBSDmin distances between trees.
}
\usage{
run.mds(matrix.name, out.mds.name = "test_mds.txt")
}
\arguments{
  \item{matrix.name}{
The path and name of the file with the pairwise sBSDmin distances between trees. 
}
  \item{out.mds.name}{
The name of the output files. Please see the tutorial for instructions.
}
}
\details{
None. Please see the tutorial for instructions.
}
\value{
This function does not return an object to the prompt. Instead, it returns two text files: The points of the MDS of the sBSDmin distances, and the eigen values.
}
\author{
Sebastian Duchene
}
