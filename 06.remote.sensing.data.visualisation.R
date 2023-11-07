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

# Let's change the color
cl <- colorRampPalette(c("black", "gray", "light gray")) (100)
plot(b2, col = cl)

# importing the green band
b3 <- im.import("sentinel.dolomites.b3.tif")
plot(b3, col = cl)

# importing the red band (600 microns)
b4 <- im.import("sentinel.dolomites.b4.tif")
plot(b4, col = cl)

# import the NIR band
b8 <- im.import("sentinel.dolomites.b8.tif")
plot(b8, col = cl)

# Let's put all the images in a single graph
par(mfrow = c(2,2))
plot(b2, col = cl)
plot(b3, col = cl)
plot(b4, col = cl)
plot(b8, col = cl)
dev.off() # it closes the devices

# stack images all together
stacksent <- c(b2, b3, b4, b8)

plot(stacksent, col = cl)

# to plot just one layer from the stack we can use the number of the "element" (layer)
plot(stacksent[[4]], col = cl)

# Plot in a multiframe the bands with different color ramps
cl2 <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
cl3 <- colorRampPalette(c("dark green", "green", "light green")) (100)
cl4 <- colorRampPalette(c("firebrick4", "firebrick", "red")) (100)
cl8 <- colorRampPalette(c("orangered", "gold", "yellow")) (100)

par(mfrow = c(2,2))
plot(b2, col = cl2)
plot(b3, col = cl3)
plot(b4, col = cl4)
plot(b8, col = cl8)

# Using the RGB space
# stacksent:
# band2 blue element 1, stacksent[[1]]
# band3 green element 2, stacksent[[2]]
# band4 red element 3, stacksent[[3]]
# band8 NIR element 4), stacksent[[4]]
#so you get the pic how you'd see it from space
im.plotRGB(stacksent, r=3, g=2, b=1) # the number refers to the index of the element 
#but this is not such a nice image, everything is dark

#we are going to sacrifice ome of the bands, we move up by one so we sacrifice blue for example 
im.plotRGB(stacksent, r=4, g=3, b=2) # the number refers to the index of the element 
#now all the elements that reflect in the NIR will be visualized as red (so vegetation)
#the dark red is broad leaf whereas the light red is pasture, water is black , or also the shadow of the mountain is black

im.plotRGB(stacksent, r=3, g=4, b=2)
#now the NIR is green. It's really nice you can see trees. The purple is bear soil

im.plotRGB(stacksent, r=3, g=2, b=4)
#now nir is blue and bear soil is yellowish, so this is good if you want to visualize urban areas or bare soil

#what if you want to see how much 2 bands are correlated? 
#You could do a plot with two bands and for each pixel you will have a certain value in the 2 bands and see if they are correlated
#There is a function to do this for all the bands
?pairs
#you can do this with all the variables you want
pairs(stacksent)
#if you have 4 elements, you will have 4x3/2=6 number of correlations, all the distances. 
#you have the graphs, then the pearson coefficient
#è tipo battaglia navale, guarda ogni grafico verde è una banda, poi incrocia la riga con la colonna di due bande diverse e vedi il loror pearson coefficient
#the values on the axes are reflectance
#the green histogram is the frequency of every value of reflectance: in almost all the bands you have more values with low reflectance.

#18 jan,  31 jan, 16 feb, 23 feb date esami
#marine 30 jan and 22 feb


























  
