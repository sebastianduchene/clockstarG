gdata <- read.table('gap_stats.txt', head = T)
gdata[, 8] <- gdata[, 8] * 2
gdata[, 9] <- gdata[, 9] * 2
gdata[, 10] <- gdata[, 10] * 2
gdata[, 11] <- gdata[, 11] * 2
gdata[, 12] <- gdata[, 12] * 2
gdata[, 13] <- gdata[, 13] * 2



line_mean <- colMeans(gdata)

plot(2:200, gdata[1, ], pch = 20, col = rgb(0, 0, 0.5, 0.1), ylim = range(gdata))

for(i in 1:nrow(gdata)){
      points(2:200, gdata[i, ], pch = 20, col = rgb(0, 0, 0.5, 0.1))
}

lines(2:200, line_mean, col = 'red', lwd = 2)