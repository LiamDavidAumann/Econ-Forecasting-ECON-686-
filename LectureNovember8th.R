library(tstools)
inf <- read.csv("https://raw.githubusercontent.com/bachmeil/econ-686-fall-2022/main/inflation.csv", header=TRUE)
inf <- ts(inf[, "CPIAUCSL_PC1"], start = c(1948, 1), frequency = 12)

#Check that start and end dates are what you expect
start(inf)
end(inf) == c(2022,7)
ts.check(inf, list(c(1948,1), 
                   c(2022,7),
                   c(1980,1),
                   c(2000,1)), c(10.24209, 8.48213, 13.86861, 2.79296))
#Catch most small errors with this plus plotting
#Small errors are horrifying

#Query Database
tasks <- read.csv("tasks.csv")
#The comma indicates all the rows
#the < "11-08" picks things less than that date
query <- tasks[, "date"] < "11-08"
tasks[query,]


#SQL:
#Create a new SQLite database.


#terminal
# Create a schema 
# Give name of the table (equivalent of a csv file)
# Give it info about what is in there:
#   Variable name
#   Varible type

#Querying is done by select
#Querying: select
# SELECT [what you want] from [table name]
# select item, from tasks where class ='536';
# select item, from tasks where class ='536';


#Using sqlite within R
library(sqldf)
#Load data into R
sales1 <- read.csv("sales1.csv")
sales2 <- read.csv("sales2.csv")


# Create a database connection
db.sales <- dbConnect(SQLite(), dbname="sales.sqlite")

#Add a new table
#dbWriteTable() is a the function to make changes to the database.
#sales1 is R data
#overwrite means to force the change if there is ever a conflict
dbWriteTable(conn = db.sales, name = "salesdb1", sales1, 
             overwrite=TRUE, row.names=FALSE)
#sales2 table
dbWriteTable(conn = db.sales, name = "salesdb2", sales2, 
             overwrite=TRUE, row.names=FALSE)

# select
# dbGetQuery to do that
dbGetQuery(db.sales, "select * from salesdb1")
# Salespeople, sustomer, amount of sale
dbGetQuery(db.sales, "select * from salesdb2")

s2 <- dbGetQuery(db.sales, "select * from salesdb2")
class(s2)
s2
#can use s2 like any other dataset


