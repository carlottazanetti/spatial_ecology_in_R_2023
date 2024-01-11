# colors are representing the amount of reflectance of a pixel in a certain wavelenght

# plants use mostly red light to carry out photosynthesis

# to install packages from the CRAN
install.packages("devtools")

# to install packeges from github
devtools::install_github("ducciorocchini/imageRy")

library(imageRy)
library(devtools) #to install from github

# import the different data we're going to use
# b2 refers to band 2
b2 <- im.import("sentinel.dolomites.b2.tif")
b2


