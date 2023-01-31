library(tstools)
gdp <- import.fred("gdpc1.csv")
trend <- make.trend(gdp)
dum <- quarter.dummy(gdp)
predictors <- ts.combine(trend, dum)
# Provide names so we can interpret the output
colnames(predictors) <- c("trend", "Q1", "Q2", "Q3")
stepwise.selection(gdp, predictors, BIC)
tsreg(gdp, predictors)
curve(sin, from=0, to=2*pi)
curve(cos, from=0, to=2*pi)



autos <- import.fred("autos-domestic.csv")
trend <- make.trend(autos)
dum <- month.dummy(autos)
rhs <- ts.combine(trend, dum)
fitb <- tsreg(autos, rhs)
fitb
# Detrended and deseasonalized
autos.dt <- fitb$resids


# Use old values to forecast the future
fit1 <- tsreg(autos.dt, lags(autos.dt,1))
fit1
last(autos.dt)
# Forecast September 2022
-0.00073 + 0.84*(-1.92)
# Now add back in the seasonal and time trend components
# Trend = 669 and September dummy
8.997 - 0.007788*669 + 0.21
# Predict about 4 million/year based on time trend and seasonal
# Cyclical contributes -1.61 million/year
3.997 - 1.61
# Forecast about 2.4 million taking into account
# Trend, seasonal, and cyclical (based on Aug 2022)
# ARMA forecasting
# Good baseline for planning purposes
fit <- tsreg(autos.dt, lags(autos.dt,1:3))
fit
last(autos.dt,3)
# Forecast of cyclical component with three lags
0.0004861 + 0.68*(-1.92) - 0.034*(-1.72) + 0.25*(-1.71)
# Similar to the forecast with only one lag
# Model selection: No choice but to choose a lag length
# Autoregressive (AR) model
# But what lag order?
# AR(1) AR(3)
# Use AIC or BIC
# One year plus one observation
ar1 <- tsreg(autos.dt, lags(autos.dt,1))
ar2 <- tsreg(autos.dt, lags(autos.dt,1:2))
ar3 <- tsreg(autos.dt, lags(autos.dt,1:3))
BIC(ar1)
BIC(ar2)
BIC(ar3)