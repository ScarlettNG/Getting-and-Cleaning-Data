The run_analysis.R script follows the 5 criteria below:

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


X is the merged data of X_train and X_test
Y is the merged data of Y_train and Y_test
subject is the merged data of subject_train and subject_test

mergedDT is the merged data of (X, Y, subject)

extract_data is a subset of mergedDT, only containing the measurements on the mean and standard deviation (std) for each measurement

These variables have been updated in the data. 
Acc replaced by Accelerometer
Gyro replaced by Gyroscope
BodyBody replaced by Body
Mag replaced by Magnitude
^t replaced by Time
^f replaced by Frequency 
tBody replaced by TimeBody
-mean() replaced by mean
-std() replaced by std
-freq() replaced by frequency

