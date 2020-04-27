library(dplyr)
library(lubridate)
library(png)
list.files()
a <- read.csv("household_power_consumption.txt",sep = ";", header = TRUE)
b <- na.omit(a)
class(b)
str(b)

b$Date <- dmy(b$Date)
b$Date[1]
class(b$Date)

from <- dmy("01-02-2007")
to <- dmy("02-02-2007")

d <- filter(b, Date >= from & Date <= to)
d$Global_active_power <- as.numeric(as.character(d$Global_active_power))

d$dtime <- with(d,ymd(Date)+ hms(Time))
class(d$dtime)

png("plot2.png", height = 480, width = 480)
with(d, plot(dtime, Global_active_power,
             type = "l",
             pch = "",
             xlab = "",
             ylab = "Global Active Power (Kilowatts)"))
dev.off()

