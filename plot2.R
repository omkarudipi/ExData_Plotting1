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

#generate plot2.png file, compare with assignment
png("plot2.png", width=480, height=480)
plot(assign1sub$Time, assign1sub$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
