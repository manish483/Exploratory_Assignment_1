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


png("plot3.png", height = 480, width = 480)
par(mfrow = c(1,1), mar = c(2,4,1,2))
plot(d$dtime, d$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
points(d$dtime, d$Sub_metering_1, type = "l", pch = "")
points(d$dtime, d$Sub_metering_2, col = "red", type = "l", pch = "")
points(d$dtime, d$Sub_metering_3, col = "blue", type = "l", pch = "")
legend("topright", col = c("black","red","blue"),bty = "L",
       lty = 1, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
