get.gap <- function(true.data, boot.data){

   boot.means <- sapply(true.data[,1], function(x) mean(boot.data[boot.data[,1] == x, 2]))



   gap.dat <- boot.means - true.data[, 2]
   gap.se <- vector()
   for(i in true.data[, 1]){
      boot.temp <- boot.data[boot.data[, 1] == i, 2]
      gap.temp <- boot.temp - true.data[true.data[, 1] == i, 2]
      

      #gap.se <- c(gap.se, diff(quantile(gap.temp, c(0.05, 0.95))))

# Get number of bootstrap replicates from the data and replace in gap.se

      gap.se <- c(gap.se, sqrt((1 - 1/500)*var(gap.temp)))
   }
   gap.se <- gap.se / true.data[, 1]
   res.mat <- cbind(gap.dat, gap.se)
   colnames(res.mat) <- c("Gap", "SE")
   rownames(res.mat) <- true.data[, 1]
   return(res.mat)
}
