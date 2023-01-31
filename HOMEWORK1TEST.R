dataset.csv = read.csv("https://raw.githubusercontent.com/LiamDavidAumann/Econ-Forecasting-ECON-686-/main/JobOpenings.csv", header = TRUE)
names(dataset.csv) = c("Date", "JobOpenings")

openings <- ts(dataset.csv[, "JobOpenings"], start = c(2000, 12), frequency = 12)

tapply(openings, cycle(openings),mean)

dataset.csv