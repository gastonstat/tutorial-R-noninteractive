# Regression analysis of two random vectors

# reading arguments
args <- commandArgs(TRUE)
n <- args[1]

# random data
x <- rnorm(n)
y <- x + rnorm(n)

# regression line
reg <- lm(y ~ x)

# scatter diagram with fitted regression line
png('scatterplot.png')
plot(x, y, las = 1, pch = 19, col = "#555555")
abline(reg, col = "#0000DD59", lwd = 2)
dev.off()

# residuals plot
png('residuals_plot.png')
plot(x, reg$residuals, las = 1, pch = 19, col = "#606060")
abline(h = 0)
dev.off()
