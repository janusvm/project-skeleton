library(here)

filename <- here("fig", "sample.pdf")
cairo_pdf(filename, width = 10, height = 6.8)
plot(Petal.Length ~ Petal.Width, data = iris, col = Species)
.off <- dev.off()
