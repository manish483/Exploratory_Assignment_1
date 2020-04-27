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
d$Sub_metering_1 <- as.numeric(as.character(d$Sub_metering_1))
d$Sub_metering_2 <- as.numeric(as.character(d$Sub_metering_2))
d$Sub_metering_3 <- as.numeric(as.character(d$Sub_metering_3))
d$Voltage <- as.numeric(as.character(d$Voltage))
d$Global_reactive_power <- as.numeric(as.character(d$Global_reactive_power))

d$dtime <- with(d,ymd(Date)+ hms(Time))
class(d$dtime)

png("plot4.png", height = 480, width = 480)
par(mfrow = c(2,2), mar = c(2,4,1,2))
with(d, plot(dtime, Global_active_power,
             type = "l",
             pch = "",
             xlab = "",
             ylab = "Global Active Power (Kilowatts)"))

with(d, plot(dtime, Voltage,
             type = "l",
             pch = "",
             xlab = "datetime",
             ylab = "Voltage"))

plot(d$dtime, d$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
points(d$dtime, d$Sub_metering_1, type = "l", pch = "")
points(d$dtime, d$Sub_metering_2, col = "red", type = "l", pch = "")
points(d$dtime, d$Sub_metering_3, col = "blue", type = "l", pch = "")
legend("topright", col = c("black","red","blue"),bty = "L",
       lty = 1, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
str(d$Global_reactive_power)

with(d, plot(dtime, Global_reactive_power,
             type = "l",
             pch = "",
             xlab = "datetime",
             ylab = "Global_reactive_power"))
dev.off()
