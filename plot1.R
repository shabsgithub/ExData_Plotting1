#get working directory
getwd()
#read the .xt file seperated by ;
actual_file <- read.csv2(file.choose()
                         )
# print the first 6 rows 
head(actual_file)
summary(actual_file)

str(actual_file)
# stripping the dates
dates_filter1<- subset(actual_file, Date == "2/1/2007")
dates_filter1
dates_filter2<- subset(actual_file, Date == "2/2/2007")
dates_filter2
head(dates_filter1)
head(dates_filter2)
#merge 2 data frames by "Date",,(Did not work)
dates_filter<- merge(dates_filter1,dates_filter2,by ="Date")
dates_filter

combine_dates <- rbind(dates_filter1,dates_filter2)
combine_dates
head(combine_dates)
str(combine_dates)
summary(combine_dates)

# preare first plot 

plot1_data <- combine_dates[Global_active_power]
head(plot1_data)
summary(plot1_data)
Global_Active_Power <- as.numeric(plot1_data)
sapply(Global_Active_Power, function(f){is.na(f)<-which(f == "?");f})
plot1 <- hist(Global_Active_Power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
              
plot1
dev.copy(png,file="plot1.png")
dev.off()  
  
 