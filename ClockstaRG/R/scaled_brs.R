scaled_brs <-
function(tree){
  require(ape)
  lad_tree <- ladderize(tree)
#  br_lens_scaled <- round(lad_tree$edge.length / sum(lad_tree$edge.length), 5)
   br_lens_scaled <- scale(lad_tree$edge.length)
  return(br_lens_scaled)
}
