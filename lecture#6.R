library(tstools)

data.raw <- read.csv("https://raw.githubusercontent.com/bachmeil/econ-686-fall-2022/main/gdpc1.csv", header = TRUE)
rgdp <- ts(data.raw[,2], start = c(1947,1), frequency = 4)

plot(rgdp)

#TSTOOLS
rgdp.trend <- make.trend(rgdp)
rgdp.trend

#Remember when we are regressing time trends we have to ensure it maintains that type
fit <- tsreg(rgdp, rgdp.trend)
fit
#Fitted value approach
length(rgdp)
#Yt = a +bt
#in this case
#Yt = -180.95 +60.8t
#302 observations
#Predict observation 303: Q3 2022

-180.95 + 60.81*303 #trillion $18.2

last(rgdp) #19.7 trillion???

#Our forecast is bad
#Can we account for recent information?!?!?!?!!?!!?!?!?!?!??!?!!??!?!?!?!??!
#Just add 60.8 billion to Q2 2022?

#End of sample approach 
19700 + 60.8

#What about Q2 2027
19700+20*60.8 #20.9 trillion

#lay fitted model over raw data
#ts.combine groups/lays severel time series (matches dates etc.)
plot.data <- ts.combine(fit$fitted.values, rgdp)
#fit$fitted.values calculates prediction for every data point in our sample
#REMEBER TO USE LTY
plot(plot.data, plot.type = 'single', lty=c(2,1))
#this shows how awful out fit at the end is (it only is close to predicting during the pandemic)

plot(rgdp)

rgdp1 <- window(rgdp, end= c(1982,4))
rgdp2 <- window(rgdp, start = c(1983,1))

plot(rgdp1)
plot(rgdp2)
#Fit for rgdp1
tt1 <- make.trend(rgdp1)
fit1 <- tsreg(rgdp1, tt1)
fit1

#Fit for rgdp2
tt2 <- make.trend(rgdp2)
fit2 <- tsreg(rgdp2, tt2)
fit2

#ts.union keeps missing observations
plot2.data <- ts.union(rgdp, fit1$fitted.values, fit2$fitted.values)
#View(plot2.data)
plot(plot2.data, plot.type = 'single', lty=c(1,2,3))
