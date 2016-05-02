# Create the appropriate subsetof data 
pwc <- read.csv("household_power_consumption.txt", sep=";")
pwc_ss <- subset(pwc, pwc$Date == "1/2/2007" | pwc$Date == "2/2/2007")

# Set the ploting device to a PNG file
png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", type ="windows")

# Multiple plot parameters, in asthey're not c(1,1)
par(mfrow=c(1,1) )

# Create an index to plot by, ad extract the weekdays from the dates
pwc_ss$Weekday <- weekdays(as.POSIXlt(pwc_ss$Date, format="%d/%m/%Y"))
pwc_ss$index <- 1:nrow(pwc_ss)

# Create the the "Gobal Active Power" time series plot
tempPWC <- as.numeric(pwc_ss$Global_active_power) / 500
plot(pwc_ss$index, tempPWC, ylab="Global Active Power (kilowatts)",
     xlab="", xaxt="n", type="l", lwd=2)
axis(1, c(1,1440,2880), labels=c("Thurs", "Fri", "Sat") )

# Close the png device
dev.off()

# Remove the extra data
rm(pwc, pwc_ss, tempPWC)
