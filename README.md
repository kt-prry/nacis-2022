# nacis-2022

Happy NACIS! This repo contains scripts and sample data to generate pngs with transparent backgrounds out of geotiffs programmatically. I used this process to create map layers for the opening map in a [story about disappearing sea ice and the impact on polar bears](https://projects.apnews.com/features/2021/polar-bears-sea-ice/index.html).

* `1_create_palette.R`: Quick script where you supply hex codes for your color palette. You'll define the `custom_color_palette` in this script, which we'll use in the next step.
* `2_generate_pngs.R`: This script applies the custom color palette, generates pngs with a white background, and then reads the images back in to remove the white background.
* `3_resize_pngs.R`: This script scales the pngs to the size of the basemap. 
* `4_crop_all_images.R`: This script crops the basemap and resized pngs so that they're all the same size.
* `_color_palettes.R`: Helper functions used in the `1_create_palette` script to create custom color palettes with non-linear interpolation.

*Created by Kati Perry (<kati.perry@washpost.com>)*

*Reporter: Kati Perry (<kati.perry@washpost.com>)*

## Project notes

### Data sources

Sample sea ice concentration data comes from the [NSIDC](https://nsidc.org/home). 

### Technical

An outline of the basic project structure is available at https://github.com/associatedpress/cookiecutter-r-project

### Project setup instructions

After cloning the git repo:

Open `nacis-2022.Rproj` in RStudio.

