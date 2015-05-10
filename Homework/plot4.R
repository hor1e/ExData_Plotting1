#---PLOT4---#

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

#Making plot4 figure
png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2), mar = c(3, 4, 2, 2), oma = c(1, 1, 1, 0), ps = 15)
with(Data, {
  
  #Top-left
  plot(Datetime, Global_active_power, type = 'l',
       xlab = "", ylab = "Global Active Power")
  
  #Top-right
  plot(Datetime, Voltage, type = 'l',
       xlab = "datetime", ylab = "voltage")
  
  #Bottom-left
  plot(Datetime, Sub_metering_1, type = 'l', col = "black",
       xlab = "", ylab = "Energy sub metering")
  lines(Datetime, Sub_metering_2, type = 'l', col = "red")
  lines(Datetime, Sub_metering_3, type = 'l', col = "blue")      
  labels <- c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')
  cols <- c('black', 'red', 'blue')
  legend('topright', legend = labels, col = cols, lty = 1, bty="n", cex = 0.9)
  
  #Bottom-right
  plot(Datetime, Global_reactive_power, type = 'l',
       xlab = "datetime", ylab = "Global_reactive_power")
  }
)

dev.off()

