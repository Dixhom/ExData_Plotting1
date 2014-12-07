## import data

url = "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename = "household_power_consumption.zip"
download.file(url, filename)
unzip(filename, overwrite = T)
# the sampling rate is one-minute. data over 2 days required. thus 60*24*2.
require(data.table)
data <- fread("household_power_consumption.txt", sep=";", skip="1/2/2007", nrows=60*24*2)

## clean data
setnames(data, c("date", "time", "active_power", "reactive_power", "voltage", "intensity", "sub1", "sub2", "sub3"))
# since data.frame doesn't suppport POSIXlt object, make a independent time vector
datetime <- as.POSIXct(strptime(paste(data$date, data$time), "%d/%m/%Y %H:%M:%S"))


## make plot and export as a png file
png(file = "plot3.png", width=480, height=480)

# [Solving a wrong x-label issue due to a difference locale]
# save current system's locale
locale <- Sys.getlocale(category = "LC_TIME")
# set English locale in order to have labels printed in English
Sys.setlocale("LC_TIME", locale = "English")

color = c("black", "red", "blue")
leg = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
plot(datetime, data$sub1, xlab="", ylab="Energy sub metering", type="n")
lines(datetime, data$sub1, col= color[1], type="l")
lines(datetime, data$sub2, col= color[2], type="l")
lines(datetime, data$sub3, col= color[3], type="l")
legend("topright", col=color, lty=c(1,1), legend=leg)

## restore system's original locale
Sys.setlocale("LC_TIME", locale)

dev.off()
