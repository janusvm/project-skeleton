# The `here` package is highly useful for this
# script based workflow
if (!require(here)) {
  install.packages("here")
  library(here)
}

# Load data
data(iris, package = "datasets")

# Plot to file
filename <- here("fig", "sample.pdf")
cairo_pdf(filename, width = 10, height = 6.8)
plot(Petal.Length ~ Petal.Width, data = iris, col = Species)
.off <- dev.off()
