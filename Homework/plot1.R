#---PLOT1---#

#Downloading zip data
dir.create("./data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./data/household_power_consumption.zip")
unzip(zipfile = "./data/household_power_consumption.zip")

#Loading data
RawData <- read.table("household_power_consumption.txt", header = T, skip = 0, sep = ";", na.strings = "?")

#Making column of datetime.
temp_date <- RawData$Date
temp_time <- RawData$Time
datetime <- strptime(paste(temp_date, temp_time), format="%d/%m/%Y %H:%M:%S")
RawData$Datetime <- datetime

#I use data from the dates 2007-02-01 and 2007-02-02.
cond <- RawData$Datetime > "2007-02-01" & RawData$Datetime < "2007-02-03"
Data <- subset(RawData, cond)

#Making plot1 figure
png(filename = "plot1.png", width = 480, height = 480)
par(ps = 15)
hist(Data[, "Global_active_power"],
     col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Freaquency", 
)
dev.off()