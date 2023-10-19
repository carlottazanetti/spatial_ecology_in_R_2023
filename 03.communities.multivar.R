library(vegan)

data(dune) #it recalls the data so you can use them
#let's take a look at the data
dune #the numbers erpresent the number of individuals for each species inside the plot 
#another way to visualize the data is using head() that shows only the first 6 rows
head(dune)
#tail() shows you only the last rows

#decorana() is the Detrended Correspondence Analysis and Basic Reciprocal Averaging. It's from Vegan
ord <- decorana(dune)
#we are interested in finding the length of the range of each dimension
summary(ord) #and look ar Axis lengths
#ldc is the length of eaqch one
ldc1 <- 3.7004
ldc2 <- 3.1166
ldc3 <- 1.30055
ldc4 <- 1.47888

total = ldc1 + ldc2 + ldc3 + ldc4

#so you can see the percentage
pldc1 = ldc1 * 100 / total
pldc2 = ldc2 * 100 / total
pldc3 = ldc3 * 100 / total
pldc4 = ldc4 * 100 / total

pldc1
pldc2

#let's focus omn the first 2
pldc1 + pldc2 
#they represent 71% so we can discard the others, also seeing stuff in 2D js always convenient


plot(ord)
#the numbers are the original plots , and you can see the names of the species: some species like to stay together
#the part in the bottom left is dedicated to grassland. 
#the 2 dimensions are the x in multivariant analysis

#but species are also related in time, not only in space









