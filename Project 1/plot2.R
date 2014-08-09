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

active_power<-data.table(Date=db$Date,time=db$Time,ntime=as.numeric(difftime(strptime(paste(db$Date,db$Time),"%d/%m/%Y %H:%M:%S"),strptime(paste("01/02/2007","00:00:00"),"%d/%m/%Y %H:%M:%S"), units="days")),
                        npower=as.numeric(as.character(db$Global_active_power)),
                        weekname=substr(weekdays(strptime(paste(db$Date,db$Time),"%d/%m/%Y %H:%M:%S")),1,3))

##open png file
png(filename="plot2.png")


##start to plot
plot(active_power$ntime,active_power$npower,type="S",
     xlab="",
     ylab="Global Active Power(kilowatts)",
     xaxt="n")
     
axis(side = 1,  at=seq(0, 2, by=1),labels=c("Thr","Fri","Sat"))

##save as png
dev.off()

