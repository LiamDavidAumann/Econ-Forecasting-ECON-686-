library(tstools)
dom <- import.fred("autos-domestic.csv")

growth.dom <- pctChange(dom, 12)
growth.recent <- window(growth.dom, start=c(2022,1))

#Single forecast plot
fcst <- ts(c(last(growth.recent),-.05, -.04, -.03, -.02),
           start=c(2022,8), frequency = 12)
growth.forecastadded <- ts(c(growth.recent, fcst), 
                           start = c(2022, 1), 
                           frequency = 12)
plot(growth.forecastadded)
combined <- ts.union(growth.recent, fcst)
plot(combined, lty=c(1,2), plot.type="single")

#Scenario Forecast Plot
#Remember to put the last observation as the first observation for the forecast variables

#Current monetary policy
scenario1 <- ts(c(last(growth.recent),-.05, -.04, -.03, -.02),
           start=c(2022,8), frequency = 12)

#Expansionary Policy
scenario2 <- ts(c(last(growth.recent),-.05, 0, .05, .1),
                start=c(2022,8), frequency = 12)

#Contractionairy
scenario3 <- ts(c(last(growth.recent),-.05, -.1, -.15, -.2),
                start=c(2022,8), frequency = 12)

dummyline <- ts()

#Remember use ts.union() and not ts.combine (ts.combine deletes empty)
combined <- ts.union(growth.recent, scenario1, scenario2, scenario3)

plot(combined, lty=c(1,2,3,4), plot.type="single")
#How to lable the forecasts
text(2022.75, 0.08, "Expansionary")
text(2022.88, -0.06, "Current")
text(2022.8, -.2, "Contractionairy")

#Metadata
dom
start(dom)
end(dom)
frequency(dom)

#Store the metadata using:
saveRDS(dom, "Domestic-autos.RDS")
#rm removes a variable from the workspace
rm(dom)

#Reload the data
dom<- readRDS("Domestic-autos.RDS")
dom

#Add your own metadata
# called "Attributes" in R

attr(dom, "source") <- "Fred series DOMESTICAUTOS"
attr(dom, "source")

attr(dom, "downloaded by") <- "Liam Aumann"
attr(dom, "downloaded by")

attr(dom, "download date") <- "2022-10-31"
attr(dom, "download date")

saveRDS(dom, "Domestic-autos.RDS")
#Since its a binary file and has attributes you have this info and it cannot be changed

#Reading messy data
#Can we read in the salestax.txt data
st <- read.csv("salestax.txt")
st

#Specify a different seperater
#Maybe its tab dilinaited instead of comma
st <- read.csv("salestax.txt", sep = "\t")
st

class(st[,3])
#Reading data as a string

#Remve $ and *
#Textfile manipulation
#Pearl traditionally the language used to do this although R works just fine
#Regular expressions

# gsub for regular expression replacements
# g for global (everywhere in the file)
# sub for substitution

#Load file as a giant string
st.text <- readLines("salestax.txt")

#Remove $ sign
st.text1 <- gsub("\\$", "", st.text)
#Remove * sign
st.text2 <- gsub("\\*", "", st.text1)
#Remove double tabs
st.text3 <- gsub("\t\t", ",", st.text2)
# Some had a stray space in between them
#\\s is any whitespace
#the * indicates 0 or more times
st.text3 <- gsub("\t\\s*\t", ",", st.text2)


#save the file and read it
cat(st.text3, file="salestax.csv", sep="\n")















