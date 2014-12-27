\name{optim_clusters_coord}
\alias{optim_clusters_coord}
\title{
Select optimal number of clusters using the Gap statistic
}
\description{
optim_clusters_coord obtains the optimal number of clusters, the cluster assignment, and other cluster statistics for the optimal number of clusters, obtained with the Gap statistic. 
}
\usage{
optim_clusters_coord(coord_mat, n_clusters = 2, kmax, b_reps = 100, out_cluster_id = "opt_clus_id.txt", out_cluster_info = "opt_clusinfo_sbsd.txt", out_gap_stats = "gap_stats.txt", plot_clustering = F)
}
\arguments{
  \item{coord_mat}{
This is the matrix of the scaled branch lengths of the gene trees. It can be obtained with get_scaled_brs.
}
  \item{n_clusters}{
Number of computing clusters. This is the number of CPUs to use. Do not confuse with the number of clocks or pacemakers.
}
  \item{kmax}{
Maximum number of clusters to test. This is k for 1<k<N
}
  \item{b_reps}{
Bootstrap replicates
}
  \item{out_cluster_id}{
Name of the file to save the cluster assignment for each gene. 
}
  \item{out_cluster_info}{
Name of the file to save the cluster information for each gene. This includes issolation, mean dissimilarity, and cluster size.
}
  \item{out_gap_stats}{
Name of file to save the Gap statistic for values of k.
}
  \item{plot_clustering}{
boolean. Should ClockstaR-G plot the Gap statistics.
}
}

\value{
  \item{optimal_k }{The optimal value for k.}
  \item{cluster_info }{matrix with information for each of the clusters (referred to as pacemakers in the publication)}
  \item{cluster_id }{matrix with the clustering assignment for each gene}
  \item{gap_statistics }{matrix with the Gap statistics}
  \item{alt_gap }{difference between sucessive mean Gap statistics}

}
\references{
Pending.
}
\author{
Sebastian Duchene
}

