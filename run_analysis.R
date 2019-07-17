
# You should create one script called run_analysis.R that does the following.
# 1.Merges the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names.
# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#import libraries
library(dplyr)
 


# download and extract the data 
# make sure file is in the working directory
if( !dir.exists("UCI HAR Dataset") ) {
  if( !file.exists("UCI HAR Dataset.zip") ) {
    download.file("https://www.dropbox.com/s/lfsbhwy8elgjo15/UCI_HAR_Dataset.zip?dl=1", destfile = "UCI HAR Dataset.zip")
  }
  unzip("UCI HAR Dataset.zip")
}

#read tables into dataframes

X_train <- read.table(file = "./UCI HAR Dataset/train/X_train.txt")
X_test <- read.table(file = "./UCI HAR Dataset/test/X_test.txt")

y_train <- read.table(file = "./UCI HAR Dataset/train/y_train.txt")
y_test <- read.table(file = "./UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt")

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features        <- read.table("./UCI HAR Dataset/features.txt")

# 1.Merges the training and the test sets to create one data set.

#merge test, training, and subject data
x <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

#merge x and y
xy <- cbind(y,x)

#merge xy and subject to make full dataset
merged <- cbind(subject, xy)


#uses the features data to define column names for merged dataset
names(merged) <- c("SubjectID", "ActivityName", as.character(features$V2))


# 2.Extracts only the measurements on the mean and standard deviation for each measurement.

sd_mean_cols <- features$V2[grep("-mean\\(\\)|-std\\(\\)", features[, 2])]
subsetColumns <- c("SubjectID", "ActivityName", as.character(sd_mean_cols))

subsetted <- subset(merged, select = subsetColumns)

# 3.Uses descriptive activity names to name the activities in the data set

activity_labels$V2 <- as.character(activity_labels$V2) #converts to string
subsetted$ActivityName = activity_labels[subsetted$ActivityName, 2] #replaces labels


# 4.Appropriately labels the data set with descriptive variable names.

names(subsetted) <- gsub("^t", "Time ", names(subsetted))
names(subsetted) <- gsub("^f", "Frequency ", names(subsetted))
names(subsetted) <- gsub("Body", "Body ", names(subsetted))
names(subsetted) <- gsub("Acc", "Accelerometer ", names(subsetted))
names(subsetted) <- gsub("Gravity", "Gravity ", names(subsetted))
names(subsetted) <- gsub("Gyro", "Gyroscope ", names(subsetted))
names(subsetted) <- gsub("Mag", "Magnitude ", names(subsetted))
names(subsetted) <- gsub("Body", "Body ", names(subsetted))
names(subsetted) <- gsub("Jerk", "Jerk ", names(subsetted))
names(subsetted) <- gsub('mean\\(\\)', ' mean value ', names(subsetted))
names(subsetted) <- gsub('std\\(\\)', ' standard deviation ', names(subsetted))
names(subsetted) <- gsub('-X', 'in X direction' , names(subsetted))
names(subsetted) <- gsub('-Y', 'in Y direction' , names(subsetted))
names(subsetted) <- gsub('-Z', 'in Z direction', names(subsetted))


# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
data_group <- group_by(subsetted, SubjectID, ActivityName)
tidy <- summarise_each(data_group, funs(mean))

# Output tidy data set
write.table(tidy, "tidydata.txt", row.names = FALSE)
