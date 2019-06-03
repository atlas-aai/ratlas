library(tidyverse)
library(here)
library(hexSticker)
library(png)
library(grid)
library(magick)


# Functions --------------------------------------------------------------------
palette_flag <- function(n, palette) {
  data <- tibble(x = rep(1:n, n),
                 y = sample(1:n, n * n, replace = TRUE))

  p <- ggplot(data) +
    geom_bar(aes(x, group = y, fill = y), width = 1) +
    scale_fill_gradientn(colors = palette) +
    theme_void() +
    theme(legend.position = "none")

  return(p)
}


# Create background ------------------------------------------------------------
atlas_pal <- c("#9BD3DD", "#F2A900", "#8FD6BD", "#F0EC74")
flag <- palette_flag(100, atlas_pal)
ggsave("full-flag.png", plot = flag, path = here("hex-logo"), width = 8,
       height = 6, units = "in", dpi = "retina")


# Create initial logo ----------------------------------------------------------
theme_hex <- theme_void() + theme_transparent() +
  theme(axis.ticks.length = unit(0, "mm"))

l <- 1
hex <- tibble(
  x = 1.35 * l * c(-sqrt(3) / 2, 0, rep(sqrt(3) / 2, 2), 0,
                   rep(-sqrt(3) / 2, 2)),
  y = 1.35 * l * c(0.5, 1, 0.5, -0.5, -1, -0.5, 0.5)
)
rim <- tibble(x = c(-2,  2, 2, -2, -2),
              y = c(-2, -2, 2,  2, -2))
full_hex <- bind_rows(rim, hex)

img <- readPNG(here("hex-logo", "ATLAS_icon.png"))
atlas_logo <- rasterGrob(img, interpolate = TRUE)

bg <- readPNG(here("hex-logo", "full-flag.png"))
bg_flag <- rasterGrob(bg, interpolate = TRUE)

logo <- ggplot() +
  annotation_custom(bg_flag, xmin = -2.0, xmax = 2.0, ymin = -1.5, ymax = 1.5) +
  geom_polygon(data = full_hex, aes(x, y), fill = "pink") +
  geom_polygon(data = hex, aes(x, y), color = "#165C7D", size = 12, alpha = 0) +
  annotate(geom = "text", label = "ratlas", x = 0, y = -0.7,
           family = "Montserrat", color = "#165C7D", fontface = "bold",
           size = 60) +
  annotation_custom(atlas_logo, xmin = -0.6, xmax = 0.6, ymin = -0.5,
                    ymax = 0.9) +
  coord_equal(xlim = range(hex$x), ylim = range(hex$y), expand = TRUE) +
  theme_hex

png(here("man", "figures", "ratlas.png"), width = 181 * 6, height = 210 * 6,
    bg = "transparent")
print(logo)
dev.off()


# Tidy up logo -----------------------------------------------------------------
img <- image_read(here("man", "figures", "ratlas.png")) %>%
  image_transparent("pink", fuzz = 5) %>%
  image_trim()

img %>%
  image_scale("181x210!") %>%
  image_write(here("man", "figures", "ratlas.png"))

img %>%
  image_scale("905x1050!") %>%
  image_write(here("man", "figures", "ratlas-large.png"))
