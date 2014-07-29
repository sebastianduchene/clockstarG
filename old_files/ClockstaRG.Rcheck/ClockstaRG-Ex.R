pkgname <- "ClockstaRG"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('ClockstaRG')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
cleanEx()
nameEx("optim.trees.g")
### * optim.trees.g

flush(stderr()); flush(stdout())

### Name: optim.trees.g
### Title: optim.trees.g is can be used to optimise the branch lengths for
###   a tree topology over many alignments. Please see the tutorial for
###   instructions to use.
### Aliases: optim.trees.g

### ** Examples

## Not run: 
##D optim.trees.g('data_folder')
## End(Not run)



### * <FOOTER>
###
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
