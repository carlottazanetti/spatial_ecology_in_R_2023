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
