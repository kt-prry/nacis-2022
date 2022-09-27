library(stringr)
library(raster)
library(magick)
library(grDevices)

# This script generates pngs with white backgrounds and then reads
# those files back in to make white pixels transparent. Because the pixels
# are selected based on their hex codes, we have to be sure that our color ramp
# does't include #ffffff (otherwise those will get pulled out and made
# transparent as well!)

##### Input/output #####
# Designate directories for input and output data
dir <- "data/source/tifs"
files <- list.files(path = dir)
white_bg_dir <- "data/processed/white_bg"
final_dir <- "data/processed/transparent"

##### Loooooop #####
for (i in seq_along(files)) {
  ##### Filename stuff #####
  # Grab and generate filenames
    # > "sept_1980"
    filename_wo_ext <- str_sub(files[i], start = 0L, end = 9L)

    # > "data/source/sept_1980.tif"
    file_path <- str_c(dir, "/", files[i])

    # > "data/processed/white_bg/sept_1980.png"
    processed_filename <- str_interp("${white_bg_dir}/${filename_wo_ext}.png")

    # > "data/processed/transparent/sept_1980.png"
    final_filename <- str_interp("${final_dir}/${filename_wo_ext}.png")

  ##### Read in raster #####
  # Preview raster image with color scale
  raster <- raster(file_path)
  raster_image <- palr::image_raster(raster, col = rev(custom_color_palette(15))) ## Pick the number of buckets you want, in this case 15
  plotRGB(raster_image)

  # Generate the png with color scale
  dev.new()
  png(str_interp("${processed_filename}"),
    width = ncol(raster_image), # Same width as original raster
    height = nrow(raster_image)) # Same height as original raster
  plotRGB(raster_image)
  dev.off()

  # Read png image back in
  image <- image_read(str_interp("${processed_filename}"))

  # Make all white pixels transparent
  image_transparency <- image_transparent(image, "#ffffff")

  # Write new image
  image_write(image_transparency,
    path = str_interp("${final_filename}"),
    format = "png")


  print(str_interp("${final_filename} created!"))
}
