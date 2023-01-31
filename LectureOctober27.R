rgdp <- c(31447, 33181, 30505, 33615,34319)
labels <- c("France", "Germany", "Italy", "Spain", "UK")
#Matches first value with first label, etc.
pie(rgdp, labels=labels, main="Real GDP Per Capita, 2007")
labels2 <- c("France (31447)", "Germany (33181)", "Italy (30505)", "Spain(33615)", "UK (34319)")
pie(rgdp, labels=labels2, main="Real GDP Per Capita, 2007")

#Make Table
#See Rmarkdown corresponding to this lecture

#Stacked Bar Chart - don't do this
dat <- read.table(text = "2018 2019 2020 2021 2022
70 68 65 62 60
30 32 35 38 40", header = TRUE)

barplot(as.matrix(dat), main="Market Share Over Time")


#X-Y Plot
plot(cars)
plot(cars$dist,cars$speed)
lm(cars$dist~cars$speed)

#Title
plot(cars, main="Relationship Between Car Speed and Distance to Full Stop")
abline(a=-17.579, b=3.932)

#Sub Title
plot(cars, main="Relationship Between Car Speed and Distance to Full Stop", sub="Source: Ezekiel (1930)")
abline(a=-17.579, b=3.932)

#Remove one or both of the axis
plot(cars, main="Relationship Between Car Speed and Distance to Full Stop", 
     sub="Source: Ezekiel (1930)",
     yaxt="n"
    )

#Remove Label
plot(cars, main="Relationship Between Car Speed and Distance to Full Stop", 
     sub="Source: Ezekiel (1930)",
     yaxt="n",
     ylab=""
)

library(tstools)
dom <- import.fred("autos-domestic.csv")
plot(dom)
#Year over year change
#No seasonal componenet due to comparing to each month exactly
#No trend either due to this
growth.dom <- pctChange(dom, 12)
growth.recent <- window(growth.dom, start=c(2020,1))

#Use window() to get recent data
plot(growth.recent)
#Labels make no sense, 2021.5 could mean may or june to some people
#In reality 2021.5 means july

#Make it more readable
#Get rid of bad dates

time(growth.recent)
#see how bad that is?

#Do this
clearDates(time(growth.recent))

#Make a plot with a better x-axis
#Get rid of xlab and xaxis names
plot(growth.recent, xaxt="n", xlab="")

#Create new x-axis
#Perhaps label every fourth obs?
length(growth.recent)
index <- seq(1, 32, by=4)
index

#Decimal part
#Use the time value original but only grab the indexed ones
label.location <- time(growth.recent)[index]

#String part
label.values <- clearDates(label.location)

#Add to the axis with: axis()
#At is where we want the data (Decimal part)
#Labels is what we want to name it
axis(1, at=label.location, labels = label.values)

#What if we want the dates perpendicular?
axis(1, at=label.location, labels = label.values,
     las=2)

#Now add title
plot(growth.recent, main="Year-Over-Year Domestic Auto Sales Growth (%)",
     xaxt="n", xlab="")
axis(1, at=label.location, labels = label.values,
     las=2)

#Bigger line width?:
plot(growth.recent, main="Year-Over-Year Domestic Auto Sales Growth (%)",
     xaxt="n", xlab="",
     lwd=1.4)
axis(1, at=label.location, labels = label.values,
     las=2)

#Remove y-lab (a good title should say what this is)
plot(growth.recent, main="Year-Over-Year Domestic Auto Sales Growth (%)",
     xaxt="n", xlab="",
     lwd=1.4,
     ylab="")
axis(1, at=label.location, labels = label.values,
     las=2)



#Add a forecast
#Pretend we already made the forecast and got the values:
fcst <- ts(c(last(growth.recent),-.05, -.04, -.03, -.02),
           start=c(2022,9), frequency = 12)

growth.forecastadded <- ts(c(growth.recent, fcst), 
                           start = c(2020, 1), 
                           frequency = 12)

plot(growth.forecastadded)

#Make a dashed line for forecasted values
# Hack: Plot two lines that show up as one
combined <- ts.union(growth.recent, fcst)
#cant use ts.combine() here
plot(combined, lty=c(1,2), plot.type="single")
#Get rid of that gap?!?!?!?!?!?!!?
#Add the last data point to your forecasted series 
#This will be done at the fcst variable


