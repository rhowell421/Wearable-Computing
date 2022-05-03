# README Wearable-Computing
Getting and Cleaning Data Course Project
R. Howell 

### Files included: 
* README.md
* Codebook.Rmd
* run_analysis.R **contains complete script to read, clean, and analyze**
* raw_data.zip **initial download**
* clean_data.txt **processed data with steps below**
* summary_activity_data.txt **mean of variable by activity**
* summary_id_data.txt **mean of variable by test subject**

### Data Processing Workflow: 

1. Load libraries (tidyr, dplyr, mgsub)
1. Download files
1. Read data into data frame
1. Tidy data (including renaming duplicate column names)
1. Extracts only the measurements on the mean and standard deviation for each measurement
1. Uses descriptive activity names to name the activities in the data set
1. Appropriately label the data set with descriptive variable names
1. Create a second, independent tidy data set with the average of each variable for each activity and each subject

### Experiement 
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

For more information about this dataset contact: activityrecognition@smartlab.ws

### License:

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
