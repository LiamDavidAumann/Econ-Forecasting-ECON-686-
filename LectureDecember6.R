library(tstools)
library(urca)
data("UKpppuip")

#DONT USUALLY DO THIS
attach(UKpppuip)

#UK price index
p1 <- ts(p1)

# World price index
p2 <- ts(p2)

#Multilateral exchange rate
e12 <- ts(e12)

plot(p1)
plot(p2)
plot(e12)

prices.uk <- p1*e12
#These two things should theoretically be equal if PPP holds

z <- p2 - prices.uk
# Z > 0 ==> Foreign prices are above equilibrium
# Foreign prices should rise
# UK prices should fall
# or both

duk <- diff(prices.uk)
dforeign <- diff(p2)

#VAR equation for UK prices
rhs <- lags(duk %~% dforeign, 1)
fit.uk <- tsreg(duk, rhs)
fit.uk


# Account for cointegration
rhs.ecm <- lags(duk %~% dforeign %~% z, 1)
uk.ecm <- tsreg(duk, rhs.ecm)
uk.ecm

foreign.ecm <- tsreg(dforeign, rhs.ecm)
foreign.ecm


#DON'T KNOW equilibrium
oil <- import.fred("oilprice.csv")/42
gas <- import.fred("gasprice.csv")

fit <- tsreg(gas, oil)
fit

gas.star <- fit$fitted
plot(gas.star)

#Compare  equilibrium with actual gas price for 2022
gas.star.2022 <- window(gas.star, start = c(2022,1))
gas.actual.2022 <- window(gas, start = c(2022,1))
plot(gas.star.2022 %~% gas.actual.2022,
     plot.type="single")
