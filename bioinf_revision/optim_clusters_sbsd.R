# COMPLETED. Add instructions

optim_clusters_sbsd <- function(sbsd_mat_file, out_mds_file = 'mds_sbsd.txt', n_clusters = 2, kmax , b_reps = 100, out_cluster_id = 'opt_clus_id_sbsd.txt', out_cluster_info = 'opt_clusinfo_sbsd.txt', plot_clustering = F){

  require(cluster)
  require(ape)
  require(doParallel)

  dat_raw <- as.matrix(read.table(sbsd_mat_file, head = T, as.is = T))
  dat_raw[upper.tri(dat_raw, diag = T)] <- 0
  dat_raw[1:ncol(dat_raw), 1:nrow(dat_raw)] <- as.numeric(dat_raw)

  dat_dist <- as.dist(dat_raw)
  mds_dat <- cmdscale(dat_dist, k = 3)
  write.table(mds_dat, file = out_mds_file, row.names = T)

  ### functions

  clus_fun <- function(x, kmax) sapply(2:(kmax), function(i) clara(x, k = i)$silinfo$avg.width )
  clus_fun_par <- function(x, kmax) foreach(i = 2:(kmax), .combine = cbind) %dopar% cluster::clara(x, k = i)$silinfo$avg.width

  get_boot_rep <- function(x){
    boot_mat <- cbind(runif(nrow(x), min(x[, 1]), max(x[, 1])), runif(nrow(x), min(x[, 2]), max(x[, 2])), runif(nrow(x), min(x[, 3]), max(x[, 3])))
  }

  if(missing(kmax)){
    kmax = round(nrow(mds_dat) / 2, 0)
  }

  cl <- makeCluster(n_clusters)
  registerDoParallel(cl)
  true_dat_clus <- clus_fun_par(mds_dat, kmax)
  stopCluster(cl)

  boot_dat_clus <- list()

  cl <- makeCluster(n_clusters)
  registerDoParallel(cl)
  for(i in 1:b_reps){
      boot_dat_temp <- get_boot_rep(mds_dat)
      boot_dat_clus[[i]] <- clus_fun_par(boot_dat_temp, kmax)
      cat('bootstrap replicate' , i, 'the average silhouete width is', mean(boot_dat_clus[[i]]), '\n')

  }
  stopCluster(cl)


  gap_stats <- list()
  for(i in 1:length(boot_dat_clus)){
    gap_stats[[i]] <- as.numeric(true_dat_clus) - as.numeric(boot_dat_clus[[i]])
  }


  rec_rbind <- function(list_data){
    if(length(list_data) == 1) stop('The list has length = 1. Nothing to concatenate')
    if(length(list_data) == 2){
      return(rbind(list_data[[1]], list_data[[2]]))
    }else{
      return(rbind(list_data[[1]], rec_rbind(list_data[-1])))
    }
  }

  gap_stats <- rec_rbind(gap_stats)
  mean_gaps <- sapply(1:ncol(gap_stats), function(x) mean(gap_stats[, x]))
  ci_gaps <- sapply(1:ncol(gap_stats), function(x) sd(gap_stats[, x]) / sqrt(nrow(gap_stats)))
  high_gaps <- sapply(1:ncol(gap_stats), function(x) quantile(gap_stats[, x], c(0.975)))
  max_gap <- which.max(mean_gaps)

# Uncomment the followins lines to use the bootstrap reps
  if(max_gap > 1){
#    if(mean_gaps[max_gap] > high_gaps[max_gap - 1] & mean_gaps[max_gap] > high_gaps[max_gap + 1]){
      opt_k <- max_gap + 1
      cluster_pam <- pam(mds_dat, k = opt_k)
      clus_info  <- cluster_pam$clusinfo
      clus_id <- cluster_pam$clustering
#    }else{
#      opt_k <- 1
#      clus_info <- rep(NA, 5)
#      clus_id <- rep(1, nrow(mds_dat))
#      names(clus_id) <- rownames(mds_dat)
#     }
  }else{
    opt_k <- 1
    clus_info <- rep(NA, 5)
    clus_id <- rep(1, nrow(mds_dat))
    names(clus_id) <- rownames(mds_dat)
  }

  if(plot_clustering){
    par(mfrow = c(2, 1))
    plot(2:(ncol(gap_stats) + 1), gap_stats[1, ], pch = 20, col = rgb(0, 0, 1, 0.3), ylim = c(min(gap_stats), max(gap_stats)), ylab = 'Gap', xlab = 'k')
    for(i in 2:nrow(gap_stats)){
      points(jitter(2:(ncol(gap_stats) + 1)), gap_stats[i, ], pch = 20, col = rgb(0, 0, 1, 0.5))
    }
    lines(2:(ncol(gap_stats) + 1), mean_gaps, col = 'red', lwd = 2)
    plot(mds_dat, pch = 20, col = clus_id, ylab = 'MDS coordinate 2', xlab = 'MDS coordinate 1', main = paste('MDS plot for k =', opt_k))
  }

  write.table(clus_id, file = out_cluster_id)
  write.table(clus_info, file = out_cluster_info)

  return(list(optimal_k = opt_k, cluster_info = clus_info, cluster_id =  clus_id, gap_statistics = gap_stats, mds = mds_dat))
}

#test_1 <- optim_clusters_sbsd('sbsd_c1.txt', n_clusters = 2, kmax = 10, b_reps = 50, plot_clustering = T)




