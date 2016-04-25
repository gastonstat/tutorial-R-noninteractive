# Histogram of Random Normal Numbers
#
# Generates a random vector following a normal distribution
# and produces a histogram in png format
#
# If no arguments are provided, then defaul values are:
# - mean = 0
# - sd = 1


# number of observations
num_obs <- 1000

# reading arguments ('mean' and 'sd')
args <- commandArgs(trailingOnly = TRUE)

if (length(args) == 0) {
	x <- rnorm(num_obs)
} else {
	if (is.missing(args[1])) {
		mean <- 0
	} else {
		mean <- as.numeric(args[1])
	}
	if (is.na(args[2])) {
		sd <- 1
	} else {
		sd <- as.numeric(args[2])		
	}

	x <- rnorm(num_obs, mean = mean, sd = sd)
}


print('Plotting histogram')

png('normal-histogram.png', pointsize = 18)
hist(x, las = 1, col = '#437899')
dev.off()

print('done!')


# random data
#x <- rnorm(n, mean = mean, sd = sd)

