#why populations disperse over the landscape in a certain manner?
library(terra) #for spatial functions
library(sdm)  #species distribution modelling

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





