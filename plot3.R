url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "power.zip")
unzip("power.zip", exdir="power")
input<-read.csv2("power/household_power_consumption.txt", stringsAsFactors = FALSE)

input2<-tbl_df(input)
input3<-mutate(input2, Date2=as.Date(dmy(input2$Date)))
input4<-mutate(input3, DT=paste(input3$Date2,input3$Time,sep=" "))
input5<-filter(input4, input4$Date2=="2007-02-01"|input4$Date2=="2007-02-02")

par(mfrow=c(1,1))
y<-max(as.numeric(input5$Sub_metering_1))
plot(ymd_hms(input5$DT), as.numeric(input5$Global_active_power), type="n", xlab = "", ylab="Energy sub metering", ylim = c(0,y))
points(ymd_hms(input5$DT), as.numeric(input5$Sub_metering_1), col="black", type="l", yaxs="r")
points(ymd_hms(input5$DT), as.numeric(input5$Sub_metering_2), col="red", type="l", yaxs="r")
points(ymd_hms(input5$DT), as.numeric(input5$Sub_metering_3), col="blue", type="l", yaxs="r")
legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.copy(png, file="plot3.png")
dev.off()