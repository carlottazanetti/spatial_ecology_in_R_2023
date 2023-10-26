# This is a script to visualize satellite data

library(devtools) # packages in R are also called libraries

# install the imageRy package from GitHub
devtools::install_github("ducciorocchini/imageRy")

library(imageRy)
library(terra)

#list the data
im.list()#lists the imagrey data

#let's use the blue band (it's band 2)
b2 <- im.import("sentinel.dolomites.b2.tif")
b2 






  
