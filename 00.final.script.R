# Final script including all the different scripts during lectures

#--------------------

# Summary:
# 01 Beginning
# 02.1 Population density
# 02.2 Population distribution
# 03.1 Community multivariate analysis
# 03.2 Community overlap
# 04 Remote sensing data visualisation
# 05 Spectral indices
# 06 Time series
# 07 External data
# 08 Copernicus data
# 09 Classification
# 10 Variability
# 11 Principal Component Analysis
# useful functions

#--------------------


# 01 BEGINNING
# here I can comment
# R as a calculator
# assign objects
a <- 2 + 3 
b <- 5 + 3
a * b
c <- a * b
c^2

# array
sophi <- c(10, 20, 30, 50, 70) 
#c is a function that concatenates  # All functions have parenthesis
paula <- c(100, 500, 600, 1000, 2000) #people
plot(paula, sophi)
plot(paula, sophi, xlab='number of people', ylab='microplastics')
#you can also use other point symbols in the plot
plot(paula, sophi, xlab='number of people', ylab='microplastics', pch=20)
#or increase the dimension of the point
#https://www.google.com/search?client=ubuntu-sn&hs=yV6&sca_esv=570352775&channel=fs&sxsrf=AM9HkKknoSOcu32qjoErsqX4O1ILBOJX4w:1696347741672&q=point+symbols+in+R&tbm=isch&source=lnms&sa=X&ved=2ahUKEwia9brkm9qBAxVrQvEDHbEYDuMQ0pQJegQIChAB&biw=1760&bih=887&dpr=1.09#imgrc=lUw3nrgRKV8ynM
plot(paula, sophi, xlab='number of people', ylab='microplastics', pch=20, cex=2) #it doubles the original size
#we can also change the color
plot(paula, sophi, xlab='number of people', ylab='microplastics', pch=20, cex=2, col='blue')
#package sp
#cran is where all the packages are stored
install.packages('sp')
library(sp)

#--------------------

# 02.1 POPULATION DENSITY
# code related to population ecology
# we will use spatstat package for spatial point pattern analysis

#everytime we take something that is outside of R we need to use the brackets
install.packages('spatstat')
library(spatstat) #to check if it has been installed
#https://cran.r-project.org/web/packages/spatstat/index.html

#import the data inside the packages
#the dataset is called 'bei' and it's inside the package spatstat
#data description: 
#aways put the link as a comment
bei 

#plotting the data
plot(bei, cex=0.5, pch=19)

#there is also another dataset in the package: bei.extra
bei.extra
plot(bei.extra)

#how to select only one part of the dataset? There are different manners.like if we want to get elev
elevation <- bei.extra$elev
plot(elevation)
#or
elevation2 <- bei.extra[[1]]
plot(elevation2)

#passing from points to a continuos surface
density_map <- density(bei) #it's a function in the spatstat package
density_map
plot(density_map)
#let's put the points on top of the density map
plot(density_map)
points(bei, cex=0.2)

#let's change the colours
cl <- colorRampPalette(c('black','red','orange','yellow'))(100) #using the concatenate function to merge the colours
#100 is the gradient: how many colours do you want to pass from one colour from another
plot(density_map, col=cl)
#also interesting fact: remember that the yellow is the first colour we see so use it to highlight

#avoid green and red and blue, and never rainbow
cl <- colorRampPalette(c('black','brown4','burlywood2','beige','azure','aquamarine3','aquamarine4'))(100) #using the concatenate function to merge the colours
#100 is the gradient: how many colours do you want to pass from one colour from another
plot(density_map, col=cl)
#some famous palette are turbo, inferno and so on

plot(bei.extra)
elev <- bei.extra[[1]]
plot(elev)

#what if I want to plot multiple graphs? With multiframe
par(mfrow=c(1,2)) #1 row and 2 columns
plot(density_map)
plot(elev)
#you can also reverse the situation to have one on the top and the other on the botom
par(mfrow=c(2,1)) 
plot(density_map)
plot(elev)
#you can see that at higher elevations you have a lower amount of trees

