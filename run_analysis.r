# setwd("C://DropBox//courses//Cousera//Data Science//Getting and Cleaning Data//data//UCI HAR Dataset")

# "The Run_analysis script goes in the UCI directory which also contains the train and test folders"


#*************************************************************************
#
# step 0: load the data sets into R
#
#*************************************************************************

# load feature labels and activity labels
features <- read.table("features.txt") # 561 features
activity_labels <- read.table("activity_labels.txt") # 6 activity_labels

# load testing set
x_test <- read.table("test/X_test.txt")	# observations
y_test <- read.table("test/y_test.txt")	# activity indications
subject_test <-read.table("test/subject_test.txt")	# subject indications

# load training set
x_train <- read.table("train/X_train.txt")	# observations
y_train <- read.table("train/y_train.txt")	# activity indications
subject_train <-read.table("train/subject_train.txt")	# subject indications


#**********************************************************************
#
# step 1: Merges the training and the test sets to create one data set
#
#**********************************************************************

# bind testing and training data set
mergedData <-rbind(x_test,x_train)

# append activity indication column
mergedData$activity <- c(unlist(y_test),unlist(y_train))

# append subject indication column
mergedData$subject <- c(unlist(subject_test), unlist(subject_train))

# append test/train group indication column
mergedData$group <- factor(c(rep("test",nrow(y_test)), rep("train",nrow(y_train))))


#**********************************************************************
#
# step 2: Extracts only the measurements on the mean and standard deviation for each measurement.  
#
#**********************************************************************

# check column names, i.e., the feather label, with "mean" or "std"
mean_std <- grepl("mean()",features[,2]) | grepl("std()",features[,2])

# remove feather labels with ("meanFreq()"
mean_std <- mean_std & !grepl("meanFreq()",features[,2])

# extract the mean and standard deviation columns from mergedData, keeping activity and subject
mergedData_extract <- mergedData[,c(mean_std,TRUE,TRUE,TRUE)]


#**********************************************************************
#
# step 3: Uses descriptive activity names to name the activities in the data set
#
#**********************************************************************

# re-label activities with activity labels
mergedData_extract$activity <-factor(c(mergedData_extract$activity), labels=activity_labels[,2])

#**********************************************************************
#
# step 4: Appropriately labels the data set with descriptive variable names. 
#
#**********************************************************************

# rename column names with feather labels
colnames(mergedData_extract) <- c(as.character(features[mean_std,2]),c("activity","subject","group"))


#**********************************************************************
#
# step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject
#         mergedData_extrac_average is the final data set
#
#**********************************************************************

# add a column to indicate new group by activity and subject
mergedData_extract$new_group <- (factor(mergedData_extract$subject)):(mergedData_extract$activity)

# define a new data frame to save the averages of each variable for each subject and activity
mergedData_extrac_average <- matrix(NA, nrow=length(levels(mergedData_extract$new_group)), ncol= ncol(mergedData_extract)-1)
mergedData_extrac_average <- as.data.frame(mergedData_extrac_average)

# use a loop to calculate the averages. Each iteration for each variable
for (i in 1:(ncol(mergedData_extract)-1)) {
	if (i<=ncol(mergedData_extract)-4) {
		mergedData_extrac_average[,i] <- tapply(mergedData_extract[,i],mergedData_extract$new_group,mean)
	} else {
		mergedData_extrac_average[,i] <- tapply(mergedData_extract[,i],mergedData_extract$new_group,unique)
	}
}

# rename the new data frame
colnames(mergedData_extrac_average)=colnames(mergedData_extract)[1:ncol(mergedData_extrac_average)]

# re-label the activity column
mergedData_extrac_average$activity <-factor(c(mergedData_extrac_average$activity), labels=activity_labels[,2])

write.table(mergedData_extrac_average,file="TidyData.txt",row.name=FALSE)