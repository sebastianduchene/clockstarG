library(ape)


gene.names <- system("awk 'NR!=1{print $1}' FS=\",\" gene_data_test.txt", intern = T)
gene.names <- paste0(gene.names, ".fasta")

#Load the gene data and append this column with the cg content


mat.dat <- cbind(gene.names = gene.names, seq.lens = NA, A = NA, C = NA, G = NA, T = NA)

print(mat.dat)

for(i in 1:length(gene.names)){
      print(paste("reading file", gene.names[i]))
      dat.temp <- try(read.dna(gene.names[i], format = "fasta"))
      if(class(dat.temp) == "try-error"){
        next
      }
      freqs.temp <- base.freq(dat.temp)
      mat.dat[i, 3:6] <- freqs.temp
      if(is.matrix(dat.temp)){
	mat.dat[i, 2] <- ncol(dat.temp)
      }
}

write.table(mat.dat, file = "gene_length_bfs.txt", sep = ",", row.names = F)





