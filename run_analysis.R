library(dplyr)
library(data.table)

#Downloading the Data:
if(!file.exists("./ProjectData")){dir.create("./ProjectData")}
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./ProjectData/Dataset.zip")

#Unzipping the "Dataset.zip":
unzip(zipfile="./ProjectData/Dataset.zip",exdir="./ProjectData")

#Read Training data from train folder:
trainsets<-read.table("./ProjectData/UCI HAR Dataset/train/X_train.txt",header = FALSE)
trainlabels<-read.table("./ProjectData/UCI HAR Dataset/train/y_train.txt",header = FALSE)
trainsubjects<-read.table("./ProjectData/UCI HAR Dataset/train/subject_train.txt",header = FALSE)

#Read Testing data from test folder:
testsets<-read.table("./ProjectData/UCI HAR Dataset/test/X_test.txt",header = FALSE)
testlabels<-read.table("./ProjectData/UCI HAR Dataset/test/y_test.txt",header = FALSE)
testsubjects<-read.table("./ProjectData/UCI HAR Dataset/test/subject_test.txt",header = FALSE)

#Merging sets,labels and subjects:
combinesets<-rbind(trainsets,testsets)
combinelabels<-rbind(trainlabels,testlabels)
combinesubjects<-rbind(trainsubjects,testsubjects)

#Requirement 1--> Merges the training and the test sets to create one data set.
#Merging combine (sets,labels and subjects) into single set:
combineall<-cbind(combinesets,combinelabels,combinesubjects)

#Read activity and features data:
activity<-read.table("./ProjectData/UCI HAR Dataset/activity_labels.txt",header = FALSE)
features<-read.table("./ProjectData/UCI HAR Dataset/features.txt",header = FALSE)

#Assigning Column Names to combineall,activity and features dataframe:
colnames(combineall[1:561])<-features[,2]
colnames(combineall)[562] = "ActivityID"
colnames(combineall)[563] = "SubjectID"
colnames(features)<-c("FeatureID","FeatureName")
colnames(activity)<-c("ActivityID","ActivityName")


#Requirement 2--> Extracts only the measurements on the mean and standard deviation for each measurement.
Mean_SD<- combineall %>% select( contains("mean"), contains("std"), ActivityID, SubjectID)
str(Mean_SD) #10299 obs. of  88 variables

#Requirement 3--> Uses descriptive activity names to name the activities in the data set:
Mean_SD$ActivityID<-activity[Mean_SD$ActivityID,2]
Mean_SD$ActivityID <- as.factor(Mean_SD$ActivityID)

#Requirement 4--> Appropriately labels the data set with descriptive variable names:
names(Mean_SD)<-gsub("Acc", "Accelerometer", names(Mean_SD))
names(Mean_SD)<-gsub("Gyro", "Gyroscope", names(Mean_SD))
names(Mean_SD)<-gsub("BodyBody", "Body", names(Mean_SD))
names(Mean_SD)<-gsub("Mag", "Magnitude", names(Mean_SD))
names(Mean_SD)<-gsub("^t", "Time", names(Mean_SD))
names(Mean_SD)<-gsub("^f", "Frequency", names(Mean_SD))
names(Mean_SD)<-gsub("tBody", "TimeBody", names(Mean_SD))
names(Mean_SD)<-gsub("-mean()", "Mean", names(Mean_SD), ignore.case = TRUE)
names(Mean_SD)<-gsub("-std()", "STD", names(Mean_SD), ignore.case = TRUE)
names(Mean_SD)<-gsub("-freq()", "Frequency", names(Mean_SD), ignore.case = TRUE)
names(Mean_SD)<-gsub("angle", "Angle", names(Mean_SD))
names(Mean_SD)<-gsub("gravity", "Gravity", names(Mean_SD))
names(Mean_SD)<-gsub("ActivityId", "ActivityName", names(Mean_SD))


#Requirement 5-->From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Mean_SD_Part2 <- Mean_SD %>%
                    group_by(SubjectID, ActivityName) %>%
                        summarise_all(mean)

write.table(Mean_SD_Part2, "TidyData.txt", row.name=FALSE)
