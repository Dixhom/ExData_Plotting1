## import data
url = "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename = "household_power_consumption.zip"
download.file(url, filename)
unzip(filename, overwrite = T)
require(data.table)
# the sampling rate is one-minute. data over 2 days required. thus 60*24*2.
data <- fread("household_power_consumption.txt", sep=";", skip="1/2/2007", nrows=60*24*2)

## fix data
setnames(data, c("date", "time", "active_power", "reactive_power", "voltage", "intensity", "sub1", "sub2", "sub3"))

## make plot and export as a png file
png(file = "plot1.png", width=480, height=480)

# [Solving a wrong x-label issue due to a difference locale]
# save current system's locale
locale <- Sys.getlocale(category = "LC_TIME")
# set English locale in order to have labels printed in English
Sys.setlocale("LC_TIME", locale = "English")

hist(data$active_power, col = "#FF2500", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")

# restore system's original locale
Sys.setlocale("LC_TIME", locale)

dev.off()




