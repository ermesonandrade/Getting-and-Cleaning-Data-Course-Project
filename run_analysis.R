#Ermeson Andrade
# 2020.2

library(dplyr)

#******************************************************************
# Merges the training and the test sets to create one data set.
#******************************************************************

# Reading training data.
x_train <- read.table("https://www.dropbox.com/s/o2r22wn2boxsi57/X_train.txt?dl=1")
y_train <- read.table("https://www.dropbox.com/s/7525xmeflrinwlt/y_train.txt?dl=1")
subject_train <- read.table("https://www.dropbox.com/s/8sze3wg29dzjjrf/subject_train.txt?dl=1")

# Reading testing data.
x_test <- read.table("https://www.dropbox.com/s/udtsyaie5gwvjwb/X_test.txt?dl=1")
y_test <- read.table("https://www.dropbox.com/s/ngj1wj5ek6e2qfw/y_test.txt?dl=1")
subject_test <- read.table("https://www.dropbox.com/s/ru7p9dfchvn1ap4/subject_test.txt?dl=1")

# Reading feature information:
features <- read.table('https://www.dropbox.com/s/78rcaq20jlwxnln/features.txt?dl=1')

#  Reading activity information:
activityLabels = read.table('https://www.dropbox.com/s/8qwxt96u4p6101s/activity_labels.txt?dl=1')

# Assigning names to the columns:
colnames(x_train) <- features$V2
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features$V2 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

# Merging all data in one set:
merge_train <- cbind(y_train, subject_train, x_train)
merge_test <- cbind(y_test, subject_test, x_test)
all <- rbind(merge_train, merge_test)

#******************************************************************
# Extracts only the measurements on the mean and standard deviation for each measurement.
#******************************************************************

# Reading column names.
colNames <- colnames(all)

# Extracting only the mean and standard deviation for the measures.
onlyMeanAndStd <-all[,grepl("activityId|subjectId|mean|std",colNames)]


#******************************************************************
# Uses descriptive activity names to name the activities in the data set
#******************************************************************

activityWithNames <- merge(onlyMeanAndStd, activityLabels,
                              by='activityId',
                              all.x=TRUE)

#******************************************************************
# Appropriately labels the data set with descriptive variable names.
#******************************************************************

# Replacing abbreviations by descriptive names.
names(activityWithNames)<-gsub("^t", "time", names(activityWithNames))
names(activityWithNames)<-gsub("^f", "frequency", names(activityWithNames))
names(activityWithNames)<-gsub("Acc", "Accelerometer", names(activityWithNames))
names(activityWithNames)<-gsub("Gyro", "Gyroscope", names(activityWithNames))
names(activityWithNames)<-gsub("Mag", "Magnitude", names(activityWithNames))
names(activityWithNames)<-gsub("BodyBody", "Body", names(activityWithNames))

#******************************************************************
# From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.
#******************************************************************

#Creating a new data set.

tidy2<-activityWithNames%>%
  group_by(activityId, subjectId) %>%
  summarise_all(funs(mean))

#Writing second tidy data set in txt file
write.table(tidy2, file = "tidy2.txt",row.name=FALSE)
