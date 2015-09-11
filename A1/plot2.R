library(dplyr)
library(lattice)

message("Load the data...")
if (!exists("p2Data")) {
    p2Data <- read.table("household_power_consumption.txt", sep=";", 
                         na.strings = "?", header = TRUE, 
                         stringsAsFactors = FALSE)
    message("Data loaded, reformat the date...")

    p2Data$Tmstmp <- as.POSIXct(paste(p2Data$Date, p2Data$Time), 
                                format = "%d/%m/%Y %H:%M:%S")
    
    # print(p2Data$Tmstmp)
    
    message("Filter the data for the specified range [02/01/2007 - 02/02/2007]")
    p2SubData <- filter(p2Data, 
                        Tmstmp >= "2007-02-01 00:00:00" & Tmstmp < "2007-02-03 00:00:00")
}

message("Plot a histogram for the Global_active_power variable...")
plot(p2SubData$Tmstmp, p2SubData$Global_active_power, type = "l",
     ylab = "Global Active Power (killowatts)", xlab = "")

message("Save the plot as 'plot2.png'")

# Save plot to png file
dev.copy(png, file = "plot2.png")
dev.off()

message("Done!")
