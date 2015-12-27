##This script is for Assignment Two of the coursera Data Science Specialization course "Getting and Cleaning Data"
#The purpose of this project is to demonstrate the student's ability to collect, work with, and clean a data set.
##The goal is to prepare tidy data that can be used for later analysis.
##Detail instruction of the project can be found in the README.MD file.

## Since this script downloads the dataset directly from web, it should work fine without having 
## the dataset already available in your working directory.
############################################################################

#### Part A: Prepare working environment.
        ## Set your working directory to a directory of your choice (if you prefer not to run this script
        ## in your current working directory)

#### Part B: Getting data, extracting and setting up folder structure

#Get the data from the web

        library(httr) 
        url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        file <- "rawdataset.zip"
        if(!file.exists(file)){
                print("downloading...")
                download.file(url, file, method="curl")
        }

##create folder and extract the zipped file into it.

        datafolder <- "UCI HAR Dataset"
        resultsfolder <- "results"
        if(!file.exists(datafolder)){
                print("Exracting file ....")
                unzip(file, list = FALSE, overwrite = TRUE)
        } 
        ## create folder to be used to store output
        if(!file.exists(resultsfolder)){
                print("create results folder")
                dir.create(resultsfolder)
        } 

#### Part C: Write functions needed for working on the project questions
        
#function to create a data frame from a file
        gettables <- function (filename,cols = NULL){
                print(paste("Converting to table:", filename))
                f <- paste(datafolder,filename,sep="/")
                data <- data.frame()
                if(is.null(cols)){
                        data <- read.table(f,sep="",stringsAsFactors=F)
                } else {
                        data <- read.table(f,sep="",stringsAsFactors=F, col.names= cols)
                }
                data
        }        
        
        
#convert features.txt file to table to test gettables()
        features <- gettables("features.txt")

        ## str(features) ## data.frame': 561 obs. of  2 variables:

#function to read data 
        getdata <- function(type, features){
                print(paste("Getting data", type))
                subject_data <- gettables(paste(type,"/","subject_",type,".txt",sep=""),"id")
                y_data <- gettables(paste(type,"/","y_",type,".txt",sep=""),"activity")
                x_data <- gettables(paste(type,"/","X_",type,".txt",sep=""),features$V2)
                return (cbind(subject_data,y_data,x_data))
        }                
        
## test getdata()
        test <- getdata("test", features)
        train <- getdata("train", features)

        ## str(test) ## 'data.frame':2947 obs. of  563 variables
        ## str(train) ## 'data.frame':7352 obs. of  563 variables

#function to save the output data into the results folder (in .CSV)
        saveresults <- function (data,name){
                print(paste("saving results:", name))
                file <- paste(resultsfolder, "/", name,".csv" ,sep="")
                write.csv(data,file)
        }        

#function to save the output data into the results folder (in .TXT, tab delimited with row.name=FALSE)
        saveresultsTXT <- function (data,name){
                print(paste("saving results:", name))
                file <- paste(resultsfolder, "/", name,".txt" ,sep="")
                write.table(data,file, row.name=FALSE)
        }          
                
#### Part D: Work on the five project questions

## Question #1: Merges the training and the test data sets to create one data set.
        ##using rbind() to merge and arrange() to order by id
        library(plyr)
        data <- rbind(train, test)
        data <- arrange(data, id)        
      
## Question #2: Extracts only the measurements on the mean and standard deviation for each measurement. 
        ##subset the data
        mean_and_std <- data[,c(1,2,grep("std", colnames(data)), grep("mean", colnames(data)))]
        ##save the resulting dataset
        saveresults(mean_and_std,"mean_and_std")  

## Question #3: Uses descriptive activity names to name the activities in the data set
        activity_labels <- gettables("activity_labels.txt")
        
## Question #4: Appropriately labels the data set with descriptive variable names. 
        data$activity <- factor(data$activity, levels=activity_labels$V1, labels=activity_labels$V2)
        
## Question #5: Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
        ## tidy_dataset is the tidy data we are looking for.
        tidy_dataset <- ddply(mean_and_std, .(id, activity), .fun=function(x){ colMeans(x[,-c(1:2)]) })
        colnames(tidy_dataset)[-c(1:2)] <- paste(colnames(tidy_dataset)[-c(1:2)], "_mean", sep="")
        
        ### to save in .CSV format use saveresults()
        saveresults(tidy_dataset,"tidy_dataset")
        
        ## to save in .TXT format use saveresultsTXT()
        saveresultsTXT(tidy_dataset,"tidy_dataset")
        
        
        
        
        