# Getting and Cleaning Data Course Project

run_analysis.R does the following:

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive activity names.
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

About variables

`x_train`, `y_train`, `x_test`, `y_test`, `subject_train`, `subject_test`, `features`, and `activityLabels` contain the data from the downloaded files.

`merge_train` and  `merge_test` contain merged data from the training and test data, respectively.

`colNames` contains column names.

`onlyMeanAndStd` contains only the data concerning the mean and standard deviation.

`activityWithNames` contains the data set with the activity names.

`tidy2` contains the new data with the average of each variable for each activity and each subject.
