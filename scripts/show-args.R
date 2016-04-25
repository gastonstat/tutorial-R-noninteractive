# Prints arguments when calling Rscript

# reading arguments
args <- commandArgs(trailingOnly = FALSE)

for (i in 1:length(args)) {
	cat(args[i], '\n')
}
