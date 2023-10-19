#we will deal with relation among species in time
#for space relation we used multivariant analysis

library(overlap)
#these are data coming from kerinci national park (tropical forest in indonesia)
data(kerinci)

head(kerinci) #to see the first 6 lines
#the 3rd column is the space, the unit is the day, so 1.5 means the middle of the second day

summary(kerinci)

#let's look at the movements of the tiger during the day
#so let's select the tiger data
tiger <- kerinci[kerinci$Sps == 'tiger',] #sps is the column with the species

#let's pass from a linear time to a circular time
kerinci$TimeRad <- kerinci$Time * 2 * pi
#ora hai un'altra colonna col tempo in radianti

tiger <- kerinci[kerinci$Sps == 'tiger',] #sps is the column with the species
timetig <- tiger$TimeRad

densityPlot(timetig, rug=TRUE) #so you can see the histogram and the times during the day where most tigers pass
#rug smooths out the curve

#select only the data on macaques
macaque <- kerinci[kerinci$Sps == 'macaque',] #sps is the column with the species
timemac <- macaque$TimeRad
densityPlot(timemac, rug=TRUE)

#let's overlap them
overlapPlot(timetig, timemac)
#the colored part is the overlap




