library(dplyr)
library(lubridate)
library(png)
list.files()
a <- read.csv("household_power_consumption.txt",sep = ";", header = TRUE)
b <- na.omit(a)
class(b)
str(b)

b$Date <- dmy(b$Date)
class(b$Date)

from <- dmy("01-02-2007")
to <- dmy("02-02-2007")

d <- filter(b, Date >= from & Date <= to)
d$Global_active_power <- as.numeric(as.character(d$Global_active_power))

png("plot1.png")
par(mfrow = c(1,1), mar = c(4,4,4,1))
hist(d$Global_active_power, xlab = "Global Active Power (Kilowatts)",
     main = "Global Active Power", col = "red")
dev.off()

