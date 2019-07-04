library(tidyverse)
library(here)
library(hexSticker)
library(png)
library(grid)
library(magick)


# Create initial logo ----------------------------------------------------------
theme_hex <- theme_void() + theme_transparent() +
  theme(axis.ticks.length = unit(0, "mm"))

l <- 1
hex <- tibble(
  x = 1.35 * l * c(-sqrt(3) / 2, 0, rep(sqrt(3) / 2, 2), 0,
                   rep(-sqrt(3) / 2, 2)),
  y = 1.35 * l * c(0.5, 1, 0.5, -0.5, -1, -0.5, 0.5)
)

logo <- ggplot() +
  geom_polygon(data = hex, aes(x, y), color = "#165C7D", size = 12, alpha = 1,
               fill = "white") +
  annotate(geom = "text", label = "ratlas", x = 0, y = -0.7,
           family = "Montserrat", color = "#165C7D", fontface = "bold",
           size = 60) +
  coord_equal(xlim = range(hex$x), ylim = range(hex$y), expand = TRUE) +
  theme_hex

png(here("man", "figures", "ratlas-large.png"), width = 181 * 6,
    height = 210 * 6, bg = "transparent")
print(logo)
dev.off()


# Tidy up logo -----------------------------------------------------------------
image_read(here("man", "figures", "ratlas-large.png")) %>%
  image_trim() %>%
  image_scale("905x1050!") %>%
  image_write(here("man", "figures", "ratlas-large.png"))

# do edits in PowerPoint to add nodes and edges


# Resize and save logo ---------------------------------------------------------
img <- image_read(here("man", "figures", "ratlas-large.png")) %>%
  image_trim()

sq_img <- image_blank(1000, 1000, "hotpink") %>%
  image_composite(image_scale(img, "x1000"), offset = "+68+0") %>%
  image_transparent("hotpink", fuzz = 15)

img %>%
  image_scale("181x210!") %>%
  image_write(here("man", "figures", "ratlas.png"))

img %>%
  image_scale("905x1050!") %>%
  image_write(here("man", "figures", "ratlas-large.png"))

sq_img %>%
  image_scale("32x32!") %>%
  image_write(here("man", "figures", "icon.png"))

sq_img %>%
  image_scale("192x192!") %>%
  image_write(here("man", "figures", "icon-192.png"))
