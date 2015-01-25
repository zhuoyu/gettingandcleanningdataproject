The data set is a summary of Human Activity Recognition Using Smartphones Dataset (www.smartlab.ws).

The original experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 561 features are provided for each observation.In the original data set, there are two groups, trainning group and testing group.

The data set is the result of the Getting and Cleanning data Course project. It records the average of 66 feathers for each of 30*6=180 subject-activity groups

The data file Tidydata.txt can be loaded into R using read.table().

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
'mean()' is used to denote Mean values of the signals.
'std()' is used to denote Standard deviation of the signals

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

"activity" column denote the 6 activities.                  
"subject" column denote the 30 subjects.
"group" column denote if the subject is in training group or testing group.



Actually the requirement of this project is not clear. In step 5: "From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject." The "variable" has two interpretations: the measurement variable and the variable in the dataset. If it is the measurement variable, the columns with 'std()' in their names should not be included in the final data set. average of standard deviations is not meaningful. If it is variables in the dataset, then all columns in the extracted data set should be included. I believe the first interpretation is more meaningful. However, providing more is usually better than providing less. So I also included the std() columns in the results. 

