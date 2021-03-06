
#Downloading and unzipping dataset given in assignment
#Checking if the file exists
if(!file.exists("./data")){dir.create("./data")}

#Assigning the URL of the website given in the assignment to fileURL
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#Downloading the data from the website
download.file(fileUrl,destfile="./data/Dataset.zip")

#Unzipping the data 
unzip(zipfile="./data/Dataset.zip",exdir="./data")


#1.Merging the training and the test sets to create one data set.


#Reading files
#Reading trainings tables:

x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

#Reading testing tables
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

#Reading feature vector
features <- read.table('./data/UCI HAR Dataset/features.txt')

#Reading activity labels
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

#Assigning column names
colnames(x_train) <- features[,2]
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

#Merging all the data in one set
mrg_train <- cbind(y_train, subject_train, x_train)
mrg_test <- cbind(y_test, subject_test, x_test)
setAllInOne <- rbind(mrg_train, mrg_test)

#dim(setAllInOne)
#[1] 10299   563


#2.Extracting only the measurements on the mean and standard deviation for each measurement.


#Reading column names
colNames <- colnames(setAllInOne)

#Creating vector for defining ID, mean and standard deviation
mean_and_std <- (grepl("activityId" , colNames) | 
                   grepl("subjectId" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) 
)

#Making nessesary subset from setAllInOne
setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]


#3. Using descriptive activity names to name the activities in the data set


setWithActivityNames <- merge(setForMeanAndStd, activityLabels,
                              by='activityId',
                              all.x=TRUE)


#4. Appropriately labels the data set with descriptive variable names.


#Already done alongside the previous steps

