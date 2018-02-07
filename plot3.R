getwd()
plot3_in<-read.table("household_power_consumption.txt",header = TRUE, sep= ";")
plot3_in
head(plot3_in)
summary(plot3_in)
str(plot3_in)
# column names of the data
names(plot3_in)

#convert to date 
plot3_in$Date <- as.Date(plot3_in$Date, format = "%d/%m/%Y")

head(plot3_in)
str(plot3_in)
# subset the data 
filter_date3 <- subset(plot3_in, Date >= "2007-02-01" & Date <= "2007-02-02"  )
str(filter_date3)
head(filter_date3)
tail(filter_date3)
# concatenate date and time into one column "Both" and do the required conversion.

Both<- paste(filter_date3$Date,filter_date3$Time)
str(Both)
# paste creates BOTh as character.make required conversions.
filter_date3$Both <- as.POSIXct(Both)
str(filter_date3)
names(filter_date3)
# Add this new column to the original data 

plot3_in <- filter_date3[,c(10,3:9)]
plot3_in
head(plot3_in)
names(plot3_in)
str(plot3_in)
#convert the remaning 2 submetering columns to numeric
plot3_in$Sub_metering_1 <- as.numeric(plot3_in$Sub_metering_1)
plot3_in$Sub_metering_2 <- as.numeric(plot3_in$Sub_metering_2)
str(plot3_in)
tail(plot3_in)
#get rid of ?
sapply(plot3_in$Sub_metering_1,function(f){is.na(f)<-which(f == "?");f})
sapply(plot3_in$Sub_metering_2,function(f){is.na(f)<-which(f == "?");f})

# Plot the 3nd graph
plot3<- plot(plot3_in$Sub_metering_1 ~ plot3_in$Both, ylab="Energy sub metering",xlab ="" , type = "l")
lines(plot3_in$Sub_metering_2 ~ plot3_in$Both, col="Red")
lines(plot3_in$Sub_metering_3 ~ plot3_in$Both, col="Blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)

dev.copy(png,file="plot3.png")
dev.off() 


