cubic.trend <- function(obs) {
  return(48.8 - 41.7*obs + 24.05*(obs^2) - 3.65*(obs^3))
}

cubic.trend(1)
cubic.trend(2)
cubic.trend(3)
cubic.trend(4)
cubic.trend(5)
cubic.trend(6)

#Out of sample validation

#Loaded in GDP data from lecture#7
gdp <- read.csv("https://raw.githubusercontent.com/bachmeil/econ-686-fall-2022/main/gdpc1.csv", header = TRUE)
gdpts <- ts(gdp[, "GDPC1"], start = c(1947, 1), frequency = 4)
trends <- make.trend(gdpts, 3)
#Estimate cubic trend model
tsreg(gdpts, trends)
#Get last sample
end(gdpts)

# Estimate cubic trend model through 2021 Q4
tsreg(gdpts, trends, end=c(2021,4))
#Predicting 2022 Q1 and 2022 Q2
#Predicting obs 301 and 302
#coefficiants here multiplied by the obs we are predicting
2.313+3.18*301+.2736*(301^2)-.0003059*(301^3)
#301 is Q1 2022 so we can see how good our model is based on results we already have

#Linear time trend on recent OBS
wapop <- read.csv("https://raw.githubusercontent.com/LiamDavidAumann/Econ-Forecasting-ECON-686-/main/WAPOP.csv", header = TRUE)
frequency(wapop)
wapopts <- ts(wapop[, "WAPOP"], start = c())

#Why would we have a change in the trend?
#Real GDP grows 3% a year
#Starts at 100

100*(1.03^20)
100*(1.03^40)
100*(1.03^60)
100*(1.03^80)
100*(1.03^100)
1921-1064
180-100
#Much larger base at the end for technology to increase
log(100*(1.03^20))
log(100*(1.03^40))
log(100*(1.03^60))
log(100*(1.03^80))
log(100*(1.03^100))
7.56-6.97
5.79-5.20

plot(gdpts)
plot(log(gdpts))
#SolutionL take the log of the variable as opposed to the variable itself

#Detrend the GDP series 
fit <- tsreg(gdpts, trends)

plot(fit$fitted.values)
bc <- gdpts - fit$fitted.values
plot(bc)
plot(fit$resids)
#Detrending: get the residuals of a time trend model

#Seasonality
autos <- read.csv("https://raw.githubusercontent.com/LiamDavidAumann/Econ-Forecasting-ECON-686-/main/DAUTOSA.csv", header = TRUE)
autosts <- ts(autos[ , "DAUTOSA"], start = c(1961, 1), frequency = 12)

autos17 <- window(autosts, start = c(2017, 1), end = c(2018, 1))


