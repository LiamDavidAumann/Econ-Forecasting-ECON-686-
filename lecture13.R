#Estimating an MA model

library(tstools)
#autos <- import.fred("autos-domestic.csv")

#Remove trend and seasonal components
autos <- read.csv("https://raw.githubusercontent.com/LiamDavidAumann/Econ-Forecasting-ECON-686-/main/DAUTOSA.csv", header = TRUE)
autosts <- ts(autos[ , "DAUTOSA"], start = c(1967, 1), frequency = 12)

#trend <- make.trend(autos)
#dum <- quarter.dummy(autos)

trend <- make.trend(autosts)
dum <- quarter.dummy(autosts)
rhs <- ts.combine(trend,dum)

#regress and take the residuals
#fit <- tsreg(autos, rhs)
fit <- tsreg(autosts, rhs)

autos.dt <- fit$resids
#autos.dt is the autos series after removing the trend and seasonal component
#(cyclical component)


#arima estimates models with AR and MA components
#third element of order is MA lags (terms) 
ma1 <- arima(autos.dt, order = c(0,0,1))
ma1
#Professors results ma1: .6848 (not .7027) and .0222 not (.0278)
#intercept results -.0015 not (-.1689) and .0465 not (3.9947)

#How to get the August 2022 forecast error? (see notes for why we need this ex1.1)
#ITS THE LAST RESIDUAL

last(ma1$residuals)
#Professors reuls -1.136479 not (-54.98207)

#Sales came in quite low in August relative to forecast
#Downgrade our spetember forecast

.0648*(-1.14)

#Then add the mean in:
-.781-.0015

#Cyclical Forecast for sep2022
#Havent accounted for tend of seasonal terms

#Easier way:
predict(ma1, n.ahead=1)
#Professor results $pred: -.77986 (not -38.8)

#Forecast for the rest of the year (to december)
predict(ma1, n.ahead=4)

#MA(1) model says shocks after one period have no effect 
#This means anything more than one step ahead (here october november and december) the forecast is just the mean

#To change this estimate an MA(2) model (change the term on the order):
ma2 <- arima(autos.dt, order=c(0,0,2))

#See now it only forecasts the mean for november and december
predict(ma2, n.ahead=4)

#Lag length selection
#Modified from lecture #11
one.aic <- function(q) {
  fit <- arima(autos.dt, order=c(0,0,q))
  return(AIC(fit))
}
lapply(1:13, one.aic)
lapply(1:24, one.aic)

#Appears 13 is the best lag length so the best model is MA(13)
ma13 <- arima(autos.dt, order=c(0,0,13))
#Use this for predicting the cyclical component
predict(ma13, n.ahead=4)$pred
#Add back in seasonal/treand component to make final forecast



#Can estimate Ar models too
#Notice our order terms
ar4 <- arima(autos.dt, order = c(4,0,0))
predict(ar4, n.ahead=4)
#ar4 more pessimistic than MA


