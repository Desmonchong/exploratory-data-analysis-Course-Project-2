
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

################################# Question 4 #########################################
# Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999-2008?

SCC.sub <- SCC[grepl("Coal" , SCC$Short.Name), ]
NEI.sub <- NEI[NEI$SCC %in% SCC.sub$SCC, ]

######################################################################################

################################## Ploting ###########################################
## Create Plot 4
ggplot(NEI.sub, aes(x = factor(year), y = Emissions, fill =type)) + geom_bar(stat= "identity", width = .4) + xlab("year") +ylab("Coal-Related PM2.5 Emissions") + ggtitle("Total Coal-Related PM2.5 Emissions")

## Save file and close device
dev.copy(png,"plot4.png")
dev.off()
######################################################################################