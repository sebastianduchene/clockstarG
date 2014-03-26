This is the home of ClockstaR+G
===============================

Instructions for dev:

- ~~(1) Optimise branch lengths for many trees. (This can be parallelised for different sets of trees) -> trees file in NEWICK~~

- (2) Make matrix with comparissons and store tree name comparissons as lines in a text file. -> text files with names of pairs of trees

- (3) Fetch trees estimated in (1) with names from (2) and estimate *sBSDmin* and *s*. Store in lines with the names of each pair of trees (This can be parallelised for different pairs of trees). -> text file with names of trees and *sBSDmin* and *s*.

- (4) Make 2 matrices to store *sBSDmin* and *s*.

    - (4.1) Fold *sBSDmin* and *s* from (3) and save in the matrices in (4). Complete diagonal and upper diagonal of the matrices. -> text file with the matrix ( it should include colnames (which are thesame as the rownames))

- (5) Run IRLBA on the matrix from (4.1) with two or three dimensions.

    - (5.1) Store IRLBA matrix and the *d* values. -> text file with the IRLBA dimesion reduced data, text file with the *d* values, and text file with singlurar vectors.

- (6) Run CLARA for a range of k. (This can be parallelised of different ranges of k)

    - (6.1) Save k and logW. -> text file with k and the logW
