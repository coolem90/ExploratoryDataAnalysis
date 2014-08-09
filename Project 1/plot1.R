setwd("E:/Course/Johns hopkins_Data Science/Exploratory Data Analysis/Project 1/")
path=getwd()
##Unzip the file.
f="exdata_data_household_power_consumption.zip"
executable <- file.path("C:", "Program Files (x86)", "7-Zip", "7z.exe")
parameters <- "x"
cmd <- paste(paste0("\"", executable, "\""), parameters, paste0("\"", file.path(path, 
                                                                                f), "\""))
system(cmd)



##read data
f="household_power_consumption.txt"
data<-read.table(f,sep=";",header = TRUE)
nrow(data)
## extract date= 2007-02-01 and 2007-02-02 assigned to db
db<-data[as.Date(data$Date,"%d/%m/%Y")==as.Date("2007-02-01") |as.Date(data$Date,"%d/%m/%Y")==as.Date("2007-02-02"),]
colnames(db)

##Plot 1 the frequency of Global_active_power
active_power<-as.numeric(as.character(db$Global_active_power))
hist(active_power, col = "red",main="Global Active Power",xlab="Global Active Power(kilowatts)")

##save as png
png(filename="plot1.png")
hist(active_power, col = "red",main="Global Active Power",xlab="Global Active Power(kilowatts)")
dev.off()
