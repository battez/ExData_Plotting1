# WEEK1 ~ ASSIGNMENT 1 
# by battez
# plot4.R

# Reconstruct Plot 4 of the assignment. Make a PNG with 4 plots.
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
png(file="plot4.png", width=480, height=480)

# set up the 2 x 2 grid, colwise-filled layout.
par(mfcol=c(2,2), oma=c(0,0,0,0))


#plot4a
x <- data$FullDateTime #stays same for all plots
y <- data$Global_active_power

# set up plot
plot(x, y, type="n", ylab="Global Active Power", xlab="")
lines(x, y, type="l")

#plot 4b
y <- data$Sub_metering_1

plot(x, y, type="n", ylab="Energy sub metering", xlab="")
lines(x, y, type="l")
y <- data$Sub_metering_2
lines(x, y, type="l", col="red")
y <- data$Sub_metering_3
lines(x, y, type="l", col="blue")

# no box around Legend
legend("topright", bty="n", lwd=1,lty=c(1,1,1),pch=c(NA,NA,NA), col=c("black", "red","blue"), 
legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

#plot 4c
x <- data$FullDateTime
y <- data$Voltage
plot(x, y, type="n", ylab="Voltage", xlab="datetime" , yaxt='n')

#customised y-axis & labels
axis(side=2, at=seq.int(from=234, to=246, by=2), labels=c("234","","238","","242","","246"))
lines(x, y, type="l")

#plot4d
y <- data$Global_reactive_power
plot(x, y, type="n", ylab="Global_reactive_power", xlab="datetime")
lines(x, y, type="l")

dev.off()

