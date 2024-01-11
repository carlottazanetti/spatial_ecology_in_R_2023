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

#woth copernicus u can search for a specific year
install.packages('ncdf4')









