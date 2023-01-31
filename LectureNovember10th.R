#Using sqlite within R
library(sqldf)
#Load data into R
sales1 <- read.csv("sales1.csv")
sales2 <- read.csv("sales2.csv")


# Create a database connection
db.sales <- dbConnect(SQLite(), dbname="sales.sqlite")
dbWriteTable(conn = db.sales, name = "salesdb1", sales1, 
             overwrite=TRUE, row.names=FALSE)
dbWriteTable(conn = db.sales, name = "salesdb2", sales2, 
             overwrite=TRUE, row.names=FALSE)
dbGetQuery(db.sales, "select * from salesdb1")
dbGetQuery(db.sales, "select * from salesdb2")
s2 <- dbGetQuery(db.sales, "select * from salesdb2")

#WHERE
#Where [condition] is a good way to refine search
#Get July sales
july.sales <- dbGetQuery(db.sales, "select * from salesdb1 where month= '201807'")
#Get multiple conditions
jun_jul <- dbGetQuery(db.sales, "select * from salesdb1 where month= '201806' OR month='201807'")
jun_jul
jun_jul2 <- dbGetQuery(db.sales, "select * from salesdb1 where month<= '201807'")
jun_jul2

#CERTAIN VARIABLES
#PROBLEM: lots of variables in big databases
#To get certain variables list them after select
#Use a comma to seperate them
dbGetQuery(db.sales, "select month, customer, amount from salesdb1")

#DIFFERENT NAMES
#To get variables as a different name do this:
#Use the as keyword
dbGetQuery(db.sales, "select month as Month, customer as Customer, amount as 'Sales Units' from salesdb1")

#SORT
#What if we want to sort by a variable?
dbGetQuery(db.sales, "select month, customer, amount from salesdb1 order by amount")
#What if we want the largest at the top?
#Use DESC
dbGetQuery(db.sales, "select month, customer, amount from salesdb1 order by amount DESC")
#Multiple Sorting criteria
dbGetQuery(db.sales, "select month, customer, amount from salesdb1 order by customer, amount DESC")

#LIMIT
#How do you say only return the first 4?
#Use the limit option
dbGetQuery(db.sales, "select month, customer, amount from salesdb1 order by amount DESC LIMIT 4")

#GROUP DATA
#What if we dont want the largest individual sales
#What if instead we prefer a groups total data
#use group keyword
dbGetQuery(db.sales, "select month, customer, amount from salesdb1 group by customer")
#This way only gives the first observation
#Have to tell how to group the data
#Do this:
dbGetQuery(db.sales, "select month, customer, sum(amount) from salesdb1 group by customer")
#sum is an aggregating function and is the way to get the total from each customer
#without specifying this it will just report the first ovbservation


dbGetQuery(db.sales, "select customer, sum(amount) from salesdb1 group by customer order by sum(amount) DESC")


#JOINS
#Flat 6% commision on all sales
# Price changed June -> July

revenue <- dbGetQuery(db.sales, "select * from salesdb1 join salesdb2 on salesdb1.month=salesdb2.month")
revenue

#CREATE NEW SQL Table
#Revenue is an R dataframe
#How do we transfer it back into the SQLite database for further queries
dbWriteTable(conn=db.sales, name = "salesdb3", revenue, overwrite=TRUE, row.names=FALSE)
#Error: how to overcome this error
#Can't have 2 columns with the same name
rev.fix <- revenue[, -5] 
#-5 removes column 5
dbWriteTable(conn=db.sales, name = "salesdb3", rev.fix, overwrite=TRUE, row.names=FALSE)
dbGetQuery(db.sales, "select * from salesdb3")


#EXAMPLE:
# 1: Calcualte the revenue per-sale
# 2: Total commission per employee
#sumis an aggregation function so we must group
#can do the commision calculation for each
comm <- dbGetQuery(db.sales, "select employee, sum(.06*amount*price) as commission from salesdb3 group by employee")
comm

salestax <- dbGetQuery(db.sales, "select sum(amount*price*salestax) from salesdb3")
salestax
#No group by this time, we just want the total.


#JSON
tasks <- c('{"desc":"Homework 1","due":"2022-11-22"}','{"desc":"Homework 2","due":"2022-12-02"}')

tasks
dbWriteTable(conn=db.sales, name = "tasksdb", data.frame(tasks), overwrite=TRUE, row.names=FALSE)
dbGetQuery(db.sales, "select * from tasksdb")
dbGetQuery(db.sales, "select tasksdb.tasks->>'$.desc' from tasksdb where tasksdb.tasks->>'$due'<= '2022-11-30'")
