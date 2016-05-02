# Create the appropriate subsetof data 
pwc <- read.csv("household_power_consumption.txt", sep=";")
pwc_ss <- subset(pwc, pwc$Date == "1/2/2007" | pwc$Date == "2/2/2007")

# Set the ploting device to a PNG file
png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", type ="windows")

# Create an index to plot by, ad extract the weekdays from the dates
pwc_ss$Weekday <- weekdays(as.POSIXlt(pwc_ss$Date, format="%d/%m/%Y"))
pwc_ss$index <- 1:nrow(pwc_ss)

# Create the the "Global Active Power" time series plot
tempMeter1 <- as.numeric(pwc_ss$Sub_metering_1)
tempMeter2 <- as.numeric(pwc_ss$Sub_metering_2) / 7 # Scaling, not sure why neccessary???
tempMeter3 <- as.numeric(pwc_ss$Sub_metering_3)

# Multiple plot parameters
par(mfrow=c(2,2) )
par(mar=c(2,4,3,2) )
par(cex.axis=0.9, cex.lab=0.9)

# Create the the "Global Active Power" time series plot
tempPWC <- as.numeric(pwc_ss$Global_active_power) / 500
plot(pwc_ss$index, tempPWC, ylab="Global Active Power (kilowatts)",
     xlab="", xaxt="n", type="l", lwd=1)
axis(1, c(1,1440,2880), labels=c("Thurs", "Fri", "Sat") )

# Create the the "Voltage" time series plot
plot(pwc_ss$index, pwc_ss$Voltage, ylab="Voltage",
     xlab="datetime", xaxt="n", type="l", lwd=1)
axis(1, c(1,1440,2880), labels=c("Thurs", "Fri", "Sat") )

# Create the sub metering plot
plot(pwc_ss$index, tempMeter1, ylab="Energy sub metering",
     xlab="", xaxt="n", type="l", lwd=1, col="black")
points(pwc_ss$index, tempMeter2, col="red", type="l", lwd=1)
points(pwc_ss$index, tempMeter3, col="blue", type="l", lwd=1)
axis(1, c(1,1440,2880), labels=c("Thurs", "Fri", "Sat") )
legend("topright", col=c("black","red","blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1), lwd=c(1,1), cex=0.7, bty="n" )

# Create the the "Global reactive power" time series plot
plot(pwc_ss$index, pwc_ss$Global_reactive_power, ylab="Global_reactive_power",
     xlab="datetime", xaxt="n", type="l", lwd=1)
axis(1, c(1,1440,2880), labels=c("Thurs", "Fri", "Sat") )

# Close the png device
dev.off()

# Remove the extra data
rm(pwc, pwc_ss, tempPWC, tempMeter1, tempMeter2, tempMeter3)