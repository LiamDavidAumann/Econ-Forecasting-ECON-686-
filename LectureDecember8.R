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
