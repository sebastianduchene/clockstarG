#dat <- read.dna("all_concat_2.phy")

for(i in 1:nrow(dat)){
      print(paste("pasting", i))
      print(length(dat[i, ]))
      cat(paste(rownames(dat)[i],  toupper(paste(dat[i, ], collapse = "")), sep = "   "), file = "allconc_5.phy", sep = "\n", append = T)
}