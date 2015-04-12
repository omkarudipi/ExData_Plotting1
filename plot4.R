#assumes working directory is set

#read whole source table into dataframe assign1
assign1 <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

#copy subset of assign1 (1/2/2007 and 2/2/2007) to assign1sub
assign1sub <- assign1[which(assign1$Date=="1/2/2007" | assign1$Date=="2/2/2007"),]

#update values in Date column to convert string to Date
assign1sub$Date <- as.Date(assign1sub$Date, "%d/%m/%Y")

#update values in Time column to convert string to Time
assign1sub$Time <- strptime(
    paste(assign1sub$Date, assign1sub$Time, sep=" "), 
    "%Y-%m-%d %H:%M:%S")


#update values in Global_active_power column to convert string to numeric
assign1sub$Global_active_power <- as.numeric(assign1sub$Global_active_power)

#update values in Global_reactive_power column to convert string to numeric
assign1sub$Global_reactive_power <- as.numeric(assign1sub$Global_reactive_power)

#update values in Voltage column to convert string to numeric
assign1sub$Voltage <- as.numeric(assign1sub$Voltage)

#update values in Sub_metering_1, Sub_metering_2, Sub_metering_3 columns to convert string to numeric
assign1sub$Sub_metering_1 <- as.numeric(assign1sub$Sub_metering_1)
assign1sub$Sub_metering_2 <- as.numeric(assign1sub$Sub_metering_2)
assign1sub$Sub_metering_3 <- as.numeric(assign1sub$Sub_metering_3)

#generate plot4.png file, compare with assignment
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(assign1sub$Time, assign1sub$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(assign1sub$Time, assign1sub$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(assign1sub$Time, assign1sub$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(assign1sub$Time, assign1sub$Sub_metering_2, type="l", col="red")
lines(assign1sub$Time, assign1sub$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="n")

plot(assign1sub$Time, assign1sub$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()