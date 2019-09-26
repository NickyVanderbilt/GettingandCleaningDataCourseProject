library(dplyr)

# Download dataset

fileUrl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./Desktop/course_project.zip", method="curl")
unzip("./Desktop/course_project.zip")

# Read data and convert them to data frames

features <- read.table("./Desktop/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("./Desktop/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("./Desktop/UCI HAR Dataset/test/subject_test.txt", col.names = ("subject"))
x_test <- read.table("./Desktop/UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("./Desktop/UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("./Desktop/UCI HAR Dataset/train/subject_train.txt", col.names = ("subject"))
x_train <- read.table("./Desktop/UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("./Desktop/UCI HAR Dataset/train/y_train.txt", col.names = ("code"))


# Merges the train and the test sets to create one data set called All_data

X<- rbind(x_train, x_test)
Y<- rbind(y_train, y_test)
Subject<- rbind(subject_train,subject_test)
All_data<- cbind(Subject, Y, X)


# Extracts only the measurements on the mean and standard deviation for each measurement

Select_Data <- select(All_data, subject, code, contains("means"), contains("std")) 
  

# Uses descriptive activity anmes to name the activities in the data set

Select_Data$code<- activities[Select_Data$code, 2]

# Appropriately labels teh data set with descriptive variable names

names(Select_Data)[2] = "activity"
names(Select_Data)<- gsub("Acc", "Accelerometer", names(Select_Data))
names(Select_Data)<-gsub("Gyro", "Gyroscope", names(Select_Data))
names(Select_Data)<-gsub("BodyBody", "Body", names(Select_Data))
names(Select_Data)<-gsub("Mag", "Magnitude", names(Select_Data))
names(Select_Data)<-gsub("^t", "Time", names(Select_Data))
names(Select_Data)<-gsub("^f", "Frequency", names(Select_Data))
names(Select_Data)<-gsub("tBody", "TimeBody", names(Select_Data))
names(Select_Data)<-gsub("-std()", "STD", names(Select_Data), ignore.case = TRUE)
names(Select_Data)<-gsub("-freq()", "Frequency", names(Select_Data), ignore.case = TRUE)
names(Select_Data)<-gsub("angle", "Angle", names(Select_Data))
names(Select_Data)<-gsub("gravity", "Gravity", names(Select_Data))


# From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject

Project_Data<-Select_Data %>% 
  group_by(subject,activity) %>%
  summarize_all(funs(mean))
write.table(Project_Data, "./Desktop/Project_Data.txt", row.name=FALSE)

