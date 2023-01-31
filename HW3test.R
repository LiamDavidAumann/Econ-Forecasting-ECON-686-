library(tstools)
dataset.csv = read.csv("https://raw.githubusercontent.com/LiamDavidAumann/Econ-Forecasting-ECON-686-/main/constructionnotadjusted.csv", header = TRUE)
names(dataset.csv) = c("Date", "AmountSpent")

construct <- ts(dataset.csv[, "AmountSpent"], start = c(1993, 1), frequency = 12)

dum_con <- month.dummy(construct, "Jan")
dum_con
trend <- make.trend(construct)
rhs <- ts.combine(trend, dum_con)
fit_init <- tsreg(construct, rhs)

construct.dt <- fit_init$resids

fit_init
last(dataset)
#357

28085.8+222.8*(357)+21705.7


#Deleted code:
#fit_next <- tsreg(construct.dt, lags(construct.dt,1:13))

#cyc.dt <- fit_next$resids

#one.aic <- function(p) {
#  fit_test <- tsreg(construct.dt, lags(construct.dt,1:13))
#   return(AIC(fit_test))
#}

#lapply(1:13, one.aic)

#Throwing out Feb, Mar, Apr, May, Nov, and Dec as they seem to be too low to make a difference
#Model fit downward
#Step 1
fitLargest <- tsreg(construct, ts.combine(trend, dum_con))
AIC(fitLargest)

#Step 2
fit1 <- tsreg(construct, ts.combine(trend, dum_con[, c("Jun","Jul","Aug","Sep")]))
fit2 <- tsreg(construct, ts.combine(trend, dum_con[, c("Jun","Jul","Aug","Oct")]))
fit3 <- tsreg(construct, ts.combine(trend, dum_con[, c("Jun","Jul","Sep","Oct")]))
fit4 <- tsreg(construct, ts.combine(trend, dum_con[, c("Jun","Aug","Sep","Oct")]))
fit5 <- tsreg(construct, ts.combine(trend, dum_con[, c("Jul","Aug","Sep","Oct")]))

AIC(fit1)
AIC(fit2)
AIC(fit3)
AIC(fit4)
AIC(fit2)

#fit 1 the best throw out October
#step 3
fits21 <- tsreg(construct, ts.combine(trend, dum_con[, c("Jun","Jul","Aug")]))
fits22 <- tsreg(construct, ts.combine(trend, dum_con[, c("Jun","Jul","Sep")]))
fits23 <- tsreg(construct, ts.combine(trend, dum_con[, c("Jun","Aug","Sep")]))
fits24 <- tsreg(construct, ts.combine(trend, dum_con[, c("Jul","Aug","Sep")]))

AIC(fits21)
AIC(fits22)
AIC(fits23)
AIC(fits24)

#fits21 best throw out Sep
#step 4
fits31 <- tsreg(construct, ts.combine(trend, dum_con[, c("Jun","Jul")]))
fits32 <- tsreg(construct, ts.combine(trend, dum_con[, c("Jun","Aug")]))
fits33 <- tsreg(construct, ts.combine(trend, dum_con[, c("Jul","Aug")]))

AIC(fits31)
AIC(fits32)
AIC(fits33)

#fits33 the best throw out June
#step 5
fits41 <- tsreg(construct, ts.combine(trend, dum_con[, c("Jul")]))
fits42 <- tsreg(construct, ts.combine(trend, dum_con[, c("Aug")]))

AIC(fits41)
AIC(fits42)

#fits42 best throw out july
#Step 7
fit6 <- tsreg(construct, trend)
AIC(fit6)

#Possible ones:
#fit 6, fits42, fits33, fits21, fit1 and fitlargest

AIC(fit6)
AIC(fits42)
AIC(fits33)
AIC(fits21)
AIC(fit1)
AIC(fitLargest)

#fit1 is the best