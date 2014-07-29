
This is the home of ClockstaR+G
===============================

Welcome to the home of ClockstaR + G. This is an extension of [ClockstaR](https://github.com/sebastianduchene/ClockstaR) for large genome data sets. It uses many UNIX commands and splits some of the tasks of the ClockstaR algorithm so that many steps can be run in different cores or machines. For this reason, ClockstaR+G only works in UNIX-like machines. Running the program requires some setting up, so it is not efficient for small data sets. I suggest using the original version of ClockstaR if your data set has 40 partitinos or fewer. Please see the tutorial to get stared. For details on the algorithm, please refer to the references in the [ClockstaR](https://github.com/sebastianduchene/ClockstaR) website.








Pending for DEV
--------------

1. ~~DESCRIPTOIN FILE~~

2. MAN FILES
   - ~~ClockstaRG-package.Rd~~
   - ~~boot.clara~~
   - ~~fill.matrix.Rd~~
   - ~~fold.sbsd.Rd~~
   - ~~get.gap.Rd (update in step1_testing.R)~~
   - ~~get.sbsd.Rd~~
   - ~~make.tree.comps.Rd~~
   - ~~optim.trees.g.Rd~~
   - ~~run.clara.sil.Rd~~
   - ~~run.clara.wk.Rd~~
   - ~~run.mds.Rd~~




Instructions to run:
-----------------------------------------------------


Instructions to run:

(1) Create folder with fasta files and the tree

(2) Optimise trees with **optim.trees.g**

(3) Make tree comps file with **make.tree.comps**

(4) Estimate sbsd with **get.sbsd**

(5) Fold matrix with **fold.sbsd**

(6) Fill matrix with **fill.matrix**

(7) Compress dimensions with **run.irlba**

(8) Run Clara on the *u* vectors with **run.clara**

(9) Run bootstrap replicates with **boot.clara**



Pending to include in documentation
------------------------------------

- Include a tutorial with the simulated data in ClockstaR2

- (6.1) Note that one can choose run.clara.wk to get the gap statistic, or run.clara.sil to get the silhouettes. With gap it is necessary to run a botstrap to obtain k, with silhouettes one can maximise the silhouette's width. Gap has the advantage that it can assess the fit of k = 1, where as silhouettes cannot be computed for k < 2.

- (6.2) Save k and logW. -> text file with k and the log10W

- (7) Run bootstrap for clara, selecting a function from (6.1)
    
    - (7.1) For silhouettes the bootstrap can confirm the fit of k. It should be higher for the real data than for the bootstrap replicates.
    - (7.2) For cluster widths follow (8)

- (8) For gap, Load the clustering info (silhouette or cluster width) in R and run get.gap. The output of this function can be run througth maxSE from package cluster to get the optimal k.

- (9) run get.gap with the logW values and the bootstrap replicates to get the gap statistic and the bootstrap CI.


