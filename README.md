#README.md

##Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected. 

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following. 
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



##What is icluded in the project repo?

* run_analysis.R: Contains a script to accomplish the project questions. It downloads the necessary data directly from the web so there is no need to have the data within the working directory to run this script. Bellow is a description of how the script works.


	* downloads required data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
	* unzips the file if it has not been uncompressed
	* creates results folder if it does not exist (all files are stored in this folder)
	* loads features.txt used for columns
	* loads X_train.txt, y_train.txt, subject_train.txt
	* X_train contains the data using the feature data set as columns
	* y_train contains the activity labels
	* subject_train contains the ids
	* loads and appends test dataset using X_test.txt, y_test.txt, subject_test.txt
	* X_test contains the data using the feature data set as columns
	* y_test contains the activity labels
	* subject_test contains the ids
	* appends train and test data
	* rearrange the data using id
	* loads activity_labels.txt
	* changes the data activity row to use the activity labels
	* saves the mean and std into mean_and_std.csv
	* saves the tidy dataset into tidy_dataset.csv
	* saves the tidy dataset into tidy_dataset.txt

* a sub directory /results contains the output files from running run_analysis.R. The files are the tidy data both in .CSV and .TXT format, mean_and_std.csv.

* CodeBook.md: contains information describing the variables in tidy_dataset and mean_and_std 

