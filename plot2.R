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

# Create plot2
png(filename = "plot2.png", width = 480, height = 480)
y_axis <- "Global Active Power (kilowats)"
x_axis <- ""
plot(data_sub[, "DateConverted"], data_sub[, "Global_active_power"], type = "l", xlab = x_axis, ylab = y_axis)
dev.off()