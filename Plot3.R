temp<-tempfile()
if(!file.exists("./data")){dir.create("./data")}
fileUrl<-"https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
download.file(fileUrl, temp, method="curl")
Power<-read.table(unzip(temp), sep=";", header=T)


#converting global active power column from type factor to numeric. 
# dates are converted into the same format for the required date (1-02, 2-02)
# and Power$Date, the data from the selected dates are stored in a new file Power
# for this we used paste function, which concatenate vectrs after converting it to character 
#vector. The strtime converts to Posixct and is stored as Power2$combine. 

library(lubridate)

Power$Date<-dmy(Power$Date)
Date1<-dmy("01-02-2007")
Date2<-dmy("02-02-2007")
Power2<-Power[(Power$Date>=Date1 & Power$Date<=Date2),]
Power2$combine<-as.POSIXct(strptime(paste(Power2$Date, Power2$Time), "%Y-%m-%d %H:%M:%S"))
Power2$Global_active_power<-(as.numeric(as.character(Power2$Global_active_power)))

#Power2$sub_metering_(1,2,3) is created after converting these factor types to numeric

Power2$Sub_metering_3<-(as.numeric(as.character(Power2$Sub_metering_3)))
Power2$Sub_metering_2<-(as.numeric(as.character(Power2$Sub_metering_2)))
Power2$Sub_metering_1<-(as.numeric(as.character(Power2$Sub_metering_1)))

# a new png file is opened and Power$combine is plotted againt the sub metering reading
#png device is closed. 

png(filename = "Plot3.png", width = 480, height = 480, pointsize = 12, bg = "white")
plot(Power2$combine, Power2$Sub_metering_1, type="l", ylab="Energy Sub Metering", xlab=" ")
lines(Power2$combine, Power2$Sub_metering_2, type="l", col='red')
lines(Power2$combine, Power2$Sub_metering_3, type="l", col='blue')
legend("topright", lwd=2, col = c("black", "blue", "red"), legend = c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"))
dev.off()
