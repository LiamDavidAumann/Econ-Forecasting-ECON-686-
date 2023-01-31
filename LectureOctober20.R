library(tstools)
inf <- read.csv("https://raw.githubusercontent.com/bachmeil/econ-686-fall-2022/main/inflation.csv", header=TRUE)
inf <- ts(inf[, "CPIAUCSL_PC1"], start = c(1948, 1), frequency = 12)
wapop <- import.fred("population-wa.csv")
growth.wa <- pctChange(wapop)


#Direct Estimation (h-step ahead projection)
#1-step model
fit1 <- tsreg(inf, lags(inf %~% growth.wa, 1))
fit1
last(inf)
last(growth.wa)
fit1$end
0.02538 + 0.99078*8.48 + 15.71342*0.00005097

# 2-step model
fit2 <- tsreg(inf, lags(inf %~% growth.wa, 2))
fit2

#Forecast inf(T+2), Sep 2022
0.08633 + 0.97329 *8.48 + 24.18716*0.00005097 

#How many lags?
#Use the 1-step model to select lag length
#VAR(1), VAR(2), VAR(3)
#Calculate AIC()/SIC() for each
#Use the lag length with lowest
#VARselect
#6 lags is best
#3-step model
#tsreg(inf, lags(inf %~% growth.wa, 3:8))

ffr <- import.fred("ffr.csv")
plot(ffr)

rhs <- lags(inf %~% ffr, 1)
fit.inf <- tsreg(inf,rhs)
fit.ffr <- tsreg(ffr,rhs)
fit.inf
fit.ffr

#1 Step inflation forecast
last(inf) #=8.48
tsobs(ffr, c(2022,7)) #=1.68

0.033008 + 0.988256*8.48 +0.004078*1.68

#August inflation forecast = 8.42
#Use this info to make a 2-step forecast (sept2022)
#Using the 3% we are pretending to raise to
0.033008 + 0.988256*8.42 +0.004078*3

#3-step (oct 2022)
0.033008 + 0.988256*8.37 +0.004078*3
#Forecasts conditional on 3% FFR: 8.42, 8.37, 8.32

#We are assuming a value for the FFR because we are the fed and we choose it
#Doing "what if" analysis

#Now do "What-if" 4% scario

#Use this info to make a 2-step forecast (sept2022)
0.033008 + 0.988256*8.42 +0.004078*4

#3-step (oct 2022)
0.033008 + 0.988256*8.37 +0.004078*4
#Forecasts conditional on 4% FFR: 8.42, 8.37, 8.32

# And FFR=5%
0.033008 + 0.988256*8.42 +0.004078*5

#3-step (oct 2022)
0.033008 + 0.988256*8.37 +0.004078*5
#Forecasts conditional on 3% FFR: 8.42, 8.37, 8.33

tsobs(u , c(2022,9))
u <- import.fred("unrate.csv")
rhs <- lags(inf %~% u,1)
fit.inf2 <- tsreg(inf, rhs)
fit.inf2
0.11943 + 0.98722*8.48 - 0.01333*3.5  

#This doesn't adjust inflation for the changes in the economy that deliver
#different unemplotment rates
#Thus: Scario analysis is unhelpful










