make.tree.comps <-
function(trees.file, tree.comps = "treecomps.txt"){
  tree.names <- system(paste("awk '{print $1}' FS=\"(\"", trees.file), intern = T)
  for(i in 2:length(tree.names)){
      print(paste("GETTING NAMES FOR TREE", tree.names[i]))
      cat(paste(tree.names[i], tree.names[1:i-1]), file = tree.comps, append = T, sep = "\n")
      print(paste("PASTED", i, "NAMES"))
  }
}
