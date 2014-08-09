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
# Plot 2
plot2 <- function()
  {
    plot(d$minute, d$Global_active_power, type="l",
              ylab="Global Active Power (kilowatts)",
              xlab=" ")
}
png("plot2.png", height = 480, width = 480, units = "px")
plot2()
dev.off()

## AND with ggplot2
# require("ggplot2")
# plot2 <-
#   ggplot() +
#   geom_line(data = d, aes(x = minute, y = Global_active_power)) +
#   ylab("Global Active Power (kilowatts") +
#   xlab("") +                 # xlab(day) +
#   theme(       
#     panel.border = element_rect(color = 'black', fill = NA),
#     axis.line = element_line(colour = "black"),
#     panel.background = element_blank(),
#     panel.grid.major = element_blank(),
#     panel.grid.minor = element_blank()
#   ) 
# png("plot2.png", height = 480, width = 480, units = "px")
# plot2
# dev.off()