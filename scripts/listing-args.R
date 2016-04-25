# Script to test passed arguments
# Returns how many arguments were provided
# prints them on the screen

# reading arguments
args <- commandArgs(trailingOnly = FALSE)

if (length(args) == 0) {
	cat('no arguments provided\n')
} else {
	cat(length(args), 'argument(s) provided:\n\n')
	for (i in 1:length(args)) {
		cat(args[i], '\n')
	}
}
