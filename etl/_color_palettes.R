library(grDevices)
library(RColorBrewer)

# Helpers -------------
getHex <- function(color) {
  hex <- rgb(color[1], color[2], color[3], maxColorValue = 255)
  return(hex)
}

create_pal <- function(gen, breaks) {
  colors <- c()
  for (i in seq_along(breaks)) {
    color <- gen(breaks[i])
    hex <- getHex(color)
    colors <- append(colors, hex)
  }
  pal <- colorRampPalette(colors)
}

