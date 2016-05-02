# Create the appropriate subsetof data 
pwc <- read.csv("household_power_consumption.txt", sep=";")
pwc_ss <- subset(pwc, pwc$Date == "1/2/2007" | pwc$Date == "2/2/2007")

# Set the ploting device to a PNG file
png(filename = "plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", type ="windows")

# Multiple plot parameters, in asthey're not c(1,1)
par(mfrow=c(1,1) )

# Create an index to plot by, ad extract the weekdays from the dates
pwc_ss$Weekday <- weekdays(as.POSIXlt(pwc_ss$Date, format="%d/%m/%Y"))
pwc_ss$index <- 1:nrow(pwc_ss)

# Create the the "Global Active Power" time series plot
tempMeter1 <- as.numeric(pwc_ss$Sub_metering_1)
tempMeter2 <- as.numeric(pwc_ss$Sub_metering_2) / 7 # Scaling, not sure why neccessary???
tempMeter3 <- as.numeric(pwc_ss$Sub_metering_3)

# Create the sub metering plot
plot(pwc_ss$index, tempMeter1, ylab="Energy sub metering",
     xlab="", xaxt="n", type="l", lwd=2, col="black")
points(pwc_ss$index, tempMeter2, col="red", type="l", lwd=2)
points(pwc_ss$index, tempMeter3, col="blue", type="l", lwd=2)
axis(1, c(1,1440,2880), labels=c("Thurs", "Fri", "Sat") )
legend("topright", col=c("black","red","blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1), lwd=c(2,2) )

# Close the png device
dev.off()

# Remove the extra data
rm(pwc, pwc_ss, tempMeter1, tempMeter2, tempMeter3)