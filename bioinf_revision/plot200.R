
gstat_1 <- read.table('gap_stats.txt')

means_gap <- sapply(1:ncol(gstat_1), function(x) mean(gstat_1[, x]))

plot(1:200, means_gap[1:200], type = 'l', lwd = 2, col = 'red', ylim = c(min(gstat_1),max(gstat_1)) )

for(i in 1:nrow(gstat_1)){
      points(x = 1:200, y = as.numeric(gstat_1[i, 1:200]), col = rgb(0, 0, 0.5, 0.5))
}

lines(1:200, means_gap[1:200], type = 'l', lwd = 2, col = 'red' )
