\name{boot.clara}
\alias{boot.clara}
\title{
boot.clara performs a parametric bootstrap of the sBSDmin distances among trees. For every bootstrap replicate it calculates the cluster width (Wk) or the silhouette width (Sk), depending on whether run.clara.sk, or run.clara.sil is used. See the tutorial for details and instructions.
}
\description{
boot.clara performs a parametric bootstrap of the sBSDmin distances among trees. For every bootstrap replicate it calculates the cluster width (Wk) or the silhouette width (Sk), depending on whether run.clara.sk, or run.clara.sil is used. See the tutorial for details and instructions.
}
\usage{
boot.clara(clus.matrix.name, out.boot.name = "out_boot.txt", nboot = 10, k.range = NULL, boot.temp.name = "boot.temp.txt", FUNboot = run.clara.wk)
}
\arguments{
  \item{clus.matrix.name}{
The name of the file with the matrix with the MDS points, obtained with run.mds
}
  \item{out.boot.name}{
Name of the output file.
}
  \item{nboot}{
Number of bootstrap replicates to perform for every value of 'k'.
}
  \item{k.range}{
Range of values of 'k'
}
  \item{boot.temp.name}{
Name of temporary files of the bootstrap data. This is deleted after runing CLARA for the range of 'k' specified.
}
  \item{FUNboot}{
The function to use. run.clara.wk for cluster width, or run.clara.sil for silhouette width.
}
}
\details{
Please see the tutorial for instructions.
}
\value{
This function does not return a value to the console. It writes a text file with the statistic, Wk or Sk, for the bootstrap replicates
}
\references{
Kaufman, L., & Rousseeuw, P. J. (2009). Finding groups in data: an introduction to cluster analysis (Vol. 344). John Wiley & Sons.
}
\author{
Sebastian Duchene
}
