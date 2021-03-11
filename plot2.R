plot2 <- function() {
  ## R-Script for Coursera - Exploratory Data Analysis - Project 1
  ## This script:
  ## - downloads the needed zip-file if it does not exist
  ## - extracts the file if it does not exist
  ## - subsets the data for 2007-02-01 and 2007-02-02
  ## - plots the data in a PNG file
  print("Running...Please Wait")
  if(!is.element("sqldf", installed.packages()[,1])){
    install.packages('sqldf')
  } 
  library(sqldf)
  dataFileTxt <- "household_power_consumption.txt"
  if(!file.exists(dataFileTxt)) {
    dataFileZip <- "household_power_consumption.zip"
    zipURL <- paste0("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2F",
                     "household_power_consumption.zip")
    download.file(zipURL, destfile = dataFileZip)
    unzip(dataFileZip)
  } 
  sql <- paste0("select * from file where Date = '1/2/2007' or ",
                "Date = '2/2/2007'")
  mydata <- read.csv.sql(dataFileTxt, sql = sql, sep = ";")
  ## create a new column with the value of Date and Time and add it to mydata 
  datetime <- strptime(paste(mydata$Date, mydata$Time, sep = " "), 
                       "%d/%m/%Y %H:%M:%S")
  mydata <- cbind(mydata, datetime)
  ## change the language, because my default is german
  Sys.setlocale("LC_ALL", "English")
  png("plot2.png", width = 480, height = 480)
  ## change the margins so the ylabel fits
  par(mar = c(5, 7, 4, 1))
  plot(mydata$datetime, mydata$Global_active_power, type = "l", 
       ylab = "Global Active Power (kilowatts)", xlab = NA)
  dev.off()
  print("plot2.png created")
}                        

