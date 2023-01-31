library(tstools)
inf <- read.csv("https://raw.githubusercontent.com/bachmeil/econ-686-fall-2022/main/inflation.csv", header=TRUE)
inf <- ts(inf[, "CPIAUCSL_PC1"], start = c(1948, 1), frequency = 12)

#common notation is to put a "d" in front of the variable for differencing

#FIRST DIFFERENCE:
dinf <- inf - lags(inf, 1)
plot(dinf)

#LOG DIFFERENCING
data.raw <- read.csv("https://raw.githubusercontent.com/bachmeil/econ-686-fall-2022/main/gdpc1.csv", header = TRUE)
gdp <- ts(data.raw[,2], start = c(1947,1), frequency = 4)

#gdp <- import.fred("gdpc1.csv")
dgdp <- pctChange(gdp)
plot(dgdp)
gdp.diff <- gdp - lags(gdp, 1)
plot(window(gdp.diff, end=c(2007,4)))
log(5)-log(4)
5/4 - 1

#SEASONAL DIFFERENCE
dgdp.seasonal <- gdp - lags(gdp, 4)
#gdp is quarterly data so lags at 4 provides a year-over-year comparison
dgdp.seasonal2 <- pctChange(gdp, 4)
plot(dgdp.seasonal)
plot(dgdp.seasonal2)

#BASIC FORM OF THE UNIT ROOT TEST
#Dickey-Fuller Test
fit <- tsreg(gdp, lags(gdp,1))
fit

#Dickey-Fuller (DF) statistic
#t-statistic
#Get standard error and betahat
summary(fit)
betahat <- 1.003389
se <- .001547

(betahat-1)/se
#Not less than the critical value of -2.89 so don't reject
#Conclude GDP has a unit root
#Should take the percentage change

#REDO WITH INFLATION
fit <- tsreg(inf,lags(inf,1))
summary(fit)
betahati <- .986704
sei <- .005153

(betahati-1)/sei
#Dont reject because it is not less than -2.89
#TAKE FIRST DIFFERENCE
