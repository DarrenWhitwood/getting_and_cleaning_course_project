##### Explanation #####
# This R script, run_analysis.R, is intended to accomplish
# the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation
# for each measurement.
# 3. Uses descriptive activity names to name the activities in the data
#  set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy
#  data set with the average of each variable for each activity and each
#  subject.
#####

setwd('## set your working directory here  ##')

##### 1. Merge the training and test sets #####

# Get training data
subject_train <- read.table('./train/subject_train.txt',header=FALSE);
x_train <- read.table('./train/X_train.txt',header=FALSE);
y_train <- read.table('./train/y_train.txt',header=FALSE);

# Get test data
subject_test <- read.table('./test/subject_test.txt',header=FALSE);
x_test <- read.table('./test/X_test.txt',header=FALSE);
y_test <- read.table('./test/y_test.txt',header=FALSE);

# Get features and activity types
features <- read.table('./features.txt',header=FALSE);
activities <- read.table('./activity_labels.txt',header=FALSE);

# Merge test and training
all_test <- cbind(subject_test, y_test, x_test)
all_train <- cbind(subject_train, y_train, x_train)
all_data <- rbind(all_test, all_train)
colnames(all_data)[1:2] <- c('subject_id', 'activity')

feat_length <- dim(features)[1]
for(colname_index in 1:feat_length)
{
	colnames(all_data)[colname_index+2] <- as.character(features[colname_index,2])
}

#####

##### 2. Extract only mean and sd for each observation #####

is_mean_sd <- (grepl("-mean()",features[,2]) | grepl("-std()",features[,2])); # the columns of 'features' that are means and sds
is_header_mean_sd <- c(TRUE, TRUE, is_mean_sd); # the variable above, plus TRUE in the first two columns, for the subject and y-variable (activity)
all_data_mean_sd <- all_data[is_header_mean_sd] # all_data filtered to only include means and sds, plus the subject and activity columns

#####

##### 3. Use descriptive activity names #####

# use the 'activities' table to define the 'activity' column in the data
all_data_mean_sd$activity <- factor(all_data_mean_sd$activity, levels = activities[,1], labels = activities[,2])

#####

##### 4. Appropriately label the data set with descriptive variable names #####

col_total <- length(is_header_mean_sd) # get the number of columns

for (col_index in 1:col_total)
{
	# remove paranetheses from the end of the variable names
	colnames(all_data_mean_sd)[col_index] <- gsub("\\()","",colnames(all_data_mean_sd)[col_index])

	# the remaining features of the variable names are unique and intelligible
}

#####

##### 5. create a tidy data set with the average of each variable for each activity and each subject #####

tidy_data <- aggregate(all_data_mean_sd,by=list(activity=all_data_mean_sd$activity,subject_id = all_data_mean_sd$subject_id),mean);

#####

write.table(tidy_data, "tidy_data.txt", sep=" ", quote=FALSE, row.name=FALSE)