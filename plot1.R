# WEEK1 ~ ASSIGNMENT 1 
# by battez
# plot1.R
# 


# Reconstruct Plot 1 of the assignment. Histogram.
# 
# code for reading the data
#
# load all the lines in.
all <- readLines("~/Downloads/household_power_consumption.txt")

# make a vector of the lines for the dates we want 
feb12 <- grep("^[12]/2/2007", substr(all, 1,8)) #2880 lines

# make the needed data frame from this subset of lines.
data <- read.table(text=all[feb12], sep=";", na.strings="?", header=TRUE, 
	col.names=c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", 
		"Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# convert the date and time into a new column of DateTime:
data$FullDateTime <- paste(data$Date, data$Time)
data$FullDateTime <- strptime(data$FullDateTime, format = "%d/%m/%Y %H:%M:%S")

# code for creating PNG version of this plot:
png(file="plot1.png", width=480, height=480)

hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

dev.off()
	