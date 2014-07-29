setwd("../clockstarG")
code_files <- grep("R$", dir(), value = T)
for(i in code_files){
      source(i)
}
setwd("../data")

data_fill <- "fullmat.txt"

print("running mds")
run.mds(data_fill, out.mds.name = "test_mds.txt")

#run.clara.sil("points_test_mds.txt")

#boot.clara("points_test_mds.txt", nboot = 100, FUNboot = run.clara.sil)


clus.data <- read.table("out_clus_sil.txt")

boot.data <- read.table("out_boot.txt")


plot(jitter(boot.data[, 1]), boot.data[, 2], pch = 20, col = rgb(0, 0, 1, 0.1))

lines(clus.data, lwd = 3)