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

# Let's apply the same thing to Mato Grosso images
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

# the classes are 2: forest and agricultural areas
m1992_cluster <- im.classify(m1992, 2)
plot(m1992_cluster)

m2006_cluster <- im.classify(m2006, 2)
plot(m2006_cluster)

# we need to specify the element because we're getting 3 images showing the same thing (need to update imageRy)
par(mfrow=c(1,2))
plot(m1992_cluster[[1]])
plot(m2006_cluster[[1]])

# Let's calculate the frequency of the pixels in a certain class
f1992 <- freq(m1992_cluster)
f1992

tot_1992 <- ncell(m1992_cluster)
tot_1992
percentage_1992 <- f1992 * 100 / tot_1992 
percentage_1992

f2006 <- freq(m2006_cluster)
f2006

tot_2006 <- ncell(m2006_cluster)
tot_2006
percentage_2006 <- f2006 * 100 / tot_2006 
percentage_2006

# Let's build a table with the results
classes <- c('human', 'forest')
y1992 <- c(17, 83)    # percentages for the two classes in thta year
y2006 <- c(54, 45)

#build a table
results <- data.frame(classes, y1992, y2006) 
results

library(ggplot2)
library(patchwork)

# Final bar plot displaying the results
p1 <- ggplot(results, aes(x=class, y=percentage_1992, color=class)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(results, aes(x=class, y=percentage_2006, color=class)) + geom_bar(stat="identity", fill="white")
p1+p2

p1 <- ggplot(results, aes(x=class, y=percentage_1992, color=class)) + geom_bar(stat="identity", fill="white")+ylim(c(0,100))
p2 <- ggplot(results, aes(x=class, y=percentage_2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1+p2







