#EXAMPLE 1

#M: num of dogs that were waste
#F: num of dogs too few
#50 cents lost per wasted dog
#$1.5 lost profit for each too little dogs
vendor.loss <- function(M,F) {
  M*0.5 + F*1.5
}
#perfect forecast
vendor.loss(0,0)
vendor.loss(100,0)
vendor.loss(0,100)

#EXAMPLE 2

#s: total sales
vendor2.loss <- function(s) {
  if(s < 5000) {
    #say infinite loss for failing to repay the loan
    return(Inf)
  } else {
    return(5000-s)
  }
}

#we want a negative loss (negative loss is a gain)
vendor2.loss(5001)
vendor2.loss(1500)
vendor2.loss(4999)
vendor2.loss(2837492837498274)

#EXAMPLE 3
#s: actual sales
#f: forecasted sales
vendor3.loss <- function(s, f) {
  #quadratic loss
  (s-f)^2
}
#penalizes big errors more

vendor3.loss(100, 100)
vendor3.loss(100,120)
vendor3.loss(100,80)

#DATA STRUCTURES:
#1) Vector:
v = c(1,2,3,4,5)
v[1]
#num observations
length(v)
#slicing
v[1:4]

mean(v)
v[4] <- 12
#scalar
v = 1.5*v

#Matrix

m <- matrix(1:9,ncol=3)
n <- matrix(11:19,ncol=3)
c = m*n

is.vector(m[1:3])
is.matrix(m[1:3])

#list
#m is monthly data starting Jan 2010
ll <- list(m,12,c(2010,1))

names(ll) <- c("m", "frequency", "start")
ll

ll$m











