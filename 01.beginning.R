# here I can comment

# R as a calculator
# assign objects
a <- 2 + 3 
b <- 5 + 3

a * b

c <- a * b
c^2

# array
sophi <- c(10, 20, 30, 50, 70) #microplastics
#c is a function that concatenates  # All functions have parenthesis

paula <- c(100, 500, 600, 1000, 2000) #people

plot(paula, sophi)

plot(paula, sophi, xlab='number of people', ylab='microplastics')

#or you could do
#people <- paula
#microplastics <- sophi

#you can also use other point symbols in the plot
plot(paula, sophi, xlab='number of people', ylab='microplastics', pch=20)
#or increase the dimension of the point
plot(paula, sophi, xlab='number of people', ylab='microplastics', pch=20, cex=2) #it doubles the original size
#we can also change the color
plot(paula, sophi, xlab='number of people', ylab='microplastics', pch=20, cex=2, col='blue')


#package sp
#cran is where all the packages are stored
install.packages('sp')
library(sp)




