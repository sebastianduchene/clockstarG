\name{run.clara.sil}
\alias{run.clara.sil}
\title{
run.clara is used to run the CLARA algorithm from package 'cluster'. For values of 'k' from 2:N, it estimates the average silhouette width.
}
\description{
run.clara is used to run the CLARA algorithm from package 'cluster'. For values of 'k' from 2:N, it estimates the average silhouette width.
}
\usage{
run.clara.sil(clus.matrix.name, out.clus.name = "out_clus_sil.txt", k.range = NULL)
}
\arguments{
  \item{clus.matrix.name}{
This is the filename of the MDS of the sBSDmin distances for pairs of trees.
}
  \item{out.clus.name}{
The name of the out put name of the avearage cluster width (Wk) for the values of k in k.range.
}
  \item{k.range}{
The range of 'k' values to calculate Wk.
}
  \item{\dots}{
Other arguments passed to the 'clara' function from pacakge 'cluster'.
 }
}
\details{
Please see the tutorial for instructions.
}
\value{
This function does not return a value to the prompt. It writes a text file with the average silhouette width for values of k. 
}
\references{
Kaufman, L., & Rousseeuw, P. J. (2009). Finding groups in data: an introduction to cluster analysis (Vol. 344). John Wiley & Sons.
}
\author{
Sebastian Duchene
}
