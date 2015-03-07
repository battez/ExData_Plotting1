# WEEK1 ~ ASSIGNMENT 1 
# by battez
# plot3.R

# Reconstruct Plot 3 of the assignment. MultiLine plot 
# 
# code for reading the data
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
png(file="plot3.png", width=480, height=480)

x <- data$FullDateTime
y <- data$Sub_metering_1

plot(x, y, type="n", ylab="Energy sub metering", xlab="")
lines(x, y, type="l") #black default

y <- data$Sub_metering_2
lines(x, y, type="l", col="red")

y <- data$Sub_metering_3
lines(x, y, type="l", col="blue")

# legend with 3 lines and no symbols.
legend("topright", lwd=1, lty=c(1,1,1), pch=c(NA,NA,NA), col=c("black", "red","blue"), 
legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

dev.off()