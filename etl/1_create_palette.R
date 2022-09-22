library(grDevices)
source("etl/_color_palettes.R") # My helper functions for creating palettes

##### Standard linear color palette #####
# This script creates a color palette that's compatible with palr::image_raster
colors_list <- c("#f8fdfe", "#6ecef0", "#163c77") # Be sure there's not #ffffff in your palette!
custom_color_palette <- colorRampPalette(colors = colors_list)


##### For a non-linear color palette #####
# If you want a suuuper custom color palette (with uneven breaks in the colors, for example),
# you can use my helper functions and define the breaks manually.

colors_generator <- colorRamp(colors_list, interpolate = "linear")
colors <- create_pal(colors_generator, breaks = c(0, 0.5, 1))


