library(magick)
library(stringr)

# This scripts takes in the new pngs with transparent background and resizes
# them to be the same size as the basemap and georeferenced. Importantly, the
# basemap is centered on the extent of the original tiff files and the height
# matches the original tiff.

##### Input/output #####
# Read in basemap
basemap <- image_read("data/source/basemap/arctic_basemap.png")

# Read in pngs with transparent background
dir <- "data/processed/transparent"
transparent_pngs <- list.files(path = dir)

# Output directory
out_dir <- "data/processed/resized"

##### Basemap details #####
# Grab basemap dimensions
base_info <- image_info(basemap) %>%
  print()
base_width <- base_info$width
base_height <- base_info$height

##### Loooooop #####
# Loop through each sea ice data layer and create image
for (i in seq_along(transparent_pngs)) {
  image <- image_read(str_interp("${dir}/${transparent_pngs[i]}"))
  scaled_image <- image_scale(image, str_interp("${base_width}x${base_height}"))

  # Create composite of all layers
  final <- image_extent(scaled_image, str_interp("${base_width}x${base_height}"))

  image_write(final, path = str_interp("${out_dir}/${transparent_pngs[i]}"), format = "png")
  print("Image reszied!")
}

print(image_info(scaled_image))
print(image_info(final))
