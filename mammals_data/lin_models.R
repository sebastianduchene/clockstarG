clus_info_lines <- readLines("cluster_gene_info.txt")

entry_info <-   sapply(1:length(clus_info_lines), function(x) length(strsplit(clus_info_lines[x], ",")[[1]]))



get_entry_info <- function(entry){
  split_data <- strsplit(entry, ",")[[1]]
  gene_clus_info <- strsplit(split_data[1], "@")[[1]]
  gene_number <- gene_clus_info[2]
  clus_id <- gene_clus_info[1]
  init_data <- split_data[2:6]
  if(length(init_data) > 8){  
    interm_data <- paste(split_data[7:(length(split_data) - 1)], collapse = " ")
  }else{
    interm_data <- split_data[7]
  }
  last_data <- split_data[length(split_data)]
  format_data <- c(clus_id, gene_number, init_data, interm_data, last_data)
  return(format_data)  
}


gene_info <- c("cluster_id", "geneNo", "geneID", "protein_coding", "organism", "gene_name", "function", "chromosome_location", "gene_family")


res_mat <- matrix(NA, length(clus_info_lines), 9)
colnames(res_mat) <- gene_info
for(i in 1:length(clus_info_lines)){
      res_mat[i, ] <- get_entry_info(clus_info_lines[i])
}

res_mat[, 8] <- gsub("[a-z]|[A-Z]| ", "", res_mat[, 8])

### Pending: include CG content