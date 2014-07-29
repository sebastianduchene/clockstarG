# Load all code
cudir <- getwd() 
setwd('~/Desktop/clockstarg/clockstarG/ClockstaRG/R/')
for(i in dir()) source(i)
setwd(cudir)


# Optimise trees: Open two sessions of R. Load clockstarg and in type the following in each session:

#optim.trees.g(data.folder = 'test_files', init.alin = 1, end.alin = 10, out.trees = '../out_trees_1.trees', model.test = F)

#optim.trees.g(data.folder = 'test_files', init.alin = 11, end.alin = 20, out.trees = '../out_trees_2.trees', model.test = F)

# concatenate tree files
#system('cat out_trees_*.trees > out_trees_all.trees')

# Make file with tree comparissons:

#make.tree.comps(trees.file = 'out_trees_all.trees', tree.comps = 'tree_comparisons.txt')

#get.sbsd(trees.file = 'out_trees_all.trees', comps.file = 'tree_comparisons.txt', method = 'memory', range.comps = 1:95, out.file = 'sbsd_1.txt')

#get.sbsd(trees.file = 'out_trees_all.trees', comps.file = 'tree_comparisons.txt', method = 'memory', range.comps = 96:190, out.file = 'sbsd_2.txt')

# combine sbsd files:

#system('cat sbsd_*.txt > sbsd_all.txt')

#fold.sbsd(trees.file = 'out_trees_all.trees', comps.file = 'sbsd_all.txt', out.name = 'folded_sbsd.txt', method = 'lite')

#fill.matrix(matrix.name = 'sbsdfolded_sbsd.txt')
#fill.matrix(matrix.name = 'sfolded_sbsd.txt')

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
