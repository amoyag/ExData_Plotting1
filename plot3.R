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

#convert measures that will be plotted to numeric
# This may not be necessary, just in case


data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)



## Plot

png("plot3.png", width = 480, height = 480, units= "px")

with(data, plot(datetime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", col = "black"))
with(data, lines(datetime, Sub_metering_2, col="red"))
with(data, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))

dev.off()