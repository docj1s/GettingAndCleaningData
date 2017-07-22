
# **Code Book**  
This code book summarizes the resulting data fields in tidy.txt.  The code book includes a description of the variables, the data, and any transformations or work performed to clean up the data.  
  
## **Source**  
The dataset represents human data collected from the accelerometers from the Samsung Galaxy S smartphones.  The data is available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)  
  
**NOTE:** The "UCI HAR DATASET" folder **MUST** be placed in the same folder as the "runAnalysis.R" script.  
  
## **Variables**  
* activityID – A numeric code indicating the type of activity performed when the corresponding measurements were taken.  
* activityType – The specific activity, including   
+ WALKING (value 1): subject was walking during the test  
+ WALKING_UPSTAIRS (value 2): subject was walking up a staircase during the test  
+ WALKING_DOWNSTAIRS (value 3): subject was walking down a staircase during the test  
+ SITTING (value 4): subject was sitting during the test  
+ STANDING (value 5): subject was standing during the test  
+ LAYING (value 6): subject was laying down during the test  
* subjectID - The ID of the test subject  
  
## **Data**
* "TimeBodyMagnitude of AccelerationMean"  
* "TimeBodyMagnitude of AccelerationStandard Deviaton"  
* "TimeGravityMagnitude of AccelerationMean"  
* "TimeGravityMagnitude of AccelerationStandard Deviaton"  
* "TimeBodyAccMagnitude of JerkMean"  
* "TimeBodyAccMagnitude of JerkStandard Deviaton"  
* "TimeBodyMagnitude of GyroMean"  
* "TimeBodyMagnitude of GyroStandard Deviaton"  
* "TimeBodyMagnitude of Gyronitude of JerkMean"  
* "TimeBodyMagnitude of Gyronitude of JerkStandard Deviaton”  
* "FrequencyBodyMagnitude of AccelerationMean"  
* "FrequencyBodyMagnitude of AccelerationStandard Deviaton"  
* "FrequencyBodyAccMagnitude of JerkMean"  
* "FrequencyBodyAccMagnitude of JerkStandard Deviaton"  
* "FrequencyBodyMagnitude of GyroMean"  
* "FrequencyBodyMagnitude of GyroStandard Deviaton”  
* "FrequencyBodyMagnitude of Gyronitude of JerkMean"  
* "FrequencyBodyMagnitude of Gyronitude of JerkStandard Deviaton"  
  
## **Transformations**  
The tidy data set only includes an average of each variable for each activity and each subject.
