# code related to population ecology
# we will use spatstat package for spatial point pattern analysis

#everytime we take something that is outside of R we need to use the brackets
install.packages('spatstat')
library(spatstat) #to check if it has been installed

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


