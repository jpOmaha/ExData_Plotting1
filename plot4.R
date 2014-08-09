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
# Plot 4 - A 2x2 Multiplot
graphics.off()
plot2 <- function()
  {
    plot(d$minute, d$Global_active_power, type="l",
         ylab="Global Active Power (kilowatts)",
         xlab=" ")
  }
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
plotC <- function()
  {
    plot(d$minute, d$Voltage, type="l",
         ylab="Voltage", xlab="datetime")
  }
plotD <- function()
  {
  plot(d$minute, d$Global_reactive_power, type="l",
       ylab="Global_reactive_power,", xlab="datetime")
  }
png("plot4.png", height = 480, width = 480, units = "px")
par(mfrow = c(2,2))
plot2()
plotC()
plot3()
plotD()
dev.off()
#

# library("ggplot2", lib.loc="/Library/Frameworks/R.framework/Versions/3.1/Resources/library")
# plot_4 <-
#   ggplot() +
#   geom_line(data = d, aes(x = minute, y = Global_reactive_power)
#   ) +
#   ylab("Global Active Power (kilowatts") +
#   xlab("datetime") +                 # xlab(day) +
#   theme(       
#     panel.border = element_rect(color = 'black', fill = NA),
#     axis.line = element_line(colour = "black"),
#     panel.background = element_blank(),
#     panel.grid.major = element_blank(),
#     panel.grid.minor = element_blank()
#   ) 
#
# plot_5 <-
#   ggplot() +
#   geom_line(data = d, aes(x = minute, y = Voltage)
#   ) +
#   ylab("Global Active Power (kilowatts") +
#   xlab("datetime") +                 # xlab(day) +
#   theme(       
#     panel.border = element_rect(color = 'black', fill = NA),
#     axis.line = element_line(colour = "black"),
#     panel.background = element_blank(),
#     panel.grid.major = element_blank(),
#     panel.grid.minor = element_blank()
#   ) 
#
# png("plot4.png", height = 480, width = 480, units = "px")
# source("http://peterhaschke.com/Code/multiplot.R") 
# multiplot(plot2(), plot3(), plot_4, plot_5, cols=2)
# dev.off()
