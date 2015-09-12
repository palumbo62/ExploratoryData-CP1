###################################################################
# Coursera Johns Hopkins Data Scientist Track
# Exploratory Data Analysis Course
#
# Author:   Robert Palumbo
# Project:  Course Project 1
# Source:   plot1.R
# Notes:    Plots a histogram of the Global_active_power variable
#           the timeframe [02/01/2007 - 02/02/2007]
###################################################################
library(dplyr)

message("Load the data...")
p1Data <- read.table("household_power_consumption.txt",
                     sep=";", na.strings = "?", 
                     header = TRUE, stringsAsFactors = FALSE)

message("Data loaded, reformat the date...")
p1Data$Date <- as.Date(p1Data$Date, format = "%d/%m/%Y")
    
message("Filter the data for the specified range [02/01/2007 - 02/02/2007]")
p1SubData <- filter(p1Data, Date >= "2007-02-01" & Date < "2007-02-03")

# Slightly adjust the plot margins
par1 <- par(mai=c(0.75, 0.9, 0.5, 0.5))

message("Plot a histogram for the Global_active_power variable...")
hist(p1SubData$Global_active_power, freq = TRUE, col = "red",
     main = "Global Active Power", xlab = "Global Active Power (killowatts)")

message("Save the plot as 'plot1.png'")

par(mai=par1)

# Save plot to png file
dev.copy(png, file = "plot1.png", width = 640, height = 480)
dev.off()

message("Done!")
