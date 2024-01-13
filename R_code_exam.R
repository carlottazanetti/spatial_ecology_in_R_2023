#Exploring the variability of Iceland using Sentinel 2 data
#prendi un anno e plotti l'immagine per ogni mese, poi usi m1992_cluster <- im.classify(m1992, 2) per vedere l'amount di neve e come calbia cos' puoi fare l'istogramma della seasonal var

#Investigating seasonal variability
library(terra)
#setting the working directory to be the folder where we have the downloaded data:
setwd('C:/Users/carlo/Desktop/MONITORING ECOSYSTEMS/exam')

jan <- rast('jan.jpg')
feb <- rast('feb.jpg')
mar <- rast('march.jpg')
apr <- rast('apr.jpg')
may <- rast('may.jpg')
jun <- rast('june.jpg')
jul <- rast('july.jpg')
aug <- rast('aug.jpg')
sept <- rast('sept.jpg')
oct <- rast('oct.jpg')
nov <- rast('nov.jpg')

seasons <- c(jan,feb,mar,apr,may,jun,jul,aug,sept,oct,nov)

par(mfrow = c(3,4))
for i in






#scegli due/tre anni e fai il confronto ispirati a greenland



#some remarkable phenomena: volcanic eruption in Fagradalsfjall 
#importing the image in true RBG colors
iceland_eruption_trueRGB <- rast('iceland_eruption_trueRGB.jpg')
plot(iceland_eruption_trueRGB)

#Importing the image in the 3 bands of interest (2.1 microns -> SWIR, 0.8 microns -> NIR, 0.6 microns -> visible)
b2.1 <- rast('iceland_eruption_2.1.jpg')
b0.8 <- rast('iceland_eruption_0.8.jpg')
b0.6 <- rast('iceland_eruption_0.6.jpg')

#stacking images all together 
stacksent <- c(b2.1[[1]], b0.8[[1]], b0.6[[1]])
#choosing greyscale to show the 3 bands
grayscale <- colorRampPalette(c("black", "gray", "light gray")) (100)

par(mfrow = c(2,2))
plot(iceland_eruption_trueRGB)
plot(stacksent[[1]], col=grayscale)
plot(stacksent[[2]], col=grayscale)
plot(stacksent[[3]], col=grayscale)

#resetting the plot
dev.off()

#plotting the image in false RBG colors
plotRGB(stacksent, r=1, g=2, b=3)






