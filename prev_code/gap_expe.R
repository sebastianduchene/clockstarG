library(cluster)
library(bigmemory)
library(irlba)


####
fun.clara <- function(mat, k.min, k.max, print.prog = T, export.dat = T, file.name = "logW_res.txt"){
	  init.time <- system("date", intern = T)
	  if(k.max >= nrow(mat)){
	  	   stop("k.max is larger or equal to the number of observations. Choose k.max between 1 and n.obs")
	 }
	 print("estimating distances")
	 dismat <- as.matrix(dist(mat, upper = T, diag = T))   
	 w.tot.k <- vector()
	 for(k in k.min:(k.max)){
	       if(print.prog == T){
	         print(paste("running clara for k =", k))
               }
	    cl <- clara(mat, k = k)

	    w.k <- vector()
	    for(i in 1:k){
      	  	if(i %% 10 == 0 && print.prog == T){
      	   	  print(paste("Estimating logW for cluster", i, "of k =", k))
                }
      	        w.k[i] <- sum(dismat[cl$clustering ==i, cl$i.med[i]]^2)
	    }
#	    print(w.tot.k)
	    w.k.temp <- log10(sum(w.k / (k)  ))
	    w.tot.k <- c(w.tot.k,  w.k.temp)
	    if(export.dat == T){
	      cat(paste(w.k.temp, " "), file = file.name, append = T, sep = " ") 
	    }
	    if(k %% 2 == 0 && print.prog == T){
	    	 print(paste("the current logW  is: ", w.tot.k[k]))
	    }
	    if(k %% 2 == 0 && print.prog == T){
	      print(paste("ANALYSED", k, "of", k.max))	 
	      print("THE TIME IS:")
	      print(system("date"))
	      print("CLARA HAS BEEN RUNNING SINCE:")
	      print(init.time)
	    }
         }
	 
	 return(w.tot.k)
}


###
get.boot.clara <- function(mat, n.boot, export.dat = T, file.name = "boot_res.txt", ...){
  if(class(mat) == "big.matrix"){
   mat <- as.matrix(mat)
  }
  n.obs <- nrow(mat)
  li.mats <- list()
  ranges.dat <- sapply(1:ncol(mat), function(x) range(mat[,x]))
  boot.dat <- list()
  for(n in 1:n.boot){
      print(paste("running bootstrap replicate:", n, "of", n.boot))
      li.mats[[n]] <- matrix(NA, nrow = n.obs, ncol = nrow(ranges.dat))
      rownames(li.mats[[n]]) <- rownames(mat)   
      for(i in 1:nrow(ranges.dat)){
      	    li.mats[[n]][,i] <- runif(n.obs, min = min(ranges.dat[i, ]), max = max(ranges.dat[i, ]))    
      }
      if(export.dat == T){
        fil.name <- paste0("boot_", n, ".txt")
	nrep  <- n
	while(fil.name %in% dir()){
 	  nrep <- nrep + 1
	  fil.name <- paste0("boot_", nrep, ".txt")
	}
        boot.dat[[n]] <- fun.clara(li.mats[[n]], export.dat = T, file.name = fil.name, ...)
        boot.dat[[n]] <- NA 
      }else{
	boot.dat[[n]] <- fun.clara(li.mats[[n]], export.dat = F, ...)
      }
  }
  if(export.dat == F){
    return(boot.dat)
  }
}



## EXAMPLE DATA SET. UNCOMMENT TO TEST THE FUNCTIONS ABOVE
#mat <- rbind(matrix(rnorm(20, 0, 1), 10, 2), matrix(rnorm(20, 5, 1), 10, 2), matrix(rnorm(20, 10, 1), 10, 2))
#rownames(mat) <- 1:nrow(mat)
#clusters.clara <- vector()
#dismat <- as.matrix(dist(mat, upper = T, diag = T))
#n.boot <- 10
#fun.clara(mat, k.min = 1, k.max = 29) -> cl
#get.boot.clara(mat, 100, export.dat = F, k.max = 29, k.min = 1) -> boot
#lapply(1:(nrow(mat) - 1), function(y) sapply(1:10, function(x) return(boot[[x]][y]))) -> lidat
#res <- sapply(1:(nrow(mat) - 1), function(x) mean(lidat[[x]]))
##
#plot(res - cl)