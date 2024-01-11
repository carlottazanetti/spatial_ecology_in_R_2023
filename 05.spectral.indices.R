#vegetation indices

library(imageRy)
library(terra)

#mato grosso deforestation in brazil
im.list()
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
#bands: 1=NIR, 2=RED, 3=GREEN

im.plotRGB(m1992, r=1, g=2, b=3)
#vegetation is red. So this image in 1992, you can see how much forest there was

im.plotRGB(m1992, r=2, g=1, b=3)
#now veg is green

#or you can put the blue for ir so you see the bare soil better bc it0s yellow
#there is a path that is actually water

m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(m2006, r=2, g=3, b=1)
#use this to underline the deforetation
# the rio peixoto should be black (it's water) but it's actully the same color of the bare soil because of the high amount of sediments

# build a multiframe with 1992 and 2006 images
par(mfrow = c(1, 2))
im.plotRGB(m1992, r=2, g=3, b=1)
im.plotRGB(m2006, r=2, g=3, b=1) 

plot(m1992[[1]])

# most images ar sotred in 8bits to decrease to weight of the info
# to know how much info you can store you need to elevate 2 to the number of pixels that yu have

# DVI = NIR - RED, we use different band but in the same image
# The calculation is done pixel by pixel
# we use = because is not an asseignation, but it's the actual value
dvi1992 = m1992[[1]] - m1992[[2]]
plot(dvi1992)

cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi1992, col = cl)

dvi2006 = m2006[[1]] - m2006[[2]]
plot(dvi2006, col = cl)

# images with different ranges (different number of bits) cannot be compared
# for this reason we normalize the DVI
# Normalized DVI = NIR - RED / NIR + RED  (also other types of normalization)
# we obtain a range from 0 to 1
ndvi1992 = (m1992[[1]] - m1992[[2]]) / (m1992[[1]] + m1992[[2]]) 
plot(ndvi1992, col = cl)

ndvi2006 = (m2006[[1]] - m2006[[2]]) / (m2006[[1]] + m2006[[2]]) 
plot(ndvi2006, col = cl)

par(mfrow = c(1, 2))
plot(ndvi1992, col = cl)
plot(ndvi2006, col = cl)

# we can use a function to calculate DVI and NDVI to speed up calculation
ndvi2006a <- im.ndvi(m2006, 1, 2) # the numbers refer to the bands you want to use










