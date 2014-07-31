ClockstaRG
===========

This is the repository for ClockstaRG, an implementation of [ClockstaR](https://github.com/sebastianduchene/clockstar) for large data sets. This program only works in Unix-like machines, and it is more difficult to use than ClockstaR. For data sets with fewer than 20 genes, I suggest using the starndard version of ClockstaR.

Please follow the tutorial below for instructions on how to use:

The program can be installed directly from github. This requres the devtools package, which can be downlaoded from CRAN.

```coffee
install.packages(devtools)
```

Install ClockstaRG:

```coffee
install_github('clockstarg', 'sebastianduchene')
```

If all goes well, you should be able to load ClockstaRG

```
library(ClockstaRG)
```

ClockstaRG is run through a series of steps. Download this repository as a zip file and unzip it. A folder called *test_files* contains some simulated data for this tutorial. It is a fairly small data set, so it should run very quickly.

1. Optimise branch lengths for the gene trees
---------------------------------------------

Create a folder and move the *test_files* folder to the new folder.
 
Open two sessions of R and set the working directory to the folder you just created. Load ClockstaRG and in type the following in each session:

```
optim.trees.g(data.folder = 'test_files', init.alin = 1, end.alin = 10, out.trees = '../out_trees_1.trees', model.test = F)
```

```
optim.trees.g(data.folder = 'test_files', init.alin = 11, end.alin = 20, out.trees = '../out_trees_2.trees', model.test = F)
```

There are 20 genes in the data set. Each session will optimise 10, as specified in the init.alin and end.alin parameters in the optim.trees.g function.

After the sessions finish optimising the branch lengths, two files will appear in the working directory; out_trees_1.trees, and out_trees_2.trees. These files contain the gene trees. Concatenate them through R using a shell command with the function system(). You can also use the shell command directly.

```
system('cat out_trees_*.trees > out_trees_all.trees')
```

2. Make tree comparissons files
-------------------------------

ClockstaRG requires a file with the names of all the trees for which it needs to estimate the *sBSDmin* tree distance ([Duchene et al. 2014](#references)). Make the file with the following command:

```
make.tree.comps(trees.file = 'out_trees_all.trees', tree.comps = 'tree_comparisons.txt')
```

This will make a file called *tree_comparissons.txt*. Each line corresponds to the tree names for each *sBSDmin* distance to estimate.


3. Estimate *sBSDmin* for a range of trees
------------------------------------------

The function *get.sbsd* uses the file with the gene trees (*out_trees_all.trees*) and the tree comparissons file (*tree_comparissons.txt*) to estimate the *sBSDmin* for pairs of trees.

Open two R sessions (if you had not done this prevously), and use type the following lines in each session:

```
get.sbsd(trees.file = 'out_trees_all.trees', comps.file = 'tree_comparisons.txt', method = 'memory', range.comps = 1:95, out.file = 'sbsd_1.txt')
```

```
get.sbsd(trees.file = 'out_trees_all.trees', comps.file = 'tree_comparisons.txt', method = 'memory', range.comps = 96:190, out.file = 'sbsd_2.txt')
```

The numbers in range.comps are the range of distances to estimate. These correspond to the lines in the *tree_comparissons.txt* file.Note that in each session we are running a set of values. Type ?get.sbsd at the prompt for more information on other function arguments. The argument *method* is particularly important. It can be used to read trees one at a time (lite), or to load them in memory (memory). Selecting *memory* is faster, but if there is not enough RAM available for the data set, *lite* is a more efficient option.

In this step we produced two files with the *sBSDmin* distances. These should be combined, with a shell command. Use *system* from R to combine the files:

```
system('cat sbsd_*.txt > sbsd_all.txt')
```

4. Fold the *sBSDmin* distances into a pariwise matrix
------------------------------------------------------

If you open the *sbsd_all.txt* file in a text editor, you will notice that the values are printed line by line. For the subsequent steps it is necessary to format these distances into a pairwise matrix. This can be done using two functions: *fold.sbsd* and *fill.matrix*. 
*fold.sbsd* folds the scaling factors,*s*, and the *sBSDmin* distances:

```
fold.sbsd(trees.file = 'out_trees_all.trees', comps.file = 'sbsd_all.txt', out.name = 'folded_sbsd.txt', method = 'lite')
```

*fold.sbsd* produced two files: *sbsdfolded_sbsd.txt* and *sfolded_sbsd.txt*. These are pairwise matrices, but the above diagonal alements are NA. Some clusering applications require the above diagonal elements as numbers. This can be done with the *fill.matrix* function:

```
fill.matrix(matrix.name = 'sbsdfolded_sbsd.txt')
fill.matrix(matrix.name = 'sfolded_sbsd.txt')
```


#run.mds(matrix.name = 'sbsdfolded_sbsd.txt', out.mds.name = 'sbsd_mds.txt')

#run.clara.sil(clus.matrix.name = 'points_sbsd_mds.txt', out.clus.name = 'out_clus_sil.txt')
#boot.clara(clus.matrix.name = 'points_sbsd_mds.txt', nboot = 100, FUNboot = run.clara.sil, out.boot.name = 'out_boot_sil.txt')

#run.clara.wk(clus.matrix.name = 'points_sbsd_mds.txt', out.clus.name = 'out_clus_wk.txt')
#boot.clara(clus.matrix.name = 'points_sbsd_mds.txt', nboot = 100, FUNboot = run.clara.wk, out.boot.name = 'out_boot_wk.txt')


boot_sil <- read.table('out_boot_sil.txt', head = F, as.is = T)
plot(boot_sil[, 1], boot_sil[, 2], pch = 20, ylab = 'Sk', xlab = 'k')

cluster_sil <- read.table('out_clus_sil.txt', head = F, as.is = T)
lines(cluster_sil[, 1], cluster_sil[, 2], col = 'red', lwd = 2)

boot_wk <- read.table('out_boot_wk.txt', head = F, as.is = T)
plot(boot_wk[, 1], boot_wk[, 2], pch = 20, ylab = 'Sk', xlab = 'k')


cluster_wk <- read.table('out_clus_wk.txt', head = F, as.is = T)

gap <- get.gap(true.data = cluster_wk, boot.data = boot_wk)

plot(gap[, 1], type = 'l', col = 'red', lwd = 2)
lines(gap[, 1] + gap[, 2], col = 'blue', lty = 2)
lines(gap[, 1] - gap[, 2], col = 'blue', lty = 2)




References
----------

Duchene, S., Molak, M., & Ho, S. Y. (2014b). ClockstaR: choosing the number of relaxed-clock models in molecular phylogenetic analysis. *Bioinformatics* 30 (7): 1017-1019.