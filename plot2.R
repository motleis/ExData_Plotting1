library(sqldf)

## 1. file link to the household power consumption data
hpcFile <- file("household_power_consumption.txt")

## 2. load partial data using sqldf package
df <- sqldf("select * from hpcFile where Date like '1/2/2007%' OR Date like '2/2/2007%'", file.format=list(header=TRUE, sep = ";"))
table(df$Date)

## 3. Combine Date Time into Date and convert to 'Date' object
df$Date <- paste(df$Date ,  df$Time, sep = " ")
df$Date <- strptime(df$Date, format=c('%d/%m/%Y %H:%M:%S') )

## 4. Plot time series data with no x label and a y-label
# can also be removed and use dev.copy instead
png("plot2.png", width=480, height=480) 
plot(df$Date, df$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

## 5. Copy the histogram into PNG file device (defaults 480x480 pixels)
# dev.copy(png, "plot2.png")
dev.off()