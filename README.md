# Tidying UCI HAR Data Set
---
Created: 16 July 2019 by Stephanie Beard

Purpose:
To create a tidy data set from UCI HAR data
https://www.dropbox.com/s/lfsbhwy8elgjo15/UCI_HAR_Dataset.zip?dl=0

Script does the following:
1. Merges training and testing data into one data set
2. Extracts only mean and standard deviation
3. Uses descriptive names to name activities
4. Labels columns with descriptive variable names
5. Creates a new independent tiday data set with avg for each variable for each activity and subject
  
To run script in R:
* Download data set and store in working directory 
* Set the working directory to ~UCI HAR Dataset/
* Load the tidyr package
* Run run_analysis.R

For more information on the Human Activity Recognition Using Smartphones Dataset see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
