# setwd("~/Desktop/JHU DS Certif/C4 EDA/Project_1")
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),header = T,sep = ';',na.strings = "?")
unlink(temp)
d <- subset(data, Date=='1/2/2007' | Date=='2/2/2007')
#
library("lubridate")
d$minute <- dmy_hms(paste(d$Date, d$Time))
head(d$minute)
d$day <- wday(d$minute, label = T, abbr = T)
head(d$day)
#
#
graphics.off()
plot3 <- function()
{
  plot(d$minute, d$Sub_metering_1, type = "l", col = "black",xlab = "",ylab = "Energy sub metering") 
  lines(d$minute, d$Sub_metering_2, type = "l", col = "red") 
  lines(d$minute, d$Sub_metering_3, type = "l", col = "blue") 
  legend("topright", 
        col = c("black", "red", "blue"), 
        lty= "solid", 
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
        )
}
png("plot3.png", height = 480, width = 480, units = "px")
plot3()
dev.off()