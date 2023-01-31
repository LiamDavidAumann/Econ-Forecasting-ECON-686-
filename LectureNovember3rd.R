library(tstools)
#Read in CSV data
#Doesn't know anything about ts properties, just reads in comma deliniated data points
st <- read.csv("salestax.csv")
st
class(st[,2])

#In luck, its reading as numbers

#STEPS:
#Stack the data so 1983 is first then 1984 below... etc till the end.
#Remove first and last columns
#Then reshape to a vector
#Then give its properties
#Drop missing observations if needed

dim(st)
#Need columns 2-33
class(st[, 2:33])
#Data frame prints like a matrix, but it is not a matrix
#Its a list with the same number of observations

#To fix this use: as.matrix()

st.mat <- as.matrix(st[, 2:33])
st.mat

#Now stack the columns
m <- matrix(1:9, ncol=3)
m

as.vector(m)

#as.vector stacks matrix elements into a vector by column

t(m)
as.vector(t(m))

st.vector <- as.vector(st.mat)
st.vector
# Definitely want to confirm it did things correctly
st.data <- ts(st.vector, start = c(1983,1), frequency = 12)
st.data
plot(st.data)

#Always plot the data
#We see the last two values are missing

#Chopping data
#First 
drop_first(1:9, 2)
drop_last(1:9,3)

#Get rid of the two missing values

salestax <- drop_last(st.data, 2)
salestax
plot(salestax)

attr(salestax, "raw data source") <- "salestax.txt from George Smith's email to Liam Aumann 2124 November 32nd"
attr(salestax, "data cleaned by") <- "Liam Aumann"
saveRDS(salestax, "salestax.RDS")

rm(salestax)
salestax

salestax <- readRDS("salestax.RDS")
salestax
plot(salestax)
attributes(salestax)


#Floating Point Precision
1.34 == 1.34
1.24 == 1.19+.05

1.324 ==1.319+.005
1.319+.005
#how is it false? 1.319+.005 = 1.324?!
#This shows how representation of numbers is important
#The 1.324 is an approximation of what is inside the computer

all.equal(1.324, 1.319+.005)

#Doesn't always work
a<- 1000000000000000
all.equal(a*1.324, a*(1.319+.005))

pop65 <- import.fred("population-65-plus.csv")
popwa <- import.fred("population-wa.csv")
college <- import.fred("lf-college.csv")


number65 <- (pop65/100)
college.pct <- 1000*college/popwa

plot(college.pct)
#Did this work correctly?
ts.obs(college.pct)
#TEST CASE
all.equal(as.numeric(tsobs(college.pct, c(2000,1))), 23625*1000/178282552.324166,
          check.attributes=FALSE)
#Set it up like this for the first, last, and then two random observations in the middle





