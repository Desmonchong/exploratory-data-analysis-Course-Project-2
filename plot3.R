
##################### save original working directory ################################
Ori_WD <- getwd()
######################################################################################

############################### test package #########################################
list.of.packages <- c("ggplot2")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
lapply(list.of.packages, require, character.only = TRUE)
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

################################# Question 3 #########################################
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999-2008
# for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the
# ggplot2 plotting system to make a plot answer this question.

EmmissionsInBaltimoreByYearAndType <- aggregate(Emissions ~ year + type, NEI[NEI$fips=="24510", ], sum)

######################################################################################

################################## Ploting ###########################################
## Create Plot 3
g <- ggplot(EmmissionsInBaltimoreByYearAndType, aes(year, Emissions, color = type)) 
g + geom_line() + xlab("year") + ylab(expression('Total PM'[2.5]*" Emissions")) + ggtitle('Total Emissions in Baltimore City, Maryland (fips == "24510") from 1999 to 2008') 

## Save file and close device
dev.copy(png,"plot3.png")
dev.off()
######################################################################################