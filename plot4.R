#optional
# install.packages("sqldf")

# Load dependencies
library(data.table)
library(sqldf)
library(lubridate)



###  Go to the project directory
setwd("~/archivo/Coursera - Exploratory Data Analysis/courseproject1")


# Download the data

fileurl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
datazip = "household_power_consumption.zip"
download.file(fileurl, destfile = datazip, method = "curl")
unzip(datazip, overwrite = TRUE)


#load the data fo two days
datafile ="household_power_consumption.txt"

data <- read.csv.sql(datafile, sql = "SELECT * from file
WHERE Date in ('1/2/2007', '2/2/2007') ", sep = ";", header = TRUE)

# convert data$Date from character to date format

data$datetime <- paste(data$Date,data$Time)
data$datetime<-dmy_hms(data$datetime)


png("plot4.png", width = 480, height = 480, units= "px")
# par(mfrow=c(2,2), mar=c(4,4,1,2))
par(mfrow=c(2,2)) #fill the 2x2 matrix with the follwing plots using rows

with(data, plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power", xlab = ""))

with(data, plot(datetime, Voltage, type = "l", ylab = "Voltage", xlab = "datetime"))

with(data, plot(datetime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", col = "black"))
with(data, lines(datetime, Sub_metering_2, col="red"))
with(data, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", lty=1, bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))

with(data, plot(datetime, Global_active_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime"))

dev.off()