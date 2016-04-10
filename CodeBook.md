This file CodeBook.md is intended to, as specified in the assignment, "describe the variables, the data, and any transformations or work that you performed to clean up the data". This refers to the file run_analysis.R in this github repo.

Note first that the first line after the explanation within run_analysis.R itself needs to be modified by the user to specify the directory where the user has stored the UCI data.

The script is divided up into 6 sections defined by the assignment in Coursera, laid out in run_analysis.R as follows:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation
# for each measurement.
# 3. Uses descriptive activity names to name the activities in the data
#  set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy
#  data set with the average of each variable for each activity and each
#  subject.

The variables in section 1 correspond to the relevant data pulled from the UCI data files:
'subject_train' contains the subjects of the training data
'x_train' contains the x-values in the training data
'y_train' contains the y-values in the training data, which represent activities

Similarly,
'subject_test' contains the subjects of the test data
'x_test' contains the x-values in the test data
'y_test' contains the y-values in the tes data, which represent activities

'features' contains the feature data from features.txt
'activities' contains the names of the activities performed

The x and y values are combined with the subjects for each row in 'all_test' and 'all_train', then these two tables are combined in 'all_data'. The column names in 'all_data' are transformed to correspond to the definitions in 'features'.

Section 2 of the code uses grepl to isolate the mean and standard deviation measurements, eliminating all other columns. 
'is_mean_sd' is a boolean vector that is TRUE wherever 'all_data' has a column of either mean or standard deviation measurements
'is_header_mean_sd' additionally sets the first two columns to TRUE since they are the activity and subject headers and should not be excluded from the final data set
'all_data_mean_sd' is then a subset of 'all_data' that excludes the columns of x-values that are not mean or standard deviation measurements

Section 3 replaces the activity names in the activity column of 'all_data_mean_sd' with the appriopriate activity name found in 'activities'.

In section 4, a variable is created for the value of the number of columns in 'is_header_mean_sd', representing the number of x-value columns that were kept plus the activity and subject columns. This variable is used to loop through the columns of 'is_header_mean' and remove the extraneous '()' characters at the ends of the variable names.

Finally, in section 5 a variable called 'tidy_data' is created to hold the average of each variable for each activity and subject from 'all_data_mean_sd'.