#let's say you want 3 plots in a row, the first being trees, then density, then elevation
par(mfrow=c(1,3)) 
plot(bei)
plot(density_map)
plot(elev)

#--------------------

# 02.2 POPULATION DISTRIBUTION
#why populations disperse over the landscape in a certain manner?
library(terra) #for spatial functions
#https://cran.r-project.org/web/packages/terra/

library(sdm)  #species distribution modelling
https://cran.r-project.org/web/packages/sdm/index.html

file <- system.file('external/species.shp', package='sdm') #it gives you the file name. You write the path and the package it's from. SO the output is the path of the file

#there is a function in terra to pass from the file to the points in the vector in the file
rana <- vect(file)
rana

rana$Occurrence #so there is a frog in the point where you have a 1, and there is no frog where you have a 0.
# So it's called presence-absence data bc you are only stating if the species is there, not how many animals (otherwise it would be an abundance data)
#The absence data has some uncertainty bc maybe there was a frog there but you missed it
plot(rana) #but this plot represents both the zeros and the ones
#selecting only the 1 (so where the frogs are present)
pres <- rana[rana$Occurrence == 1 ,]
pres$Occurrence
plot(pres)
#now let's select the absences
abse <- rana[rana$Occurrence == 0 ,]
abse$Occurrence
plot(abse)

#let's plot them one after the other
par(mfrow=c(1,2)) #1 row and 2 columns
plot(pres)
plot(abse)

dev.off() #it closes all the graphs going on. It resets

#let's plot the absences and presences in the same plot with different colours
plot(pres, col='dark blue')
points(abse, col='light blue')

#now let's understand why the rana is distributed like that
#to do this we use predictors= environmental variables
#let's see where the file of the predictor is
elev <- system.file('external/elevation.asc', package='sdm') 
elevmap <- rast(elev) #from terra
#instead of vect, now we are dealing with pixels
plot(elevmap)
points(pres)
#so the rana is avoiding the valleys (maybe it's too hot?) and also avoiding high altitudes (maybe too cold)

#let's do the same with temperature
temp <- system.file('external/temperature.asc', package='sdm') 
tempmap <- rast(temp) #from terra
plot(tempmap)
points(pres)

#same with cover of vegetation
veg <- system.file('external/vegetation.asc', package='sdm') 
vegmap <- rast(veg) #from terra
plot(vegmap)
points(pres)

#same with precipitation
prec <- system.file('external/precipitation.asc', package='sdm') 
precmap <- rast(prec) #from terra
plot(precmap)
points(pres)

par(mfrow=c(2,2)) #2 rows and 2 columns
plot(elevmap)
points(pres)
plot(tempmap)
points(pres)
plot(vegmap)
points(pres)
plot(precmap)
points(pres)

#--------------------


# 03.1 COMMUNITY MULTIVARIANCE ANALYSIS
library(vegan)
https://cran.r-project.org/web/packages/vegan/index.html

data(dune) #it recalls the data so you can use them
#let's take a look at the data
dune #the numbers erpresent the number of individuals for each species inside the plot 
#another way to visualize the data is using head() that shows only the first 6 rows
head(dune)
#tail() shows you only the last rows

#decorana() is the Detrended Correspondence Analysis and Basic Reciprocal Averaging. It's from Vegan
ord <- decorana(dune)
#we are interested in finding the length of the range of each dimension
summary(ord) #and look ar Axis lengths
#ldc is the length of eaqch one
ldc1 <- 3.7004
ldc2 <- 3.1166
ldc3 <- 1.30055
ldc4 <- 1.47888

total = ldc1 + ldc2 + ldc3 + ldc4

#so you can see the percentage
pldc1 = ldc1 * 100 / total
pldc2 = ldc2 * 100 / total
pldc3 = ldc3 * 100 / total
pldc4 = ldc4 * 100 / total

pldc1
pldc2

#let's focus omn the first 2
pldc1 + pldc2 
#they represent 71% so we can discard the others, also seeing stuff in 2D is always convenient

