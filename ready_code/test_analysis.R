source("optim.trees.g.R")

#optim.trees.g(data.folder = "~/Desktop/clockstarg/ready_code/test_data/", out.trees = "test_optim.trees")


source("make.tree.comps.R")

#make.tree.comps(trees.file = "test_optim.trees", tree.comps = "test_treecomps.txt")


source("get.sbsd.R")

#get.sbsd(trees.file = "test_data/test_optim.trees", comps.file  = "test_treecomps.txt", out.file = "test_out.txt")

source("fold.sbsd.R")

#fold.sbsd(trees.file = "test_data/test_optim.trees", comps.file = "test_out.txt", out.name = "_test_fold.txt")

source("fill.matrix.R")

#fill.matrix(matrix.name = "sbsd_test_fold.txt", new.matrix.name = "test_full_sbsd.txt")

#fill.matrix(matrix.name = "s_test_fold.txt", new.matrix.name = "test_full_s.txt")


# The data for irbla are test_full_sbsd.txt and test_full_s.txt