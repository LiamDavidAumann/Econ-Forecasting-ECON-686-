data("mtcars")
mtcars

#With MPG in the Y-axis the data is deceptive
plot(mtcars$cyl,mtcars$mpg)
#This sort of fixes it but cylinders on x-axis is more intuitive
plot(mtcars$mpg,mtcars$cyl)

#To fix this set the y-lim
plot(mtcars$cyl,mtcars$mpg, ylim = c(0, 40))

#Add Labels
plot(mtcars$cyl,mtcars$mpg, ylim = c(0, 40),
     main="Num of Cylinders vs MPG",
     ylab = "Miles Per Gallon (MPG)",
     xlab="Number of Cylinders")

#Make Sure The Font is a readable size
plot(mtcars$cyl,mtcars$mpg, ylim = c(0, 40),
     main="Num of Cylinders vs MPG",
     ylab = "Miles Per Gallon (MPG)",
     xlab="Number of Cylinders",
     cex.lab=1.4)

#Make the title readable
plot(mtcars$cyl,mtcars$mpg, ylim = c(0, 40),
     main="Num of Cylinders vs MPG",
     ylab = "Miles Per Gallon (MPG)",
     xlab="Number of Cylinders",
     cex.main=1.6,
     cex.lab=1.4)

#Read in the inflation data from github
inflation <- read.csv("https://raw.githubusercontent.com/bachmeil/econ-686-fall-2022/main/inflation.csv", header=TRUE)
names(inflation) <- c("Date","dcpi")
dcpi <- ts(inflation[, "dcpi"], start = c(1948, 1), frequency = 12)

plot(dcpi)
#X-axis is time
# Year is the integer value
# Month Quarter etc is the decimal of x-axis
plot(dcpi, main="CPI Inflation")

#Adjust line width with LWD
plot(dcpi, main="CPI Inflation",
     lwd = 1.4)
#Too thick "don't do this"
plot(dcpi, main="CPI Inflation",
     lwd=4.4)
#Too thin
plot(dcpi, main="CPI Inflation",
     lwd=.25)

#Set line type with lty
#Good if you have multiple lines on one graph
plot(dcpi, main="CPI Inflation",
     lwd = 1.4,
     lty=2)

#Subset the data with window:
plot(window(dcpi, start=c(2005,1), end=c(2014,12)), main="CPI Inflation")

#Plot & Guess method

rain <- c(30,32,18,24,38,32)
harvest <- c(150,145,55,70,180,150)
plot(rain,harvest)
plot(rain,harvest,ylim = c(0,200),xlim=c(0,50))
abline(a=0,b=10)
abline(a=-120, b=10)
abline(a=-75,b=7)

mylm = lm(harvest ~ rain)
#Coefficients give us the a and b so we dont have to guess
View(mylm)









