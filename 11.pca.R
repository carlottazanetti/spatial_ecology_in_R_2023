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





