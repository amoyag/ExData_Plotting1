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


#load the data
datafile ="household_power_consumption.txt"

# This loads the data into a dataframe based on a sql query
data <- read.csv.sql(datafile, sql = "SELECT * from file
WHERE Date in ('1/2/2007', '2/2/2007') ", sep = ";", header = TRUE)

# convert data$Date from character to date format

data$datetime <- paste(data$Date,data$Time)
data$datetime<-dmy_hms(data$datetime)

#convert measures to numeric

data$Global_active_power <- as.numeric(data$Global_active_power)


#plot 1

png("plot1.png", width = 480, height = 480, units= "px")
with(data,hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)"))
dev.off()



