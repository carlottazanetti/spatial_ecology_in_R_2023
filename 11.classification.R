#Classifying satellite immages and estimate the amount of change

library(terra)
library(imageRy)

im.list()
sun <- im.import('Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg')

sunc <- im.classify(sun, num_clusters=3)
#it classifies in 3 classes: the hogher emount of energy is the 1st one, and so on. For classification we use
#a random number of pixel, so this might change slightly everytime we run the code. But the overall pattern
#should be the same. Also the class with the hoghest energy could be the number 2 or 3. U should always compare
#with the rgb

plot(sunc)












