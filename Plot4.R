temp<-tempfile()
if(!file.exists("./data")){dir.create("./data")}
fileUrl<-"https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
download.file(fileUrl, temp, method="curl")
Power<-read.table(unzip(temp), sep=";", header=T)

library(lubridate)

Power$Date<-dmy(Power$Date)
Date1<-dmy("01-02-2007")
Date2<-dmy("02-02-2007")
Power2<-Power[(Power$Date>=Date1 & Power$Date<=Date2),]
Power2$combine<-as.POSIXct(strptime(paste(Power2$Date, Power2$Time), "%Y-%m-%d %H:%M:%S"))
Power2$Global_active_power<-(as.numeric(as.character(Power2$Global_active_power)))

Power2$Sub_metering_3<-(as.numeric(as.character(Power2$Sub_metering_3)))
Power2$Sub_metering_2<-(as.numeric(as.character(Power2$Sub_metering_2)))
Power2$Sub_metering_1<-(as.numeric(as.character(Power2$Sub_metering_1)))

png(filename = "Plot4.png", width = 480, height = 480, pointsize = 12, bg = "white")
par(mfrow=c(2,2))
Power2$Global_active_power<-(as.numeric(as.character(Power2$Global_active_power)))
plot(Power2$combine, Power2$Global_active_power, type="l", xlab=" ", ylab=" Global Active Power")
Power2$Voltage<-(as.numeric(as.character(Power2$Voltage)))
plot(Power2$combine, Power2$Voltage, type="l", xlab="datetime", ylab="Voltage")
Power2$Sub_metering_3<-(as.numeric(as.character(Power2$Sub_metering_3)))
Power2$Sub_metering_2<-(as.numeric(as.character(Power2$Sub_metering_2)))
Power2$Sub_metering_1<-(as.numeric(as.character(Power2$Sub_metering_1)))

plot(Power2$combine, Power2$Sub_metering_1, type="l", ylab="Energy Sub Metering", xlab=" ")
lines(Power2$combine, Power2$Sub_metering_2, type="l", col='red')
lines(Power2$combine, Power2$Sub_metering_3, type="l", col='blue')
legend("topright", lwd=2, col = c("black", "blue", "red"), legend = c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"))

Power2$Global_reactive_power<-(as.numeric(as.character(Power2$Global_reactive_power)))
plot(Power2$combine, Power2$Global_reactive_power, type="l", ylab="Global Reactive Power", xlab=" datetime")
dev.off()

# Note I am not attaching the .txt file for the assignmnet as I am commetting since the file is 133MB!. 