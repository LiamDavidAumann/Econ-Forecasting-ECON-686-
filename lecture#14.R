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

#Approach one to combine AR and MA
arima1.1 <- arima(autos.dt, order=c(1,0,1))
arima1.1
#One drawback of this approach is it predicts from the mean (don't get the model)

#Predicts end of year
predict(arima1.1,n.ahead=4)
#Draws just the predictions
predict(arima1.1,n.ahead=4)$pred

#Can use an alternative function from tstools to get the model
#AR lags come first, then MA lags
fit1.1 <- armafit(autos.dt,1,1)
#Get the model coefficients
#This code spits out the model
fit1.1$par
#This code predicts
predict(fit1.1, n.ahead=4)$pred

#Selecting lag length (AR and MA terms jointly)
s <- arma.select(autos.dt, ar=1:3, ma=1:3)
#You can print all the output:
s
#Or get the best by:
s$best
#Best with my data is ARMA(1,2)
#Prof was ARMA(2,3)

fit2.3 <- armafit(autos.dt, ar=1, ma=2)
#Again this gives the model
fit2.3
#This predicts
predict(fit2.3, n.ahead=4)$pred
#These are the predictions that the AIC model chose as the best



#Multivariate
#ARX
# domestic <- import.fred("autos-domestic.csv")
# foregin <- import.fred("autos-foreign.csv")
domestic <- read.csv("https://raw.githubusercontent.com/LiamDavidAumann/Econ-Forecasting-ECON-686-/main/DAUTOSA.csv", header = TRUE)
foreign <- read.csv("https://raw.githubusercontent.com/LiamDavidAumann/Econ-Forecasting-ECON-686-/main/foriegnauto.csv", header = TRUE)
domestic <- ts(domestic[ , "DAUTOSA"], start = c(1967, 1), frequency = 12)
foreign <- ts(foreign[ , "FAUTOSAAR"], start = c(1967, 1), frequency = 12)

growth.dom <- pctChange(domestic)
growth.for <- pctChange(foreign)
rhs<- lags(growth.dom %~% growth.for, 1)

#Get domestic coeffiecients here
tsreg(growth.dom, rhs)

#Use the values of the last observation (not the obs number)
last(growth.dom)
last(growth.for)

#Profs values last(dom) = -.026
#last(For) = .126

#Domestic september pred
-0.00656-0.14651*(-.026)+.03559*(.126)

#Now forcast Oct 2022:

#Get foreign coeffiecients here
tsreg(growth.for, rhs)
#Prof coeffiecinets in notes

#Find the forecast growth for semptember 2022
#Then use that to forecast domestic growth for Oct 2022:

#Foreign september pred
-.003386-0.036490*(-0.026)-0.107316*(0.126)
#-.016 is the foreign growth prediction for sep 2022

#Now we can plug in to calculate October
-.00656 - 0.14651*(0.0017336)-0.03559*(-0.01595908)



#VARs package:
library(vars)

#Create vector of the data:
dataset <- ts.combine(growth.dom, growth.for)

#Estimate VAR(1) -> 1 lag of each varaible
varfit <- VAR(dataset, p=1)
varfit
pred <- predict(varfit, n.ahead=2)
#Just domestic growth predictions

#Next time show how to pull out the predicitons


