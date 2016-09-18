
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

################################# Question 5 #########################################
# How have emissions from motor vehicle sources changed from 1999???2008 in Baltimore City?

sub <- subset(NEI, fips == "24510" & type=="ON-ROAD")
baltmot.sources <- aggregate(sub[c("Emissions")], list(type = sub$type, year = sub$year, zip = sub$fips), sum)

######################################################################################

################################## Ploting ###########################################
## Create Plot 5
qplot(year, Emissions, data = baltmot.sources, geom= "line") + theme_gray() + ggtitle("Motor Vehicle-Related Emissions in Baltimore County") + xlab("Year") + ylab("Emission Levels")

## Save file and close device
dev.copy(png,"plot5.png")
dev.off()
######################################################################################