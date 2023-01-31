data <- data[c(2,3,4,8,9,10,11,12,16)]
data1 <- ts(data,start=c(1968,4),frequency=4)
rgdp <- data1[,1]
coninf <- data1[,2]
spfinf <- data1[,3]
oil <- log(data1[,4])
ffr <- data1[,5]
tb <- data1[,6]
def <- data1[,7]
spfgdp <- data1[,8]
cpi <- data1[,9]
dinfexp <- def-spfinf
dgdp_exp <- rgdp-spfgdp
dcpiexp <- cpi -coninf
doil <- oil-lag(oil,-1)
dffr <- ffr-lag(ffr,-1)
