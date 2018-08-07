#prepare data
file <- read.table(file = "household_power_consumption.txt", 
                   header=TRUE, sep=";", 
                   na.strings = "?")
library(dplyr)
data <- filter(file, Date == "1/2/2007" | Date == "2/2/2007")

data2 <- mutate(data, kilowatts = as.numeric(Global_active_power))
data3 <- data2 %>% 
  mutate(Datess = as.Date(Date, "%d/%m/%Y")) %>%
  mutate(totaltime = paste(Datess, Time))%>%
  mutate(completetime = as.POSIXct(strptime(totaltime, "%Y-%m-%d %H:%M:%S")))  

#plotting
png(filename = "plot3.png")
with(data3, plot(Sub_metering_1~completetime, type="n", xlab="", ylab="Energy sub metering"))
with(data3, lines(Sub_metering_1~completetime))
with(data3, lines(Sub_metering_2~completetime, col="red"))
with(data3, lines(Sub_metering_3~completetime, col="blue"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), 
       lwd=c(2,2,2), col=c("black", "red", "blue"))
dev.off()