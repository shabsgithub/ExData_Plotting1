getwd()
plot2_in<-read.table("household_power_consumption.txt",header = TRUE, sep= ";")
plot2_in
head(plot2_in)
summary(plot2_in)
str(plot2_in)
# column names of the data
names(plot2_in)
# find the class of the attributes
lapply(plot2_in$Date,class)
lapply(plot2_in$Time,class)

#convert to date 
plot2_in$Date <- as.Date(plot2_in$Date, format = "%d/%m/%Y")

head(plot2_in)

filter_date1 <- subset(plot2_in, Date >= "2007-02-01" & Date <= "2007-02-02"  )
str(filter_date1)
head(filter_date1)

# concatenate date and time into one column "Both" and do the required conversion.
Both<- paste(filter_date1$Date,filter_date1$Time)
str(Both)

filter_date1$Both <- as.POSIXct(Both)
str(filter_date1)
# Add this new column to the original data 

plot2_in <- filter_date1[,c(10,3:9)]
plot2_in
head(plot2_in)
names(plot2_in)
str(plot2_in)

# get rid of ? in global active power column
plot2_in$Global_active_power <- as.numeric(plot2_in$Global_active_power)
sapply(plot2_in$Global_active_power , function(f){is.na(f)<-which(f == "?");f})
str(plot2_in)

# Plot the 2nd graph
plot2<- plot(plot2_in$Global_active_power ~ plot2_in$Both, ylab="Global Active Power (kilowatts)",xlab ="" , type = "l")
dev.copy(png,file="plot2.png")
dev.off() 


