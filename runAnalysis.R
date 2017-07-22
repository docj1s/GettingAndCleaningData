############################################################################################
# runAnalysis.r File Description:

# This script will perform the following steps on the UCI HAR Dataset  
 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
##########################################################################################################
processUCIHAR <- function()
{
  # Read metadata
  features <-
    read.table("UCI HAR Dataset/features.txt", header = FALSE)
  #imports features.txt
  activityType <-
    read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
  #imports activity_labels.txt
  
  #Read training data
  subjectTrainData <-
    read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
  
  xTrainData <-
    read.table("UCI HAR Dataset/train/x_train.txt", header = FALSE)
  
  yTrainData <-
    read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
  
  
  # Assign column names to the training data
  colnames(activityType)  <- c("activityId", "activityType")
  
  colnames(subjectTrainData) <- "subjectId"
  
  colnames(xTrainData) <- features[, 2]
  
  colnames(yTrainData) <- "activityId"
  
  
  # combine training data to one dataset
  trainingData <- cbind(subjectTrainData, yTrainData, xTrainData)
  
  
  # Read test data
  subjectTestData <-
    read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
  
  xTestData <-
    read.table("UCI HAR Dataset/test/x_test.txt", header = FALSE)
  
  yTestData <-
    read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
  
  
  # Assign column names to the test data
  colnames(subjectTestData) <- "subjectId"
  
  colnames(xTestData) <- features[, 2]
  
  colnames(yTestData) <- "activityId"
  
  
  # Create the test set to one dataset
  testData <- cbind(subjectTestData, yTestData, xTestData)
  
  
  # Combine training and test data to create a final data set
  finalData <- rbind(trainingData, testData)
  
  
  # 2. Extract only the measurements on the mean and standard deviation for each measurement.
  # Get the column names from finalData
  colNames <- colnames(finalData)
  
  
  # Find the columns for the ID, mean() & stddev()
  logicalVector <-
    (
      grepl("activity..", colNames) |
        grepl("subject..", colNames) |
        grepl("-mean..", colNames) &
        !grepl("-meanFreq..", colNames) &
        !grepl("mean..-", colNames) |
        grepl("-std..", colNames) & !grepl("-std()..-", colNames)
    )
  
  finalData <- finalData[logicalVector == TRUE]
  
  
  # 3. Use descriptive activity names to name the activities in the data set
  # Merge the finalData set with the acitivityType table to include descriptive activity names
  finalData <-
    merge(finalData, activityType, by = 'activityId', all.x = TRUE)
  
  
  # Updating the colNames vector
  colNames <- colnames(finalData)
  
  
  # 4. Appropriately label the data set with descriptive activity names.
  for (i in 1:length(colNames))
  {
    colNames[i] <- gsub("\\()", "", colNames[i])
    colNames[i] <- gsub("-std$", "Standard Deviaton", colNames[i])
    colNames[i] <- gsub("-mean", "Mean", colNames[i])
    colNames[i] <- gsub("^(t)", "Time", colNames[i])
    colNames[i] <- gsub("^(f)", "Frequency", colNames[i])
    colNames[i] <- gsub("([Gg]ravity)", "Gravity", colNames[i])
    colNames[i] <-
      gsub("([Bb]ody[Bb]ody|[Bb]ody)", "Body", colNames[i])
    colNames[i] <- gsub("[Gg]yro", "Gyro", colNames[i])
    colNames[i] <-
      gsub("AccMag", "Magnitude of Acceleration", colNames[i])
    colNames[i] <-
      gsub("([Bb]odyaccjerkmag)",
           "Magnitude of Body Acceleration and Jerk",
           colNames[i])
    colNames[i] <- gsub("JerkMag", "Magnitude of Jerk", colNames[i])
    colNames[i] <- gsub("GyroMag", "Magnitude of Gyro", colNames[i])
  }
  
  # 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
  # Reassign the new descriptive column names to the finalData set
  colnames(finalData) <- colNames
  
  
  # Create a new table sans the activityType column
  finalDataNoActivityType <-
    finalData[, names(finalData) != "activityType"]
  
  
  # Create tidyData to include the only the mean of each variable for each activity and each subject
  tidyData <-
    aggregate(
      finalDataNoActivityType[, names(finalDataNoActivityType) != c("activityId", "subjectId")],
      by = list(
        activityId = finalDataNoActivityType$activityId,
        subjectId = finalDataNoActivityType$subjectId
      ),
      mean
    )
  
  
  # Merge the tidyData with activityType to include descriptive acitvity names
  tidyData <- merge(activityType, tidyData, by = 'activityId', all.x = TRUE)
  
  
  # Export the tidyData set
  write.table(tidyData,
              "./tidyData.txt",
              row.names = FALSE,
              sep = "\t")
  
}