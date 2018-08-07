#prepare data
file <- read.table(file = "household_power_consumption.txt", 
                   header=TRUE, sep=";", 
                   na.strings = "?")
library(dplyr)
data <- filter(file, Date == "1/2/2007" | Date == "2/2/2007")

data2 <- mutate(data, kilowatts = as.numeric(Global_active_power))
ingredient <- data2$kilowatts

#plotting
png(filename = "plot1.png")
hist(ingredient, col = "red",
     xlab = "Global Active Power(kilowatts)", 
     main = "Global Active Power")
dev.off()
