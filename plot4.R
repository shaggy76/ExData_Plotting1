# Get current working directory.
current_dir <- getwd()

# Set Data File.  Comressed data should be extracted to the current working directory and sit in
# default folder created during extraction
file <- paste(current_dir, "/exdata-data-household_power_consumption/household_power_consumption.txt", sep = "")

# Read data
data <- read.table(file, header = TRUE, sep = ";", nrows = -1, na.strings = "?")

# Add converted date column to data
names <- c("DateConverted", colnames(data))
data <- cbind(strptime(paste(data[, "Date"], data[, "Time"], sep = " "), format = "%d/%m/%Y %H:%M:%S"), data)
colnames(data) <- names

# subset the data to isolate specific dates
start_date <- as.POSIXct("2007-02-01")
end_date <- as.POSIXct("2007-02-03")
data_sub <- subset(data, DateConverted >= start_date & DateConverted < end_date)

# Create plot4
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

# Add top left plot
y_axis <- "Global Active Power"
x_axis <- ""
plot(data_sub[, "DateConverted"], data_sub[, "Global_active_power"], type = "l", xlab = x_axis, ylab = y_axis)
box(which = "plot", col = "grey")

# Add top right plot
y_axis <- "Voltage"
x_axis <- "datetime"
plot(data_sub[, "DateConverted"], data_sub[, "Voltage"], type = "l", xlab = x_axis, ylab = y_axis)
box(which = "plot", col = "grey")

# Add bottom left plot
y_axis <- "Energy sub metering"
x_axis <- ""
series <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
series_colors <- c("black", "red", "blue")
plot(data_sub[, "DateConverted"], data_sub[, "Sub_metering_1"], type = "l", xlab = x_axis, ylab = y_axis, col = "black")
box(which = "plot", col = "grey")
lines(data_sub[, "DateConverted"], data_sub[, "Sub_metering_2"], col = "red")
lines(data_sub[, "DateConverted"], data_sub[, "Sub_metering_3"], col = "blue")
legend("topright", series, col = series_colors, lty = c(1, 1, 1), bty = "n")

# Add bottom right plot
y_axis <- "Global_reactive_power"
x_axis <- "datetime"
plot(data_sub[, "DateConverted"], data_sub[, "Global_reactive_power"], type = "l", xlab = x_axis, ylab = y_axis)
box(which = "plot", col = "grey")

dev.off()