plot(ord)
#the numbers are the original plots , and you can see the names of the species: some species like to stay together
#the part in the bottom left is dedicated to grassland. 
#the 2 dimensions are the x in multivariant analysis
#but species are also related in time, not only in space

#--------------------

# 03.2 COMMUNITIES OVERLAP
#we will deal with relation among species in time
#for space relation we used multivariant analysis

library(overlap)
#these are data coming from kerinci national park (tropical forest in indonesia)
data(kerinci)
head(kerinci) #to see the first 6 lines
#the 3rd column is the space, the unit is the day, so 1.5 means the middle of the second day

summary(kerinci)

#let's look at the movements of the tiger during the day
#so let's select the tiger data
tiger <- kerinci[kerinci$Sps == 'tiger',] #sps is the column with the species

#let's pass from a linear time to a circular time
kerinci$TimeRad <- kerinci$Time * 2 * pi
#ora hai un'altra colonna col tempo in radianti

tiger <- kerinci[kerinci$Sps == 'tiger',] #sps is the column with the species
timetig <- tiger$TimeRad

densityPlot(timetig, rug=TRUE) #so you can see the histogram and the times during the day where most tigers pass
#rug smooths out the curve

#select only the data on macaques
macaque <- kerinci[kerinci$Sps == 'macaque',] #sps is the column with the species
timemac <- macaque$TimeRad
densityPlot(timemac, rug=TRUE)

#let's overlap them
overlapPlot(timetig, timemac)
#the colored part is the overlap

# adding a legend
legend('topright', c("Tigers", "Macaques"), lty=c(1,2), col=c("black","blue"), bty='n')

#--------------------

# 04 REMOTE SENSING DATA VISUALISATION
# This is a script to visualize satellite data
# colors are representing the amount of reflectance of a pixel in a certain wavelenght
# plants fro example use mostly red light to carry out photosynthesis

# to install packages from the CRAN
install.packages("devtools")
library(devtools) # packages in R are also called libraries
#https://cran.r-project.org/web/packages/devtools/index.html

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

# importing the red band 
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
#you can do this with all the variables you want
pairs(stacksent)
#if you have 4 elements, you will have 4x3/2=6 number of correlations, all the distances. 
#you have the graphs, then the pearson coefficient
#è tipo battaglia navale, guarda ogni grafico verde è una banda, poi incrocia la riga con la colonna di due bande diverse e vedi il loror pearson coefficient
#the values on the axes are reflectance
#the green histogram is the frequency of every value of reflectance: in almost all the bands you have more values with low reflectance.

#--------------------

# 05 SPECTRAL INDICES
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
#or you can put the blue for ir so you see the bare soil better bc it's yellow
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

#--------------------

# 06 TIMESERIES
#time series analysis

library(imageRy)
library(terra)

im.list()

 #importing data (EN= European Nitrogen)
EN01 <- im.import("EN_01.png") #it's the situation in january
EN13 <- im.import("EN_13.png") #march

par(mfrow=c(2,1))
im.plotRGB.auto(EN01) #it will directly plot an rgb image using the first 3 bands
im.plotRGB.auto(EN13)

dev.off()
#Let's make the difference between them
diff = EN01[[1]] - EN13[[1]] #using the first band
plot(diff)
#let's change the colormap
#remember that blue and red, or green and red is not ideal for daltonic people
coldiff <- colorRampPalette(c('blue','white', 'red'))(100)
plot(diff,col=coldiff)
#red= higher NO2 concentration in jan

#copernicus global land servi look it up to download data
#let's work with temperature in Greenland
im.list()
g2000 <- im.import("greenland.2000.tif"  )
colg <- colorRampPalette(c('blue','white', 'red'))(100)
plot(g2000, col=colg)
#in the middle of greenland there is a very low t

g2005 <- im.import("greenland.2005.tif"  )
g2010 <- im.import("greenland.2010.tif"  )
g2015 <- im.import("greenland.2015.tif"  )

plot(g2015, col=colg)
#let's add more colors
colg <- colorRampPalette(c('black','blue','white', 'red'))(100)
plot(g2015, col=colg)

par(mfrow=c(1,2))
plot(g2000, col=colg)
plot(g2015, col=colg)

