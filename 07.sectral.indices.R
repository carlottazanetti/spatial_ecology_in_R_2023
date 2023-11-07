#vegetation indices

library(imageRy)
library(terra)

#mato grosso deforestation in brazil
im.list()
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
#bands: 1=NIR, 2=RED, 3=GREEN

im.plotRGB(m1992, r=1, g=2, b=3)
#vegetation is red. So this image in 1992, you can see how much forest there was

im.plotRGB(m1992, r=2, g=1, b=3)
#now veg is green

#or you can put the blue for ir so you see the bare soil better bc it0s yellow
#there is a path that is actually water

m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(m2006, r=2, g=3, b=1)
#use this to underline the deforetation










