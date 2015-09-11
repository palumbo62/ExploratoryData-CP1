###################################################################
# Coursera Johns Hopkins Data Scientist Track
# Exploratory Data Analysis Course
#
# Author:   Robert Palumbo
# Project:  Course Project 1
# Source:   plot2.R
# Notes:    Plots a line-graph Global_active_power variable over
#           the timeframe [02/01/2007 - 02/02/2007]
###################################################################
library(dplyr)

message("Load the data...")
p2Data <- read.table("household_power_consumption.txt", sep=";", 
                     na.strings = "?", header = TRUE, 
                     stringsAsFactors = FALSE)

message("Data loaded, reformat the date...")
p2Data$xDate <- as.Date(p2Data$Date, format = "%d/%m/%Y")

message("Filter the data for the specified range [02/01/2007 - 02/02/2007]")
p2SubData <- filter(p2Data, xDate >= "2007-02-01" & xDate < "2007-02-03")

p2SubData$Tmstmp <- as.POSIXct(paste(p2SubData$Date, p2SubData$Time), 
                               format = "%d/%m/%Y %H:%M:%S")

message("Plot a line-graph for the Global_active_power variable...")
plot(p2SubData$Tmstmp, p2SubData$Global_active_power, type = "l",
     ylab = "Global Active Power (killowatts)", xlab = "")

message("Save the plot as 'plot2.png'")

# Save plot to png file
dev.copy(png, file = "plot2.png")
dev.off()

message("Done!")
