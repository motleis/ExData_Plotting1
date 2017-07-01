library(sqldf)

## 1. file link to the household power consumption data
hpcFile <- file("household_power_consumption.txt")

## 2. load partial data using sqldf package
df <- sqldf("select * from hpcFile where Date like '1/2/2007%' OR Date like '2/2/2007%'", file.format=list(header=TRUE, sep = ";"))
table(df$Date)

## 3. Combine Date Time into Date and convert to 'Date' object
df$Date <- paste(df$Date ,  df$Time, sep = " ")
df$Date <- strptime(df$Date, format=c('%d/%m/%Y %H:%M:%S') )

## 4. Plot red histogram with x label and title
hist(df$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

## 5. Copy the histogram into PNG file device
dev.copy(png, "plot1.png", width=480, height=480)
dev.off()