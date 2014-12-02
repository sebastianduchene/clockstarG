

scaled_brs <- function(tree){
  require(ape)
  lad_tree <- ladderize(tree)
#  br_lens_scaled <- round(lad_tree$edge.length / sum(lad_tree$edge.length), 5)
   br_lens_scaled <- scale(lad_tree$edge.length)
  return(br_lens_scaled)
}

get_scaled_brs <- function(tree_list){
  br_lens_matrix <- matrix(NA, nrow = length(tree_list), ncol = length(tree_list[[1]]$edge.length))
  rownames(br_lens_matrix) <- names(tree_list)
  colnames(br_lens_matrix) <- paste0('br', 1:length(tree_list[[1]]$edge.length)) 
  for(i in 1:length(tree_list)){
    br_lens_matrix[i, ] <- scaled_brs(tree_list[[i]])
  }
  return(br_lens_matrix)
}




optim_clusters_coord <- function(coord_mat,  n_clusters = 2, kmax , b_reps = 100, out_cluster_id = 'opt_clus_id.txt', out_cluster_info = 'opt_clusinfo_sbsd.txt', out_gap_stats = 'gap_stats.txt', plot_clustering = F){

  require(cluster)
  require(ape)
  require(doParallel)

  clus_fun <- function(x, kmax) sapply(2:(kmax), function(i) clara(x, k = i)$silinfo$avg.width )
  clus_fun_par <- function(x, kmax) foreach(i = 2:(kmax), .combine = cbind) %dopar% cluster::clara(x, k = i)$silinfo$avg.width

  get_boot_rep <- function(coord_mat){
    init_mat <- matrix(NA, nrow = nrow(coord_mat), ncol = ncol(coord_mat))
    for(i in 1:ncol(coord_mat)){
      init_mat[, i] <- runif(nrow(init_mat), min(coord_mat[, i]), max(coord_mat[, i]))
    }
    return(init_mat)
  }

  if(missing(kmax)){
    kmax = round(nrow(coord_mat) / 2, 0)
  }

  cl <- makeCluster(n_clusters)
  registerDoParallel(cl)
  true_dat_clus <- clus_fun_par(coord_mat, kmax)
  stopCluster(cl)

  boot_dat_clus <- list()

  cl <- makeCluster(n_clusters)
  registerDoParallel(cl)
  for(i in 1:b_reps){
      boot_dat_temp <- get_boot_rep(coord_mat)
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
  high_gaps <- sapply(1:ncol(gap_stats), function(x) quantile(gap_stats[, x], 0.9))#  c(0.975)))
  low_gaps <- sapply(1:ncol(gap_stats), function(x) quantile(gap_stats[, x], 0.05))
  gap_difs <- sapply(2:length(mean_gaps), function(x) mean_gaps[x] - mean_gaps[x-1])
  max_gap <- which.max(mean_gaps)

  max_gap_alt <- which.max(gap_difs)


  if(max_gap > 1){
    if(mean_gaps[max_gap] > high_gaps[max_gap - 1] & mean_gaps[max_gap] > high_gaps[max_gap + 1]){

      opt_k <- max_gap + 1
      cluster_clara <- clara(coord_mat, k = opt_k)
      clus_info  <- cluster_clara$clusinfo
      clus_id <- cluster_clara$clustering
    }else{
      opt_k <- 1
      clus_info <- rep(NA, 5)
      clus_id <- rep(1, nrow(coord_mat))
      names(clus_id) <- rownames(coord_mat)
     }
  }else if(max_gap == 1){
  	  if(mean_gaps[max_gap] > high_gaps[max_gap + 1]){
	    opt_k <- 2
	    cluster_clara <- clara(coord_mat, k = opt_k)
	    clus_info <- cluster_clara$clusinfo
	    clus_id <- cluster_clara$clustering
	    names(clus_id) <- rownames(coord_mat)
	  }else{
	    opt_k <- 1
    	    clus_info <- rep(NA, 5)
    	    clus_id <- rep(1, nrow(coord_mat))
    	    names(clus_id) <- rownames(coord_mat)
  	    }
	 }

  if(plot_clustering){
 
    plot(2:(ncol(gap_stats) + 1), gap_stats[1, ], pch = 20, ylim = c(min(gap_stats), max(gap_stats)), ylab = 'Gap', xlab = 'k', col = 'blue') #col = rgb(0, 0, 1, 0.3))
    for(i in 2:nrow(gap_stats)){
      points(jitter(2:(ncol(gap_stats) + 1)), gap_stats[i, ], pch = 20, col = 'blue')# col = rgb(0, 0, 1, 0.5))
    }
    lines(2:(ncol(gap_stats) + 1), mean_gaps, col = 'red', lwd = 2)
  }

  write.table(clus_id, file = out_cluster_id)
  write.table(clus_info, file = out_cluster_info)
  write.table(gap_stats, file = out_gap_stats)
  write.table(gap_difs, file = 'gap_difs.txt')
  return(list(optimal_k = opt_k, cluster_info = clus_info, cluster_id =  clus_id, gap_statistics = gap_stats, alt_gap = gap_difs))
}

cl_clusGap <- function (x, K.max, B = 100, verbose = interactive(), n_clusters = 2, ...){
    require(doParallel)
    FUNcluster <- clara
    stopifnot(is.function(FUNcluster), length(dim(x)) == 2, K.max >= 2, (n <- nrow(x)) >= 1, (p <- ncol(x)) >= 1)
    if (B != (B. <- as.integer(B)) || (B <- B.) <= 0)  stop("'B' has to be a positive integer")
    if (is.data.frame(x)) x <- as.matrix(x)
    ii <- seq_len(n)
    W.k <- function(X, kk) {
        clus <- if (kk > 1){
	  cluster::clara(X, kk)$cluster
	}else rep.int(1L, nrow(X))
        0.5 * sum(vapply(split(ii, clus), function(I) {
            xs <- X[I, , drop = FALSE]
            sum(dist(xs)/nrow(xs))
        }, 0))
    }
    logW <- E.logW <- SE.sim <- numeric(K.max)
    if (verbose)
        cat("Clustering k = 1,2,..., K.max (= ", K.max, "): .. \n", sep = "")
    for (k in 1:K.max) logW[k] <- log(W.k(x, k))
    xs <- scale(x, center = TRUE, scale = FALSE)
    m.x <- rep(attr(xs, "scaled:center"), each = n)
    V.sx <- svd(xs)$v
    rng.x1 <- apply(xs %*% V.sx, 2, range)

boot_fun <- function(kmax = K.max){
        temp_res_vec <- vector(length = K.max)
        z1 <- apply(rng.x1, 2, function(M, nn) runif(nn, min = M[1], max = M[2]), nn = n)
        z <- tcrossprod(z1, V.sx) + m.x
        for (k in 1:K.max) {
	    temp_res_vec[k] <- log(W.k(z, k))
        }
	return(temp_res_vec)
}

   reg_clust <- makeCluster(n_clusters)
   registerDoParallel(reg_clust)
   logWks <- foreach(i = 1:B, .combine = rbind) %dopar% boot_fun(K.max)
   stopCluster(reg_clust)
   logWks <- logWks 
    E.logW <- colMeans(logWks)
    SE.sim <- sqrt((1 + 1/B) * apply(logWks, 2, var))
    ses_gap <- logWks
    for(i in 1:ncol(ses_gap)){
      ses_gap[, i] <- logWks[, i] - logW[i]
    }
    
    return(list(E.logW - logW, ses_gap))
#    structure(class = "clusGap", list(Tab = cbind(logW, E.logW, gap = E.logW - logW, SE.sim), n = n, B = B, FUNcluster = FUNcluster))
}
