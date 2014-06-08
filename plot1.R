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

# Create plot1
png(filename = "plot1.png", width = 480, height = 480)
x_axis <- "Global Active Power (kilowats)"
y_axis <- "Frequency"
title <- "Global Active Power"
color = "red"
ticks <- c(0, 1200, 6)
hist(data_sub[, "Global_active_power"], main = title, xlab = x_axis, ylab = y_axis, col = color, yaxp = ticks)
dev.off()