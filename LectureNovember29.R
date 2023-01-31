library(tstools)

data.raw <- read.csv("https://raw.githubusercontent.com/bachmeil/econ-686-fall-2022/main/gdpc1.csv", header = TRUE)
gdp <- ts(data.raw[,2], start = c(1947,1), frequency = 4)

#RANDOM WALK WITH DRIFT
# the usual AR(1) regression

fit <- tsreg(gdp, lags(gdp,1))
summary(fit)
# Coefficient slightly above one
# Cannot conclude beta < 1
# Critical value -2.89
(1.003389 - 1)/0.001547
#Positive so not less than -2.89
#Conclude there IS a unit root

#PURE RANDOM WALK MODEL:
fit2 <- tsreg(gdp, lags(gdp,1), intercept = FALSE)
summary(fit2)

(1.0057007-1)/0.0007952
#Critical value is -1.95
#Conclude unit root exists
#Do DIFFERENCE


#RANDOM WALK WITH DRIFT AND TREND
tr <- make.trend(gdp)
fit3 <- tsreg(gdp, lags(gdp,1) %~% tr)
summary(fit3)

(.985296-1)/.008396
#negative but still greater than -3.45
# Critical value -3.45

#All 3 gave a unit root so we should difference the data.

#AUGMENTED DICKEY-FULLER
library(urca)
#Pure Random Walk
gdp.adf <- ur.df(y=gdp, type = "none", selectlags = 'AIC')
summary(gdp.adf)
#7.6 > -1.95
#Conclude unit root

gdp.adf <- ur.df(y=gdp, type = "drift", selectlags = 'AIC')
summary(gdp.adf)
#2.56 > -2.87
#Conclude unit root

gdp.adf <- ur.df(y=gdp, type = "trend", selectlags = 'AIC')
summary(gdp.adf)
#-1.624 > -3.42
#Conclude unit root
#We always found a unit roots
#So we difference real GDP
#Take percentage change

gdp.adf <- ur.df(y=gdp, type = "none", selectlags = 'BIC')
summary(gdp.adf)


#If you know the lag length
gdp.adf <- ur.df(y=gdp, type = "trend", selectlags = 'Fixed', lags=3)
summary(gdp.adf)


