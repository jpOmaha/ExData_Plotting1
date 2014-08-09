# setwd("~/Desktop/JHU DS Certif/C4 EDA/Project_1")
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),header = T,sep = ';',na.strings = "?")
unlink(temp)
d <- subset(data, Date=='1/2/2007' | Date=='2/2/2007')
#
## TO READ IN ONLY TWO DAYS NEEDED, could make a path and file string like so:
## load library
## library(sqldf)
## fn<-"C:/yourpath/yourfile.txt"
## read file and select rows based on string "1/1/2007 OR 2/1/2007" and store in dataframe d
## d <- read.csv.sql(fn, sep=";",sql = 'select * from file where Date = "1/1/2007" OR Date = "21/1/2007"')
#
library("lubridate")
d$minute <- dmy_hms(paste(d$Date, d$Time))
head(d$minute)
d$day <- wday(d$minute, label = T, abbr = T)
head(d$day)
# Plot 1
plot_1 <- function()
{
  hist(d$Global_active_power
       , col="red"
       , main="Global Active Power"
       , xlab="Global Active Power (kilowatts)"
  )
}
png("plot1.png", height = 480, width = 480, units = "px")
plot_1()
dev.off()