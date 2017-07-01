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
png("plot3.png", width=480, height=480)
plot(df$Date, df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(df$Date, df$Sub_metering_2, type="l", col="red")
lines(df$Date, df$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") , lty=1, col=c("black", "red", "blue") )
dev.off()