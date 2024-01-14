#Exploring the variability of snow in Iceland using Sentinel 2 data
#Focusing on Fagradalsfjall region
#All the data are downloaded from the Copernicus site
#https://dataspace.copernicus.eu/browser/?zoom=9&lat=64.05298&lng=-21.79962&themeId=DEFAULT-THEME&visualizationUrl=https%3A%2F%2Fsh.dataspace.copernicus.eu%2Fogc%2Fwms%2Fa91f72b5-f393-4320-bc0f-990129bd9e63&datasetId=S2_L2A_CDAS&fromTime=2020-03-08T00%3A00%3A00.000Z&toTime=2020-03-08T23%3A59%3A59.999Z&layerId=2_TONEMAPPED_NATURAL_COLOR&demSource3D=%22MAPZEN%22&cloudCoverage=51&dateMode=SINGLE

#--------------------

# Summary:
# 01 Importing modules and setting the working directory
# 02 Investigating the snow seasonal cycle 
# 02 Investigating the change in snow cover throughout the years
# 03 A remarkable phenomenon: Fagradalsfjall volcanic eruption

#--------------------

# 01 Importing modules and setting the working directory
library(terra)
#terra package -> https://cran.r-project.org/web/packages/terra/
library(imageRy)
#imageRy package -> https://github.com/ducciorocchini/imageRy
library(ggplot2)
#ggplot2 package -> https://cran.r-project.org/web/packages/ggplot2/index.html

#setting the working directory to be the folder where we have the downloaded data:
setwd('C:/Users/carlo/Desktop/MONITORING ECOSYSTEMS/exam')

#--------------------

# 02 Investigating the snow seasonal cycle

#Importing the images
#Unfortunately no data available for december
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

#Stacking the images all together
seasons <- c(jan,feb,mar,apr,may,jun,jul,aug,sept,oct,nov)
par(mfrow = c(4,3))
for(i in seq(from = 1, to = 33, by = 3)) {plotRGB(seasons, i, i+1, i+2)}

#Dividing each image into 4 classes to detect snow
#(only doing that for the images that have some snow cover)
jan_cluster <- im.classify(jan, 4)
feb_cluster <- im.classify(feb, 4)
mar_cluster <- im.classify(mar, 4)
apr_cluster <- im.classify(apr, 4)
may_cluster <- im.classify(may, 4)
nov_cluster <- im.classify(nov, 4)

snow_clusters <- c(jan_cluster[[1]], feb_cluster[[1]], mar_cluster[[1]], apr_cluster[[1]],  may_cluster[[1]], nov_cluster[[1]])
par(mfrow = c(3,2))
plot(snow_clusters)

#Calculating the percentage of snow pixel
#!the snow cluster is not the same value for every picture!
#So the frequencies must be compared with the cluster images to unferstand which is the value correpsonding to snow
freq_jan <- freq(jan_cluster[[1]])
snow_jan <- freq_jan[[2,3]]
tot_jan <- ncell(jan_cluster[[1]])
percentage_jan <- snow_jan * 100 / tot_jan
percentage_jan

freq_feb <- freq(feb_cluster[[1]])
snow_feb <- freq_feb[[3]][[3]]
tot_feb <- ncell(feb_cluster[[1]])
percentage_feb <- snow_feb * 100 / tot_feb
percentage_feb

freq_mar <- freq(mar_cluster[[1]])
snow_mar <- freq_mar [[3]][[1]]
tot_mar <- ncell(mar_cluster[[1]])
percentage_mar <- snow_mar * 100 / tot_mar
percentage_mar

freq_apr <- freq(apr_cluster[[1]])
snow_apr <- freq_apr[[3]][[1]]
tot_apr <- ncell(apr_cluster[[1]])
percentage_apr <- snow_apr * 100 / tot_apr
percentage_apr

freq_may <- freq(may_cluster[[1]])
snow_may <- freq_may[[3]][[3]] 
tot_may <- ncell(may_cluster[[1]])
percentage_may <- snow_may * 100 / tot_may
percentage_may

freq_nov <- freq(nov_cluster[[1]])
snow_nov <- freq_nov[[3]][[2]]
tot_nov <- ncell(nov_cluster[[1]])
percentage_nov <- snow_nov * 100 / tot_nov
percentage_nov

#Concatenating all the percentages of snow pixels in one vector (I just put 0 for the months where the snow cover is 0)
snow_coverage <- c(percentage_jan, percentage_feb, percentage_mar, percentage_apr, percentage_may, 0, 0, 0, 0, 0, percentage_nov) 

#Building a table with the results
months <- c('jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sept', 'oct', 'nov')
results <- data.frame(months, snow_coverage) 
results

#Plotting the results
ggplot(results, aes(x=months, y=snow_coverage, color=months)) + geom_bar(stat="identity", fill="white") + 
scale_x_discrete(limits = months) 

#--------------------

# 03 Investigating the change in snow cover throughout the years

#Importing the data
apr2020 <- rast('apr2020.jpg')
apr2022 <- rast('apr2022.jpg')
apr2023 <- rast('apr2023.jpg')
snow <- c(apr2020[[1]], apr2022[[1]], apr2023[[1]])

#Plotting the data
 cl <- colorRampPalette(c('black','red','orange','yellow'))(100)
 par(mfrow = c(1,3))
 plot(snow[[1]], col=cl, xlab='2020')
 plot(snow[[2]], col=cl, xlab= '2022')
 plot(snow[[3]], col=cl, xlab= '2023')
 par(mfrow = c(1,3))
 plot(snow_cover[[1]], col=cl, xlab='apr 2020')
 plot(snow_cover[[2]], col=cl, xlab= 'apr 2022')
 plot(snow_cover[[3]], col=cl, xlab= 'apr 2023')
 pairs(snow_cover)
 snowpc <-  im.pca2(snow_cover)



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






