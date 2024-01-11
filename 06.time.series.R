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







