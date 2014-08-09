setwd("E:/Course/Johns hopkins_Data Science/Exploratory Data Analysis/Project 1/")
path=getwd()
##Unzip the file.
f="exdata_data_household_power_consumption.zip"
executable <- file.path("C:", "Program Files (x86)", "7-Zip", "7z.exe")
parameters <- "x"
cmd <- paste(paste0("\"", executable, "\""), parameters, paste0("\"", file.path(path,                                                                                 f), "\""))
system(cmd)



##read data
f="household_power_consumption.txt"
data<-read.table(f,sep=";",header = TRUE)
nrow(data)
## extract date= 2007-02-01 and 2007-02-02 assigned to db
db<-data[as.Date(data$Date,"%d/%m/%Y")==as.Date("2007-02-01") |as.Date(data$Date,"%d/%m/%Y")==as.Date("2007-02-02"),]
colnames(db)


##Plot 2 the acmount of Global_active_power on Thu, Fri and Sat
library("data.table")
library("lattice")
Sys.setlocale("LC_TIME", "English")
ntime=as.numeric(difftime(strptime(paste(db$Date,db$Time),"%d/%m/%Y %H:%M:%S"),strptime(paste("01/02/2007","00:00:00"),"%d/%m/%Y %H:%M:%S"), units="days"))
meter1<-data.table(ntime,ncat='Sub_metering_1',nmeter=as.numeric(as.character(db$Sub_metering_1)))
meter2<-data.table(ntime,ncat='Sub_metering_2',nmeter=as.numeric(as.character(db$Sub_metering_2)))
meter3<-data.table(ntime,ncat='Sub_metering_3',nmeter=as.numeric(as.character(db$Sub_metering_3)))
meter<-rbind(meter1,meter2,meter3)

##open png file
png(filename="plot3.png")


##start to plot
with(meter, plot(ntime, nmeter, type = "S",
                 xlab="",
                 ylab="Energy Sub metering",
                 xaxt="n"))
with(subset(meter, ncat=='Sub_metering_1'), points(ntime, nmeter, col = "grey",type = "S"))
with(subset(meter, ncat=='Sub_metering_2'), points(ntime, nmeter, col = "red",type = "S"))
with(subset(meter, ncat=='Sub_metering_3'), points(ntime, nmeter, col = "blue",type = "S"))   
axis(side = 1,  at=seq(0, 2, by=1),labels=c("Thr","Fri","Sat"))
legend("topright", lwd=1, lty=1,  merge=FALSE, 
       col = c("grey", "red","blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex=0.6)


##save as png
dev.off()

