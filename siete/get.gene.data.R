library(rentrez)
gene.data <- read.table("gene.names.csv", sep = ",", head = T, as.is = T)

gene.data[, 2] <- gsub(" ", "", gene.data[, 2])



# loop can start here

cat("name,id,type,taxname,locus,description,location,family", file = "gene_data_test.txt", sep = "\n")

for(i in 1:3){

      print(paste("I am searching for the genes in NCBI for gene", gene.data[i, 1], "with name", gene.data[i, 2]))
      gene_temp_search <- entrez_search(db = "Gene", term = paste0(gene.data[i, 2], "[Gene]"), usehistory = "y")

      cookie <- gene_temp_search$WebEnv

      qk <- gene_temp_search$QueryKey

      gene_temp_data <- entrez_fetch(db = "Gene", WebEnv = cookie,  query_key = qk, rettype = "xml", ret.max = 1)
      gene_temp_data <- strsplit(gene_temp_data, "\n")[[1]]

      data.tags <- c("geneid", "gene_type", "taxname", "ref_locus", "ref_desc", "chromosome.*HuRef", "[Ff]amily")

      gene_temp_data_tags <- sapply(data.tags, function(x) grep(x, gene_temp_data, value = T)[1])

      # regexp to remove html tags
      gene_temp_data_tags <- gsub("(<([A-Z]|[a-z]|_|[-])+>)|(</([A-Z]|[a-z]|_|[-])+>)|^ +", "", gene_temp_data_tags)

      print(paste("The metadata for", gene.data[i, 2]))
      print(gene_temp_data_tags)
      cat(paste(c(paste0("gene", gene.data[i, 1]), gene_temp_data_tags), collapse = ","), file = "gene_data_test.txt", sep = "\n", append = T)      
}


