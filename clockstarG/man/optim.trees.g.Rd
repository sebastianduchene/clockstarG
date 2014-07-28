\name{optim.trees.g}
\alias{optim.trees.g}
\title{
optim.trees.g is can be used to optimise the branch lengths for a tree topology over many alignments. Please see the tutorial for instructions to use.
}
\description{
This function is practical for large data sets. For data sets with less than 20 genes, it may be sufficient to use the standard version of ClockstaR. Please see the tutorial for instructions on how to use.
}
\usage{
optim.trees.g(data.folder, init.alin = NULL, end.alin = NULL, out.trees = "out.trees", model.test = F, out.models = "out.models.txt")
}
\arguments{
  \item{data.folder}{
This is the folder with the individual alignments in fasta files and a tree topology to optimise the branch lengths.
}
  \item{init.alin}{
The number of the first alignment. This is useful for runing several instances of this function. Please see the tutorial for instructions on how to use.
}
  \item{end.alin}{
The number of the first alignment. This is useful for runing several instances of this function. Please see the tutorial for instructions on how to use.
}
  \item{out.trees}{
A character. The name of the file to write the optimised trees.
}
  \item{model.test}{
A logical. Select T for model selection. The default is F. It is recommended to leave the default because it can be very slow to run
}
  \item{out.models}{
The name of the file to write the models to.
}
}
\details{
Please see the tutorial for instructions on how to use
}
\value{
The function does not return anything to the prompt. It saves the trees with optimised branch lenghts to the file specified.
}
\references{
Duchêne, S, Molak, M., and Ho, SYW. "ClockstaR: choosing the number of relaxed-clock models in molecular phylogenetic analysis." Bioinformatics (2014) 30 (7):1017-1019
}
\author{
Sebastian Duchene
}

\seealso{
optim.trees.interactive in ClockstaR
}
\examples{
\dontrun{
optim.trees.g('data_folder')
}
}
