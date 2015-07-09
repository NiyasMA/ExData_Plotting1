#The downloading and reading of the file is similar to previous Plot, plot1.R
temp<-tempfile()
if(!file.exists("./data")){dir.create("./data")}
fileUrl<-"https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
download.file(fileUrl, temp, method="curl")
Power<-read.table(unzip(temp), sep=";", header=T)


#converting global active power column from type factor to numeric. 
# dates are converted into the same format for the required date (1-02, 2-02)
# and Power$Date, the data from the selected dates are stored in a new file Power
#Histogram is drawn using the global active Power is plotted againts time.
# for this we used paste function, which concatenate vectrs after converting it to character 
#vector. The strtime converts to Posixct and is stored as Power2$combine. 
#after opening a Png file, which is closed  after plotting. 
library(lubridate)
Power$Date<-dmy(Power$Date)
Date1<-dmy("01-02-2007")
Date2<-dmy("02-02-2007")
Power2<-Power[(Power$Date>=Date1 & Power$Date<=Date2),]

Power2$combine<-as.POSIXct(strptime(paste(Power2$Date, Power2$Time), "%Y-%m-%d %H:%M:%S"))

Power2$Global_active_power<-(as.numeric(as.character(Power2$Global_active_power)))

png(filename = "Plot2.png", width = 480, height = 480, pointsize = 12, bg = "white")
plot(Power2$combine, Power2$Global_active_power, type="l",  ylab="Global Active Power (kilowatts)", xlab=" ", main=" ")
dev.off()
