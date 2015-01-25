
## Explanation about the R script

## The Run_analysis script goes in the UCI directory which also contains the train and test folders

### The R code has 6 steps:
- Step 0: load the data files into R
- Step 1: Merges the training and the test sets to create one data set
- Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
- step 3: Uses descriptive activity names to name the activities in the data set
- step 4: Appropriately labels the data set with descriptive variable names. 
- step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject

Step 0: load the data files into R
 - 8 files are loaded into R using read.table() function: features.txt, activity_labels.txt, test/X_test.txt, test/y_test.txt, test/subject_test.txt, train/X_train.txt, train/y_train.txt, train/subject_train.txt

Step 1: Merges the training and the test sets to create one data set
  - The test and trainning data sets are merged into one data set: mergedData.
  - In addition, 3 columns are appended to the data set for the information of activity, subject and group

Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.  
 - using grepl() function to check if feature labels contain "mean()" or "std()", but no "meanFreq()"
 - Extract columns which are true for the last condition from data frame mergedData into new data frame mergedData_extract.
 
Step 3: Uses descriptive activity names to name the activities in the data set
 - Re-label the activity column using activity labels
 
Step 4: Appropriately labels the data set with descriptive variable names
- set the column names of data set mergedData_extract using corresponding feature labels

step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject
 - add a new column to the data set mergedData_extract to indicate new group by activity and subject
 - define a new data frame to save the averages of each variable for each subject-activity group
 - use a loop to calculate the averages. Each iteration for each variable. tapply() function is used to get the mean of the current variable for each subject-activity group 
 - rename the new data frame
 - re-label the activity column
 - re-label the group column
 - save the result into the Tidy.txt file
 
 
 Actually the requirement of this project is not clear. In step 5: "From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject." The "variable" has two interpretations: the measurement variable and the variable in the dataset. If it is the measurement variable, the columns with 'std()' in their names should not be included in the final data set. average of standard deviations is not meaningful. If it is variables in the dataset, then all columns in the extracted data set should be included. I believe the first interpretation is more meaningful. However, providing more is usually better than providing less. So I also included the std() columns in the results. 

