# Regression analysis of two random vectors

# random data
x <- rnorm(20)
y <- x + rnorm(20)

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
