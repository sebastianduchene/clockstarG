library(ape)
library(NELSI)

tr_top <- rcoal(30)
tr_top$edge.length <- tr_top$edge.length *(50 / max(allnode.times(tr_top)))

data_files <- list()

#PM1
t_temp <- simulate.uncor.lnorm(tr_top, params = list(mean.log = -3.9, sd.log = 0.5))$phylogram
for(i in 1:5){
      data_files[[i]] <- t_temp
      data_files[[i]]$edge.length <- abs(data_files[[i]]$edge.length + rnorm(length(data_files[[i]]$edge.length), 0, 0.01))
      plot(data_files[[i]], edge.color = 'black', edge.width = 2)
}

#PM2
t_temp <- simulate.uncor.lnorm(tr_top, params = list(mean.log = -3.9, sd.log = 0.5))$phylogram
for(i in 6:10){
      data_files[[i]] <- t_temp
      data_files[[i]]$edge.length <- abs(data_files[[i]]$edge.length + rnorm(length(data_files[[i]]$edge.length), 0, 0.01))
      plot(data_files[[i]], edge.color = 'red', edge.width = 2)
}

#PM3
t_temp <- simulate.uncor.lnorm(tr_top, params = list(mean.log = -3.9, sd.log = 0.5))$phylogram
for(i in 11:15){
      data_files[[i]] <- t_temp
      data_files[[i]]$edge.length <- abs(data_files[[i]]$edge.length + rnorm(length(data_files[[i]]$edge.length), 0, 0.01))
      plot(data_files[[i]], edge.color = 'orange', edge.width = 2)
}

#PM4
t_temp <- simulate.uncor.lnorm(tr_top, params = list(mean.log = -3.9, sd.log = 0.5))$phylogram
for(i in 16:20){
      data_files[[i]] <- t_temp
      data_files[[i]]$edge.length <- abs(data_files[[i]]$edge.length + rnorm(length(data_files[[i]]$edge.length), 0, 0.01))
      plot(data_files[[i]], edge.color = 'green', edge.width = 2)
}


####################
#

setwd("test_files")
for(i in 1:length(data_files)){
      print(paste('simulating data', i))
      seq_temp <- as.DNAbin(simSeq(data_files[[i]], l = 1000))
      write.dna(seq_temp, file = paste0('gene_', i, '.fasta'), format = 'fasta')
}


write.tree(tr_top, file = 'concat_topology.tree')

setwd("..")

