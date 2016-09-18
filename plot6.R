
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

################################# Question 6 #########################################
# Compare emissions from motor vehicle sources in Baltimore City with emissions from
# motor vehicle sources in Los Angeles County, California (fips == "06037"). Which 
# city has seen greater changes over time in motor vehicle emissions?

sub <- subset(NEI, fips == "06037" & type=="ON-ROAD")
lamot.sources <- aggregate(sub[c("Emissions")], list(type = sub$type, year = sub$year, zip = sub$fips), sum)
comp.mv <- rbind(baltmot.sources, lamot.sources)

######################################################################################

################################## Ploting ###########################################
## Create Plot 6
qplot(year, Emissions, data = comp.mv, color = zip, geom= "line", ylim = c(-100, 5500)) + ggtitle("Motor Vehicle Emissions in Baltimore (24510) \nvs. Los Angeles (06037) Counties") + xlab("Year") + ylab("Emission Levels")

## Save file and close device
dev.copy(png,"plot6.png")
dev.off()
######################################################################################