library(tstools)
gdp <- read.csv("https://raw.githubusercontent.com/bachmeil/econ-686-fall-2022/main/gdpc1.csv", header = TRUE)
gdpts <- ts(gdp[, "GDPC1"], start = c(1948, 1), frequency = 4)

trend <- make.trend(gdpts)
dum <- quarter.dummy(gdpts)
predictors <- ts.combine(trend, dum)
predictors
#Provide our own names
colnames(predictors) <- c("trend", "Q1", "Q2", "Q3")
stepwise.selection(gdpts, predictors, BIC())
tsreg(gdpts, predictors)


curve(sin, from = 0, to= 2*pi)
curve(cos, from = 0, to= 2*pi)

autos <- read.csv("https://raw.githubusercontent.com/LiamDavidAumann/Econ-Forecasting-ECON-686-/main/DAUTOSA.csv", header = TRUE)
autosts <- ts(autos[ , "DAUTOSA"], start = c(1967, 1), frequency = 12)

#Detrend/deseasonalize first
trend <- make.trend(autosts)
dum<-month.dummy(autosts)

rhs <- ts.combine(trend, dum)
fit <- tsreg(autosts, rhs)
fit
#Detrended data
autos.dt <- fit$resids
#Coveriance of lags
cov(lags(autos.dt, 0:1))
#Correlation
cor(lags(autos.dt, 0:1))
cor(lags(autos.dt, 0:6))

#Autocorrelation function
acf(autos.dt)
#Partial autocorrelation
pacf(autos.dt)

x <- ts(rnorm(500))
acf(x)

#If the data is like the auto series then youre all good
#If it is like x, then there is no hope

#Use old values to forecast the future
#Regresses against the first value 
fit <- tsreg(autos.dt, lags(autos.dt,1))
fit
last()
#My data is different try:
-0.00073+0.84*(-1.92)
#We have our number for spetember 2022 
#Now retrend and reseasonalize 
#Trend = 669 + and September dummy
8.997-.007788*669+ .21
#Predict about 4 million a year based on time trend and seasonal
#Cyclival contributes -1.61 million
3.997 - 1.61

#Forecast about 2.4 million taking into account
#Trend, seasonal and cyclical (Based on Aug 2022)
#ARMA forecast
#Good baseline for planning purposes

fit <- tsreg(autos.dt, lags(autos.dt,1:3))
fit
last(autos.dt,3)

#Forecast of cyclical component with three lags
0.0004861+0.68338*-1.92-0.034*-1.92+0.25*-1.92
#Similar to the forecast with only one lag
#Model selection: No choice but to choose a lag length
#Auto regressive model (AR)
#But what lag order? (how many number of lags)
#AR(1) AR(3) use AIC or BIC
#Rule of thumb: one year plus one observation should be the largest model to consider
ar1 <-tsreg(autos.dt, lags(autos.dt,1))
ar2 <-tsreg(autos.dt, lags(autos.dt,1:2))
ar3 <-tsreg(autos.dt, lags(autos.dt,1:3))
            
BIC(ar1)
BIC(ar2)
BIC(ar3)

            








