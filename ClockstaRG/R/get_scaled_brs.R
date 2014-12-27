get_scaled_brs <-
function(tree_list){
  br_lens_matrix <- matrix(NA, nrow = length(tree_list), ncol = length(tree_list[[1]]$edge.length))
  rownames(br_lens_matrix) <- names(tree_list)
  colnames(br_lens_matrix) <- paste0('br', 1:length(tree_list[[1]]$edge.length)) 
  for(i in 1:length(tree_list)){
    br_lens_matrix[i, ] <- scaled_brs(tree_list[[i]])
  }
  return(br_lens_matrix)
}
