
##################### save original working directory ################################
Ori_WD <- getwd()
######################################################################################

######################### Download file and unzip ####################################
filename <- "exdata%2Fdata%2FNEI_data.zip"

if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(fileURL, filename, method="libcurl")
}  
if (!file.exists("Source_Classification_Code.rds")) { 
        unzip(filename) 
}
if (!file.exists("summarySCC_PM25.rds")) { 
        unzip(filename) 
}
######################################################################################


################################ read the files ######################################
## This first line will likely take a few seconds. Be patient! 
if("summarySCC_PM25.rds" %in% dir()){ 
        NEI <- readRDS("./summarySCC_PM25.rds") 
} 
if("Source_Classification_Code.rds" %in% dir()){ 
        SCC <- readRDS("./Source_Classification_Code.rds") 
} 
######################################################################################

################################# Question 1 #########################################
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all
# sources for each of the years 1999, 2002, 2005, and 2008.

EmmissionsByYear <- aggregate(Emissions ~ year, NEI, sum) 

######################################################################################

################################## Ploting ###########################################
## Create Plot 1
plot(EmmissionsByYear, type = "o", main = "Total PM2.5 Emissions", xlab = "Year", ylab = "PM2.5 Emissions", pch = 19, col = "darkblue", lty = 6)
## Save file and close device
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()
######################################################################################