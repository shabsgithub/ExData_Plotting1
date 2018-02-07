getwd()
plot4_in<-read.table("household_power_consumption.txt",header = TRUE, sep= ";")
plot4_in
head(plot4_in)
summary(plot4_in)
str(plot4_in)
# column names of the data
names(plot4_in)
# convert to date 
plot4_in$Date <- as.Date(plot4_in$Date,format="%d/%m/%Y")
str(plot4_in)
# subset the data 
filter_date4 <- subset(plot4_in, Date >= "2007-02-01" & Date <= "2007-02-02"  )
str(filter_date4)
head(filter_date4)
tail(filter_date4)
# concatenate date and time into one column "Both" and do the required conversion.

Both<- paste(filter_date4$Date,filter_date4$Time)
str(Both)
# paste creates BOTh as character.make required conversions.
filter_date4$Both <- as.POSIXct(Both)
str(filter_date4)
names(filter_date4)
#add this nw column to original data 
plot4_in <- filter_date4[,c(10,3:9)]
head(plot4_in)
summary(plot4_in)
str(plot4_in)
#convert call the required columns to numeric.
plot4_in$Global_active_power <- as.numeric(plot4_in$Global_active_power)
plot4_in$Global_reactive_power <- as.numeric(plot4_in$Global_reactive_power)
plot4_in$Voltage <- as.numeric(plot4_in$Voltage)
plot4_in$Sub_metering_1 <- as.numeric(plot4_in$Sub_metering_1)
plot4_in$Sub_metering_2 <- as.numeric(plot4_in$Sub_metering_2)
str(plot4_in)
head(plot4_in)

#get rid of ?
sapply(plot4_in$Sub_metering_1,function(f){is.na(f)<-which(f == "?");f})
sapply(plot4_in$Sub_metering_2,function(f){is.na(f)<-which(f == "?");f})

# Plot the 3nd graph
plot4<- plot(plot4_in$Global_active_power ~ plot4_in$Both ,ylab="Global Active Power",xlab="", type="l")
par(mfrow= c(2,2))
plot4<- plot(plot4_in$Global_active_power ~ plot4_in$Both ,ylab="Global Active Power",xlab="", type="l")
plot4<- plot(plot4_in$Voltage ~ plot4_in$Both ,ylab="Voltage",xlab="datetime", type="l")
plot4<- plot(plot4_in$Sub_metering_1 ~ plot4_in$Both ,ylab="Energy Sub Metering",xlab="", type="l")
lines(plot4_in$Sub_metering_2 ~ plot4_in$Both ,col="Red", type="l")
lines(plot4_in$Sub_metering_3 ~ plot4_in$Both ,col="Blue", type="l")
legend("topright",col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)
plot4<- plot(plot4_in$Global_reactive_power ~ plot4_in$Both ,ylab="Global_reactive_power",xlab="", type="l")

#copy to png
dev.copy(png,file="plot4.png")
dev.off() 