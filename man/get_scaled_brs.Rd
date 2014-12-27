\name{get_scaled_brs}
\alias{get_scaled_brs}

\title{
get_scaled_brs: Obtain a matrix with scaled branch lengths for a list of trees of class multiphylo.
}
\description{
This function scales the branch lengths of trees and returns a matirx with the names of trees in the columns and the scaled branch lengths in the rows.
}
\usage{
get_scaled_brs(tree_list)
}
\arguments{
  \item{tree_list}{
List of trees of class phylo. This can be of class multiphylo. The trees should have the same number of taxa, and identical topologies.
}
}
\value{
Matrix with trees along the columbs and scaled branch legths along the rows.
}
\author{
Sebastian Duchene
}
