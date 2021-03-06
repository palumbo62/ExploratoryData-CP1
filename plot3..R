###################################################################
# Coursera Johns Hopkins Data Scientist Track
# Exploratory Data Analysis Course
#
# Author:   Robert Palumbo
# Project:  Course Project 1
# Source:   plot3.R
# Notes:    Plots a line-graph for each of the Sub_metering_[1..3]
#           variable over the imeframe [02/01/2007 - 02/02/2007]
###################################################################
library(dplyr)

message("Load the data...")
p3Data <- read.table("household_power_consumption.txt", sep=";", 
                     na.strings = "?", header = TRUE, 
                     stringsAsFactors = FALSE)

message("Data loaded, reformat the date...")
p3Data$xDate <- as.Date(p3Data$Date, format = "%d/%m/%Y")

message("Filter the data for the specified range [02/01/2007 - 02/02/2007]")
p3SubData <- filter(p3Data, xDate >= "2007-02-01" & xDate < "2007-02-03")

p3SubData$Tmstmp <- as.POSIXct(paste(p3SubData$Date, p3SubData$Time), 
                               format = "%d/%m/%Y %H:%M:%S")

# Slightly adjust the plot margins
par1 <- par(mai=c(0.75, 0.9, 0.5, 0.5))

message("Plot a line-graph for each Sub_metering_[1..3]...")
plot(p3SubData$Tmstmp,  p3SubData$Sub_metering_1, type = "l",
     ylab = "Energy sub metering", xlab = "", col="black")
lines(p3SubData$Tmstmp, p3SubData$Sub_metering_2,col="red")
lines(p3SubData$Tmstmp, p3SubData$Sub_metering_3,col="blue")

# Create a legend
legend("topright", lty = 1, lwd=1.5,
       cex = 0.75,
       x.intersp = 0.25, y.intersp = 0.75,
       col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

message("Save the plot as 'plot3.png'")

par(mai=par1)

# Save plot to png file
dev.copy(png, file = "plot3.png", width = 640, height = 480)
dev.off()

message("Done!")