#plotting all the 4 images
stackg <- c(g2000, g2005, g2010, g2015)
plot(stackg, col=colg)

#exercise: differece btwn the first and final eleent of stack
diffg = stackg[[1]] - stackg[[4]]
plot(diffg, col=coldiff)
#or diffg= g2000 - g2015

#let's put the first value of stack in Red (2000), the second in green and the third in blue
im.plotRGB(stackg, r=1, g=2, b=3)
#in the west part you have red, so high T in 2000. 
#In the north u have green, so T was higher in 2005
#the middle is blue so T was higher in 2010

#--------------------

# 07 EXTERNAL DATA
#external data

library(terra)

#set working directory (where the file is)
setwd('C:/Users/carlo/Downloads') #remember not to use \

naja <- rast('najafiraq_etm_2003140_lrg.jpg') #ignora il messaggio di avvertimento

plotRGB(naja, r=1, g=2, b=3)

#let's download another pic
najaaug <- rast('najafiraq_oli_2023219_lrg.jpg') #ignora il messaggio di avvertimento
plotRGB(najaaug, r=1, g=2, b=3)

par(mfrow=c(2,1))
plotRGB(naja, r=1, g=2, b=3)
plotRGB(najaaug, r=1, g=2, b=3)

#multitemporal change detection
najadif=naja[[1]]-najaaug[[1]]
cl <- colorRampPalette(c('brown','grey','orange'))(100)
plot(najadif, col=cl)
#so the points where the highest difference are in orange. 
#U should do this in your project

#some other data
crater <- rast('tenoumer_ast_2008024_lrg.jpg') #ignora il messaggio di avvertimento
plotRGB(crater, r=1, g=2, b=3)

#--------------------

#08 COPERNICUS DATA
#with copernicus u can search for a specific year
install.packages('ncdf4')
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html#Home

library(ncdf4)
library(terra)

# giving the working directory of the data to R
setwd("C:/Users/sarar/Downloads")

# importing the data
veg_poland <- rast("c_gls_NDVI300_QL_202311110000_GLOBE_OLCI_V2.0.1.tiff")
plot(veg_poland)     
plot(veg_poland[[1]]) 

cl <- colorRampPalette(c('red','orange','yellow')) (100)
plot(veg_poland[[1]], col=cl) 

# making a crop of the image (selecting an area [ex. lake])
# defining the extention (minlon, maxlon, minlat, maxlat)
ext <- c(20, 23, 55, 57)   # I define it "externally" so I can use it also for other images
veg_poland <- crop(veg_poland, ext)

plot(veg_poland[[1]], col=cl)

surf_soil_moist2023_24 <- rast("c_gls_SSM1km_202311240000_CEURO_S1CSAR_V1.2.1.nc")
surf_soil_moisture2023_24_crop <- crop(surf_soil_moisture2023_24, ext)  # gives error becase probabli in this image there's nothing at the selected ext

#--------------------

# 09 CLASSIFICATION
#Classifying satellite immages and estimate the amount of change

library(terra)
library(imageRy)

im.list()
sun <- im.import('Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg')

sunc <- im.classify(sun, num_clusters=3)
#it classifies in 3 classes: the higher emount of energy is the 1st one, and so on. For classification we use
#a random number of pixel, so this might change slightly everytime we run the code. But the overall pattern
#should be the same. Also the class with the highest energy could be the number 2 or 3. U should always compare
#with the rgb

plot(sunc)

# Let's apply the same thing to Mato Grosso images
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

# the classes are 2: forest and agricultural areas
m1992_cluster <- im.classify(m1992, 2)
plot(m1992_cluster)

m2006_cluster <- im.classify(m2006, 2)
plot(m2006_cluster)

# we need to specify the element because we're getting 3 images showing the same thing (need to update imageRy)
par(mfrow=c(1,2))
plot(m1992_cluster[[1]])
plot(m2006_cluster[[1]])

# Let's calculate the frequency of the pixels in a certain class
f1992 <- freq(m1992_cluster)
f1992

