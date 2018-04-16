library(here)
library(ggplot2)

p <- ggplot(iris) +
  aes(Petal.Width, Petal.Length, colour = Species) +
  geom_point()

ggsave(here("fig", "sample.pdf"), p, device = "pdf", width = 5, height = 3)
