library(tstools)
library(vars)

domestic <- import.fred("autos-domestic.csv")
foreign <- import.fred("autos-foreign.csv")
growth.dom <- pctChange((domestic))
growth.for <- pctChange((foreign))
dataset <- ts.combine(growth.dom, growth.for)

# VAR(1)
varfit <- VAR(dataset, p=1)
#Estimated equations
varfit

#Forecast 2 steps after the sample ends (multistep)
pred <- predict(varfit, n.ahead=2)
pred

#Pull out only the forecast you want
#First argument is the VAR 
#Second is which of the multiple varaibles we want to forecast
#Forecasts default 1 step ahead
var.fcst(varfit, "growth.dom")

# 12 steps ahead
var.fcst(varfit, "growth.dom", 1:12)

#This wont work, will only give the 12th forecast, need the :
var.fcst(varfit, "growth.dom", 12)

#Dataset ends in Aug 2022
#This adds the time info
f <- var.fcst(varfit, "growth.dom", 1:12, c(2022, 9), c(2023,8))
plot(f)



#OPTION 3 TEST:
#CORRELATIONS
data1 <- growth.dom %~% lags(growth.for,1)
cor(data1)
#Correlation is -.03 at one month horizon
data1.1 <- growth.for %~% lags(growth.dom,1)
cor(data1.1)

data12 <- growth.dom %~% lags(growth.for,12)
cor(data12)


#Cross-Correlation Function (CCF)
ccf(growth.dom, growth.for)
#We care about moving to the right

#If you prefere the numbers as opposed to the plot
ccf(growth.dom, growth.for, plot=FALSE)


#Lag Length Selection
#Different form to account for the full system of equations
#That exists (AIC, SIC)
VARselect(dataset)
#Uses 10 lags maximum
#What if we wana use 13?
VARselect(dataset, lag.max=13)
#If you want this in a programmatic fashion
#This pulls out the best AIC
p.best <- VARselect(dataset, lag.max=13)$selection["AIC(n)"]
var.fit <- VAR(dataset, p=p.best)
var.fit


#Working age population growth and inflation
#Download inflation file
inf <- import.fred("inflation.csv")
wapop <- import.fred("population-wa.csv")

growth.wa<- pctChange(wapop)

arma.select(inf, ar=1:6, ma=1:6)
arma66 <- arima(inf, order = c(6,0,6))
arma.pred <- predict(arma66, n.ahead=12)$pred

dataset <- ts.combine(inf, growth.wa)
VARselect(dataset, lag.max=13)
varfit <- VAR(dataset, p=2)

var.pred <- var.fcst(varfit, "inf", 1:12, c(2022,8), c(2022,7))

ts.combine(arma.pred, var.pred)









