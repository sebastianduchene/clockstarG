\name{get.gap}
\alias{get.gap}
\title{
Get gap statistic.
}
\description{
get.gap obtains the gap statistic for a range of Wk and bootstrap replicates.
}
\usage{
get.gap(true.data, boot.data)
}
\arguments{
  \item{true.data}{
The data with Wk for a range of k. Note that this is not the file name, but the data loaded as a matrix or data fram in R.
}
  \item{boot.data}{
The data with Wk for bootstrap replicates for a range of k. Note that this is not the file name, but the data loaded as a matrix or data fram in R.
}
}
\details{
Please see the tutorial for instructions. 
}
\value{

A matrix with the Gap statistic and the standard errors (SE). The first column is the Gap, and the second is the SE.

}
\references{
     Tibshirani, R., Walther, G. and Hastie, T. (2001).  Estimating the
     number of data clusters via the Gap statistic.  _Journal of the
     Royal Statistical Society B_, *63*, 411-423.

     Tibshirani, R., Walther, G. and Hastie, T. (2000).  Estimating the
     number of clusters in a dataset via the Gap statistic.  Technical
     Report. Stanford.

     Per Broberg (2006). SAGx: Statistical Analysis of the GeneChip.  R
     package version 1.9.7.  <URL:
     http://home.swipnet.se/pibroberg/expression_hemsida1.html>
}
\author{
Sebastian Duchene
}
\note{
Please see the tutorial and the documentation for 'clusGap' function of the 'cluster' package for more details. 
}

