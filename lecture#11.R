library(tstools)
#autos <- import.fred("autos-domestic.csv")


autos <- read.csv("https://raw.githubusercontent.com/LiamDavidAumann/Econ-Forecasting-ECON-686-/main/DAUTOSA.csv", header = TRUE)
autosts <- ts(autos[ , "DAUTOSA"], start = c(1967, 1), frequency = 12)

dautos <- pctChange(autosts, 12)


#Estimate AR(p)
#Use AIC to choose p

one.aic <- function(p) {
  fit <- tsreg(dautos, lags(dautos, 1:p))
  return(AIC(fit))
}

one.aic(1)
one.aic(2)
#1:13 is vector notation with 1 2 3 ... 13
#takes each element 1-13 and passes it through the argument
lapply(1:13, one.aic)
#lag 13 gives lowest AIC model
#so use AR(13)

fit <- tsreg(dautos, lags(dautos, 1:13))
fit
#predicting september 2022

last(dautos,13)
#Can we automate the prediction
coef(fit)
as.numeric(last(dautos,13))


#We need to match the coefficients

#Drop intercepts
betas <-coef(fit)[-1]
#Reverse data so most recent is first
old.data <- rev(as.numeric(last(dautos,13)))
#Element by element multiplication
sum(betas * old.data) - 0.09

fcst <- function(betas, olddata, intercept) {
  return(sum(betas*rev(olddata))+intercept)
}

fcst(coef(fit)[-1], last(dautos,13), -0.09)






