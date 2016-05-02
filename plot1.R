# Create the appropriate subsetof data 
pwc <- read.csv("household_power_consumption.txt", sep=";")
pwc_ss <- subset(pwc, pwc$Date == "1/2/2007" | pwc$Date == "2/2/2007")

# Set the ploting device to a PNG file
png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", type ="windows")

# Multiple plot parameters, in case they're not c(1,1)
par(mfrow=c(1,1) )

# Create the histogram for Plot#1
tempPWC <- as.numeric(pwc_ss$Global_active_power) / 500 # Scalig doesn't quite make sense here...
hist(tempPWC, xlab = "Global Active Power (kilowatts)", ylab="Frequency", col="red",
     main="Global Active Power")

# Close the png device
dev.off()

# Remove the extra data
rm(pwc, pwc_ss, tempPWC)