tot_1992 <- ncell(m1992_cluster)
tot_1992
percentage_1992 <- f1992 * 100 / tot_1992 
percentage_1992

f2006 <- freq(m2006_cluster)
f2006

tot_2006 <- ncell(m2006_cluster)
tot_2006
percentage_2006 <- f2006 * 100 / tot_2006 
percentage_2006

# Let's build a table with the results
classes <- c('human', 'forest')
y1992 <- c(17, 83)    # percentages for the two classes in that year
y2006 <- c(54, 45)

#build a table
results <- data.frame(classes, y1992, y2006) 
results

library(ggplot2)
#https://cran.r-project.org/web/packages/ggplot2/index.html
library(patchwork)
#https://cran.r-project.org/web/packages/patchwork/index.html

# Final bar plot displaying the results
p1 <- ggplot(results, aes(x=classes, y=y1992, color=classes)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(results, aes(x=classes, y=y2006, color=classes)) + geom_bar(stat="identity", fill="white")
p1+p2

p1 <- ggplot(results, aes(x=classes, y=y1992, color=classes)) + geom_bar(stat="identity", fill="white")+ylim(c(0,100))
p2 <- ggplot(results, aes(x=classes, y=y2006, color=classes)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1+p2

#--------------------

# 10 VARIABILITY
library(imageRy)
library(terra)
library(viridis)
#https://cran.r-project.org/web/packages/viridis/index.html

im.list()

glacier <- im.import("sentinel.png")

# b1=NIR, b2=red, b3=green
im.plotRGB(glacier, r=1, g=2, b=3)
im.plotRGB(glacier, r=2, g=1, b=3)

# varibility (in our case as standard deviation) can be calculated only on one variable
# we can use the NIR as an example
nir <- glacier[[1]]
plot(nir)

# let's use a moving window
# the matrix describes the dimensions of the moving window: composed by 9 pixels (1/9) distributed as 3 by 3
# "fun" call the function
sd_glacier <- focal(nir, matrix(1/9, 3, 3), fun=sd)
viridisc <- colorRampPalette(viridis(7))(255)
plot(sd_glacier, col=viridisc)

#exercise: calculate variability in 7x7 moving window
sd_glacier2 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd_glacier2,col=cl_vir)

#plot both of them
par(mfrow = c(1, 2))
plot(sd_glacier, col=cl_vir)
plot(sd_glacier2,col=cl_vir)
#with the 3x3 it's a very local calculation, u can see subtle differences. If u enlarge the moving window, u will enlarge the number of pixels
#so this is why u have a higher variability

#original and 7x7
par(mfrow = c(1, 2))
im.plotRGB(glacier, r=2, g=1, b=3)
plot(sd_glacier2,col=cl_vir)
#u have a high std in boundaries, bc the pixel on the boundary will be different from the surrounding ones. 
#so it can indicate high geological variability

#--------------------

# 11 PRINCIPAL COMPONENT ANALYSIS
#so we take the sentinel data, but istead of using only one band, we do the Principal component analysis

library(imageRy)
library(terra)
library(viridis)

dev.off()

sent <- im.import('sentinel.png')

pairs(sent)
#sentinel_2 and sentinel_3 are red and green and they are really correlated to each other, the p value is 0.98 and
#the graph is like a disk, so high correlation. The nir is less correlated to the red one, the graph is a mess and p is like 0.3.
#don't look at NA, is a constant

#perform PCA on sent
sentpc <-  im.pca2(sent)
#if it doesn't work use im.pca()
#it gives u the percentage of each pc. The first oc is 77
#in this case there is no meaning for the color, it's jsut a scale

pc1 <- sentpc$PC1
plot(pc1)

cl_vir <- colorRampPalette(viridis(7))(255)
plot(pc1, col=cl_vir)

#calculating std on top of pc1
pc1sd3 <- focal(pc1, matrix(1/9,3,3), fun=sd)
plot(pc1sd3, col=cl_vir)
#so instead of having to choose a specific band, you just do it on the first pc


pc1sd7 <- focal(pc1, matrix(1/49,7,7), fun=sd)
plot(pc1sd7, col=cl_vir)

#so instead of having to choose a specific band, you just do it on the first pc:
par(mfrow = c(2,3))
im.plotRGB(sent, 2, 1, 3)
plot(sd_glacier, col=cl_vir) #sd in NIR that we did last time
plot(sd_glacier2,col=cl_vir) #sd in NIR that we did last time
plot(pc1, col=cl_vir)
plot(pc1sd3, col=cl_vir)
plot(pc1sd7, col=cl_vir)

#we can also stack images in another way:
sdstack <- c(sd_glacier,sd_glacier2,pc1sd3,pc1sd7)
names(sdstack) <- c('sd3', 'sd7', 'pc1sd3', 'pc1sd7')
plot(sdstack, col=cl_vir)
#so previously we chose the NIR bc we knew we had to use that band, but what if we didn't know?
#that's what the pc is for: inestead of choosing a specific band, you choose the pc1

#--------------------

#USEFUL FUNCTIONS
c(1,2,3) #concatenates
plot(x,y,xlab='number of people', ylab='microplastics', pch=20, cex=2, col='blue') #x,y,xlabel, ylabel, point symbol, point dimension, colour
cl <- colorRampPalette(c('black','red','orange','yellow'))(100) #to create e palette. 100 is the gradient
elevation <- bei.extra$elev #to only select elev in bei.extra
elevation2 <- bei.extra[[1]] #to only select elev un bei.extra
density_map <- density(bei) #function of spatstat package to pass from points to continuous density map
plot(density_map)
points(bei, cex=0.2, col='blue') #to plot density map with points on top
par(mfrow=c(1,2)) # to plot multiple graphs in a plot. 1 row and 2 columns 
system.file('external/species.shp', package='sdm') #you input the path in the package and it gives you the file name
rana <- vect(file) #function of terra to pass from the file to the points in the vector of a file
elevmap <- rast(elev) #from terra, instead of vect, now we are dealing with pixels
dev.off() #it closes all the graphs going on. It resets
data(dune) #you recall the data 'dune' inside the package vegan
#head() #only shows you the first 6 rows of the dataset
#tail() #only shows you the last 6 rows of the dataset
ord <- decorana(dune) #decorana() is the Detrended Correspondence Analysis and Basic Reciprocal Averaging. It's from Vegan
densityPlot(timetig, rug=TRUE) #to make a density plot. Rug smooths out the curve
overlapPlot(timetig, timemac) #you can overlap two plots
legend('topright', c("Tigers", "Macaques"), lty=c(1,2), col=c("black","blue"), bty='n') #legend. Ity is linetype. bty is the type of box to be drawn around the legend.
im.list() #lists the imagrey data
b3 <- im.import("sentinel.dolomites.b3.tif") #import data from imagery package
im.plotRGB(stacksent, r=3, g=2, b=1)
im.ndvi(m2006, 1, 2) #function of imagery to plot the normalized difference vegetation index
im.plotRGB.auto(EN01) #function of imagery that will directly plot an rgb image using the first 3 bands
setwd('C:/Users/carlo/Downloads') #set working directory
sunc <- im.classify(sun, num_clusters=3) #function of imagery that divides in clusters that classify the energy of the picture
f1992 <- freq(m1992_cluster) #it calculates the frequency of pixels of a certain class
data.frame(classes, y1992, y2006)  #formatting the data into a table
ggplot(results, aes(x=classes, y=y1992, color=classes)) + geom_bar(stat="identity", fill="white") #geom_bar counts the number of cases at each x position
sd_glacier <- focal(nir, matrix(1/9, 3, 3), fun=sd) #the matrix describes the dimensions of the moving window: composed by 9 pixels (1/9) distributed as 3 by 3. fun calls he function
sentpc <-  im.pca2(sent) #it gives you the variance explained by every pc
sdstack <- c(sd_glacier,sd_glacier2,pc1sd3,pc1sd7) #stack graphs in the same plot
names(sdstack) <- c('sd3', 'sd7', 'pc1sd3', 'pc1sd7') #corresponding titles












