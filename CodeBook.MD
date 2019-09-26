    CODEBOOK
  
    A CodeBook describes the variables, the data, and any transformations or work that I performed to clean up teh data.

1.	Download the dataset
    
    The dataset is downloaded and extracted from the folder named UCI HAR dataset.

2.	Assign data to variables
    
    features <- features.txt
    
    activities <- activity_labels.txt
    
    subject_test <- test/subject_test.txt
    
    x_test <- test/X_test.txt 
    
    y_test <- test/y_test.txt 
    
    subject_train <- test/subject_train.txt 
    
    x_train <- test/X_train.txt  
    
    y_train <- test/y_train.txt 

3.	Merges the training and the test data sets to create one data set
    
    X is created by merging x_train and x_test using rbind() function;
    
    Y is created by merging y_train and y_test using rbind() function;
    
    Subject is created by merging subject_train and subject_test using rbing() function; 
    
    All_data  is created by merging Subject, Y and X using cbind() function

4.	Extracts only the measurements on the mean and standard deviation for each measurement

    Select_Data  is created by subsetting All_data, selecting only subject and code and the measurements on the mean and standard deviation for each measurement

5.	Uses descriptive activity names to name the activities in the data set

    Entire numbers in code column of the Select_Data are replaced with the corresponding activities
   
6.	Appropriately labels the data set with descriptive variable names
	
    Activity is used to replace code column in Select_Data; 
	
    All Acc is replaced by Accelerometer;
	
    All Gyro is replaced by Gyroscope;
	
    BodyBody is replaced by Body; 
	
    Mag is replaced by Magnitude; 
	
    F is replaced by Frequency;
	
    T is replace by Time.
 
7.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
	
   Project_Data is created by first grouping Select_Data by subject and activity and then sumarizing it by  taking the means of each variable for each activity and each subject

   Export Project_Data into Project_Data.txt file.









