# Getting and Cleaning Data Course Project 

# README and Codebook are located in the Github repo

# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# Good luck!

# Libraries
library(tidyr)
library(mgsub)
library(dplyr)

# Download files
if(!dir.exists("data")) dir.create("data")
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url = fileURL, destfile = "data/raw_data.zip", method = "curl")
unzip("data/raw_data.zip", exdir = "data")

# Read data
train_x_df <- read.table("data/UCI HAR Dataset/train/X_train.txt")
train_y_df <- read.table("data/UCI HAR Dataset/train/y_train.txt")
train_id_df <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
test_id_df <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
test_x_df <- read.table("data/UCI HAR Dataset/test/X_test.txt")
test_y_df <- read.table("data/UCI HAR Dataset/test/y_test.txt")
feature_names <- read.table("data/UCI HAR Dataset/features.txt")

# Tidying
feature_names <- feature_names %>%
  # removes parentheses
  mutate(V2 = gsub(x = V2, pattern = "\\(|\\)", replacement = "")) %>%     
  # removes "-"
  mutate(V2 = gsub(x = V2, pattern = "-|,", replacement = "_")) %>%     
  # adds  "_" between lower and upper case
  mutate(V2 = gsub(x = V2, pattern = "([a-z])([A-Z])", replacement = "\\1_\\2")) %>%   
  # changes all to lower case
  mutate(V2 = tolower(V2)) %>%      
  # replaces T with TIME and F with FREQ
  mutate(V2 = mgsub(string = V2, pattern = c("^T_", "^F_"), replacement = c("TIME_", "FREQ_")))     


# 1. Merges the training and the test sets to create one data set.
X_df <- rbind(train_x_df, test_x_df)
Y_df <- rbind(train_y_df, test_y_df)
id_df <- rbind(train_id_df, test_id_df)
colnames(X_df) <- feature_names$V2
colnames(Y_df) <- "activity"
colnames(id_df) <- "id_subject"
merged_data <- cbind(id_df, X_df, Y_df)

# Duplicate column names
col_names <- colnames(merged_data)
dup_col_values <- table(col_names) %>% data.frame() %>% filter(Freq > 1) %>% 
  mutate(col_names = as.character(col_names)) %>% pull(col_names)

# Prefix X to the first occurence of duplicate column name, Y to 2nd, Z - 3rd
for (col in col_names) {
  if (col %in% dup_col_values) {
    dup_indexes <- which(col_names == col)
    col_names[dup_indexes[1]] = paste0(col, "_x")
    col_names[dup_indexes[2]] = paste0(col, "_y")
    col_names[dup_indexes[3]] = paste0(col, "_z")
  }
}

colnames(merged_data) <- col_names

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
final_data <- select(merged_data, activity, id_subject, matches("mean|std"))

# 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("data/UCI HAR Dataset/activity_labels.txt") 
activity_labels$V2 <-  tolower(activity_labels$V2)
final_data <- mutate(final_data, activity = plyr::mapvalues(x = activity, from = activity_labels$V1, to = activity_labels$V2))

# 4. Appropriately labels the data set with descriptive variable names. 
# See Tidy in lines 33-44
write.csv(x = final_data, file = "data/clean_data.txt")

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
summary_act_df <- final_data %>%
  group_by(activity) %>%
  summarise_at(vars(-id_subject), mean)
summary_id_df <- final_data %>%
  group_by(id_subject) %>%
  summarise_at(vars(-activity), mean)

write.csv(x = summary_act_df, file = "data/summary_activity_data.txt")
write.csv(x = summary_id_df, file = "data/summary_id_data.txt")

# Done! 