library(tstools)

gdp <- read.csv("https://raw.githubusercontent.com/bachmeil/econ-686-fall-2022/main/gdpc1.csv", header = TRUE)
gdpts <- ts(gdp[, "GDPC1"], start = c(1948, 1), frequency = 12)
plot(gdpts)

gdp.trend <- make.trend(gdpts)

tsreg(gdpts, gdp.trend, end = c(1982,4))

tsreg(gdpts, gdp.trend, start=c(1983,1))

#squared
gdp.trend2 = gdp.trend^2
rhs <- ts.combine(gdp.trend, gdp.trend2)
rhs

tsreg(gdpts, rhs)
#Rember even with the squared coefficients being small its average is much larger
mean(gdp.trend)
mean(gdp.trend2)

#cubed
trends <- make.trend(gdpts, 3)
trends

tsreg(gdpts, trends)
mean(trends[,3])

#Forecasting
#Fitted Values

trend.fitted <- 2314 + (3.126 * gdp.trend) + (.2741 *(gdp.trend^2)) + (-0.0003073*(gdp.trend^3))

plot(trend.fitted)

last(gdp.trend)


#Forecast
2314 + (3.126 * 303) + (.2741 *(303^2)) + (-0.0003073*(303^3))
last(gdp)

#See how it changes for 302
2314 + (3.126 * 302) + (.2741 *(302^2)) + (-0.0003073*(302^3))
#trend changes by
19877.51 - 19792.92
#increases by 84.59
last(gdp)
#Forecast: last + our other number
19699.485 +84.59

#Estimate all three models
#Compute AIC for each
linear <- tsreg(gdpts, gdp.trend)
quadratic <- tsreg(gdpts, make.trend(gdpts,2))
cubic <- tsreg(gdpts, make.trend(gdpts,3))

AIC(linear)
AIC(quadratic)
AIC(cubic)
#AKA SIC SBC
BIC(linear)
BIC(quadratic)
BIC(cubic)


