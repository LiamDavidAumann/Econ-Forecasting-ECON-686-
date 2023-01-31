inf <- read.csv("https://raw.githubusercontent.com/bachmeil/econ-686-fall-2022/main/inflation.csv", header=TRUE)
inf <- ts(inf[, "CPIAUCSL_PC1"], start = c(1948, 1), frequency = 12)
u <- import.fred("unrate.csv")

#Estimate the ar model

fit.ar <- make.trend(inf, lags(inf,1))
fit.ar
#Write a function to calculate forecasts for you
#0.0446 + 0.9867*x is drawn from the fit.ar

arfcst <- function(x) {
  fcst <- 0.0446 + 0.9867*x
  return(fcst)
}

arfcst(3.2)

#Quality of the forecast
#Define by squared forecast error

#Creating estimation sample using data through 2018
inf.est <- window(inf,end=c(2018,12))
u.est <- window(u, end=c(2018,12))

fit.var <- tsreg(inf.est,lags(inf.est %~% u.est, 1))
fit.var

varfsct <- function(x) {
  inf.lag <- x[1]
  u.lag <- x[2]
  fcst <- 0.13127 + 0.98623*inf.lag - 0.01608*u.lag
  return(fcst)
}

varfsct(c(4.8, 6.2))

#ABOVE IS ESTIMATION
#BELOW IS VALIDATION

#get lags first
#combine the data
#then seperate the validation from the rest of the data
validation <- window(lags(inf %~% u, 1), start = c(2019,1))

#apply: operate on rows or columns of a matrix
#MARGIN = 1 means for rows
#MARGIN = 2 means for columns

forecasts.var <- apply(validation, MARGIN = 1, varfsct)

#FIX THIS ERROR
forecasts.ar <- apply(as.matrix(validation[,"inf.1"]), MARGIN = 1, arfcst)

inflation.actual <- window(inf, start=c(2019,1))
length(inflation.actual)

#Calculate the mean squared forecast errors
#larger is worse

mse.var <- mean((inflation.actual - ts(forecasts.var, frequency = 12, start = c(2019,1)))^2)
mse.var
#fix error to get real result
mse.ar <- mean((inflation.actual - ts(forecasts.ar, frequency = 12, start = c(2019,1)))^2)


#AR model predicts better outperforms the Phillips curve 
#Unemployment rate does not have predictive ability for
#inflation after 2019 because the var model doesn't predict better
#Alternative: unemployment does not Granger cause inflation

