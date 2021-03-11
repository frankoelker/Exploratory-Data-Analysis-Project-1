plot1 <- function() {
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
  png("plot1.png", width = 480, height = 480)
  hist(mydata$Global_active_power, main = "Global Active Power", col = "red", 
       xlab = "Global Active Power (kilowatts)")
  dev.off()
  print("plot1.png created")
}                        

