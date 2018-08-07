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
png(filename = "plot2.png")
with(data3, plot(kilowatts~completetime, type="l",
                 xlab = "", ylab = "Global Active Power(kilowatts)"))
dev.off()