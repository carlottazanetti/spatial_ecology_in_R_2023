library(imageRy)
library(terra)
library(viridis)

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
plot(sd_glacier)

cl_vir <- colorRampPalette(viridis(7))(255)
plot(sd_glacier, col=cl_vir)

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

#how do we choose at what band we do the std (like for example here we used nir)? multivariant analysis (next code)







