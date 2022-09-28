library(magick)
library(stringr)

# This script takes the pngs that are appropriately reszied for the basemap
# as well as the basemap itself and crops all of it using the same crop dimensions.

##### Input/output ####
# Directory for resized pngs
resized_dir <- "data/processed/resized"
resized_files <- list.files(path = resized_dir)

# Read in basemap
basemap <- image_read("data/source/basemap/arctic_basemap.png")

# Designate output directory
final_dir <- "data/processed/final"

##### Crop geom string ####
# Crop geometry string
crop_dim <- "2100x1300+500+500" # {width}x{height}+{startingAtThisX}+{startingAtThisY}

##### Loooooop #####
# Crop resized ice images
for (i in seq_along(resized_files)) {
  image <- image_read(str_interp("${resized_dir}/${resized_files[i]}"))
  cropped <- image_crop(image, crop_dim)
  image_write(cropped, path = str_interp("${final_dir}/${resized_files[i]}"), format = "png")
  print("Image created")
}

# Crop basemap
basemap_cropped <- image_crop(basemap, crop_dim)
image_write(basemap_cropped, path = str_interp("${final_dir}/basemap.png"), format = "png")
