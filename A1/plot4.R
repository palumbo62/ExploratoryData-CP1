###################################################################
# Coursera Johns Hopkins Data Scientist Track
# Exploratory Data Analysis Course
#
# Author:   Robert Palumbo
# Project:  Course Project 1
# Source:   plot4.R
# Notes:    Plots a 4 different graphs on same page all over
#           the timeframe [02/01/2007 - 02/02/2007]:
#           1. Global_active_power over time
#           2. Energy submetering_[1..3] over time
#           3. Voltage over datetime
#           4. Global_reactive_power over datetime
###################################################################
library(dplyr)

message("Load the data...")
p4Data <- read.table("household_power_consumption.txt", sep=";", 
                     na.strings = "?", header = TRUE, 
                     stringsAsFactors = FALSE)

message("Data loaded, reformat the date...")
p4Data$xDate <- as.Date(p4Data$Date, format = "%d/%m/%Y")

message("Filter the data for the specified range [02/01/2007 - 02/02/2007]")
p4SubData <- filter(p4Data, xDate >= "2007-02-01" & xDate < "2007-02-03")

p4SubData$Tmstmp <- as.POSIXct(paste(p4SubData$Date, p4SubData$Time), 
                               format = "%d/%m/%Y %H:%M:%S")

# Going to plot 4 graphs on same device at the same time
par1 <- par(mfcol = c(2,2))
par2 <- par(cex=0.55)
par3 <- par(mai=c(0.75, 0.75, 0.5, 0.5))

#####
# Plot global active power over time in plot1
#####
message("Plot a line-graph for the Global_active_power variable...")
plot(p4SubData$Tmstmp, p4SubData$Global_active_power, type = "l",
     ylab = "Global Active Power (killowatts)", xlab = "")

#####
# Plot Submetering over time in plot2
#####
message("Plot a line-graph for each Sub_metering_[1..3]...")
plot(p4SubData$Tmstmp,  p4SubData$Sub_metering_1, type = "l", 
     ylab = "Energy sub metering", xlab = "", col="black")
lines(p4SubData$Tmstmp, p4SubData$Sub_metering_2,col="red")
lines(p4SubData$Tmstmp, p4SubData$Sub_metering_3,col="blue")

# Create a legend
legend("topright", 
       lty = 1, lwd=1.5, bty = "n",
       x.intersp = 0.5, y.intersp = 0.75,
       col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#####
# Plot a line-graph for Voltage over time in plot3
#####
message("Plot a line-graph for Voltage...")
plot(p4SubData$Tmstmp, p4SubData$Voltage, type = "l",
     ylab = "Voltage", xlab = "datetime")


#####
# Plot a line-graph for Global_reactive_power over time in plot4
#####
message("Plot a line-graph for Global_reactive_power...")
plot(p4SubData$Tmstmp, p4SubData$Global_reactive_power, type = "l",
     ylab = "Global_reactive_power", xlab = "datetime")

#par(cex=op)
message("Save the plot as 'plot4.png'")

par(mfcol=par1)
par(cex=par2)
par(mai=par3)

# Save plot to png file
dev.copy(png, file = "plot4.png", width = 640, height = 480)
dev.off()

message("Done!")
