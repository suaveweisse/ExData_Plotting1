energy <-read.csv("household_power_consumption.txt", stringsAsFactors = F, sep = ";")
energy$Date <- as.Date(dmy(energy$Date))
energy$datetime <- as.POSIXct(paste(energy$Date,energy$Time), format = "%Y-%m-%d %H:%M:%S")
energy$Global_active_power <- as.numeric(energy$Global_active_power)
energy$Global_reactive_power <- as.numeric(energy$Global_reactive_power)
energy$Voltage <- as.numeric(energy$Voltage)
energy$Global_intensity <- as.numeric(energy$Global_intensity)
energy$Sub_metering_1 <- as.numeric(energy$Sub_metering_1)
energy$Sub_metering_2 <- as.numeric(energy$Sub_metering_2)
energy$Sub_metering_3 <- as.numeric(energy$Sub_metering_3)
ene <- subset(energy, Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")))

xstart <- as.POSIXct("2007-02-01 00:00:01")
xend <- as.POSIXct("2007-02-03 00:00:01")

## Graphics object
png("plot4.png", 480, 480)

## Make plots
par(mfrow = c(2,2))

## Plot 1
with(ene, plot(datetime, Global_active_power, type = "n", xlab = "", ylab = "Global Active Power", xlim = c(xstart, xend)))
with(ene, lines(datetime, Global_active_power))

## Plot 2
with(ene, plot(datetime, Voltage, type = "n", xlab = "datetime", ylab = "Voltage", xlim = c(xstart, xend)))
with(ene, lines(datetime, Voltage))

## Plot 3
with(ene, plot(datetime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering", xlim = c(xstart, xend)))
with(ene, lines(datetime, Sub_metering_1, col = "black"))
with(ene, lines(datetime, Sub_metering_2, col = "red"))
with(ene, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", lty = c(1,1,1), ltm(1,1,1), col = c("black","red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       bty = "n")

## Plot 4
with(ene, plot(datetime, Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power", 
               xlim = c(xstart, xend)))
with(ene, lines(datetime, Global_reactive_power))
dev.off()