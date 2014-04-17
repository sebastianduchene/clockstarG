This is the home of ClockstaR+G
===============================

Instructions to run:
-------------------

- optimise the branch lengths on a fixed tree topology

- make tree comps matrix to get the tree comparissons one by one

- get sbsd using the tree names and the tree comparissons

- fold the sbsd data into a matrix

- fill the sbsd data matrix

- run mds to compress the matrix for clustering 

- run.clara to estimate the width of the clusters wk or the silhouette width sil

- bootstrap clara data. With silhouettes it is not possible to test the case of a single cluster

- get gap statistics if clara was run with wk 

- post processing it is possible to get the gene information from genbank, and also the empirical gene lengths and base frequencies

Instructions for dev:
--------------------

- ~~(1) Optimise branch lengths for many trees. (This can be parallelised for different sets of trees) -> trees file in NEWICK~~

- ~~(2) Make matrix with comparissons and store tree name comparissons as lines in a text file. -> text files with names of pairs of trees~~

- ~~(3) Fetch trees estimated in (1) with names from (2) and estimate *sBSDmin* and *s*. Store in lines with the names of each pair of trees (This can be parallelised for different pairs of trees). -> text file with names of trees and *sBSDmin* and *s*.~~

- ~~(4) Make 2 matrices to store *sBSDmin* and *s*.~~

    - ~~(4.1) Fold *sBSDmin* and *s* from (3) and save in the matrices in (4).-> text file with the matrix with NA for diagonal and above diagonal~~
    - ~~(4.2)  Complete diagonal and upper diagonal of the matrices. -> text file with the matrix ( it should include colnames (which are thesame as the rownames))~~

- ~~(5) Run IRLBA on the matrix from (4.2) with two or three dimensions.~~

    - ~~(5.1) Store IRLBA matrix and the *d* values. -> text file with the IRLBA dimesion reduced data, text file with the *d* values, and text file with singlurar vectors.~~

- ~~(6) Run CLARA for a range of k. (This can be parallelised of different ranges of k)~~

- (7) Get gene names.

- (8) Simulate data under the UPM. The input is the concatenated tree. Then some random noise is added and alignmnets are simulated. Then the branch lengths are estimated for each alignment, and the analysis is performed.



Pending to include in instructions
------------------------------------

- (6.1) Note that one can choose run.clara.wk to get the gap statistic, or run.clara.sil to get the silhouettes. With gap it is necessary to run a botstrap to obtain k, with silhouettes one can maximise the silhouette's width. Gap has the advantage that it can assess the fit of k = 1, where as silhouettes cannot be computed for k < 2.

- (6.2) Save k and logW. -> text file with k and the log10W

- (7) Run bootstrap for clara, selecting a function from (6.1)
    
    - (7.1) For silhouettes the bootstrap can confirm the fit of k. It should be higher for the real data than for the bootstrap replicates.
    - (7.2) For cluster widths follow (8)

- (8) For gap, Load the clustering info (silhouette or cluster width) in R and run get.gap. The output of this function can be run througth maxSE from package cluster to get the optimal k.

- (9) run get.gap with the logW values and the bootstrap replicates to get the gap statistic and the bootstrap CI.

Pending dev
-----------


	- get.gene names with rentrez package
