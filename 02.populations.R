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


