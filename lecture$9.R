library(tstools)
autos <- read.csv("https://raw.githubusercontent.com/LiamDavidAumann/Econ-Forecasting-ECON-686-/main/DAUTOSA.csv", header = TRUE)
autosts <- ts(autos[ , "DAUTOSA"], start = c(1967, 1), frequency = 12)

#Setup Dummy variable
#Common to use January as beta1
dum <- month.dummy(autosts, "Jan")
dum
#Then regress dummy object
fit <- tsreg(autosts, dum)
fit
#Checking work
mean(one.month(autosts,1))
mean(one.month(autosts,2))

#With only sasonal dummies, returns the average for each month
#Detrend and deseasonalize the autos series

rhs <- ts.combine(make.trend(autosts),dum)
#Dont combine polynomial time trend and seasonal dummies!

fit <- tsreg(autosts, rhs)
fit

autos.filtered <- fit$resids
plot(autos.filtered, main="Detrended/Deseasonalized auto sales")

#Upward model selection
gdp <- read.csv("https://raw.githubusercontent.com/bachmeil/econ-686-fall-2022/main/gdpc1.csv", header = TRUE)
gdpts <- ts(gdp[, "GDPC1"], start = c(1948, 1), frequency = 12)

trend <- make.trend(gdpts)
dumGDP <- quarter.dummy(gdpts, omit = 4)



#Step 1 estimate 
fit1 <- tsreg(gdpts, trend)
fit2 <- tsreg(gdpts, dum[, "Q1"])
fit3 <- tsreg(gdpts, dum[, "Q2"])
fit4 <- tsreg(gdpts, dum[, "Q3"])
AIC(fit1)

#Model 1 is the foundation for step 2
fit5 <- tsreg(gdpts, ts.combine(trend, dum[, "Q1"]))
fit6 <- tsreg(gdp, ts.combine(trend, dum[, "Q2"]))
fit7 <- tsreg(gdp, ts.combine(trend, dum[, "Q3"]))
AIC(fit7)
#Step 3
fit8 <- tsreg(gdp, ts.combine(trend, dum[, c("Q1","Q2")]))
fit9 <- tsreg(gdp, ts.combine(trend, dum[, c("Q1","Q3")]))

#Step 4
fit10 <- tsreg(gdpts, ts.combine(trend, dum))

# Model 1 is the best
# Include only linear time trend





















