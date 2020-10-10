The CodeBook.md describes the variable and other transformation steps that was done in the script run_analysis.R to clean and create a tidy dataset 


Libraries Used: dplyr, data.table

Variables Used:
fileurl: Stores the URL which contains the dataset used for performing the analysis.
trainsets: Stores data from the file X_train.txt
trainlabels: Stores the data from the file y_train.txt
trainsubjects: Stores the data from the file subject_train.txt
testsets: Stores data from the file X_test.txt
testlabels: Stores the data from the file y_test.txt
testsubjects: Stores the data from the file subject_test.txt
combinesets: Stores merged data from trainsets and testsets
combinelabels: Stores merged data from trainlabels and 			    testlabels
combinesubjects: Stores merged data from trainsubjects and 				 testsubjects
combineall: Stores merged data from combinesets, 					 combinelabels and combinesubjects
activity: Stores data from the file activity_labels.txt
features: Stores data from the file features.txt
Mean_SD: Stores the extracted data only for mean and standard deviation measurements.
Mean_SD_Part2: Stores the final tidy dataset. 

Steps to create tidydata.txt

Requirement 1: 
1. Data set was downloaded using download.file function
2. The zipped file was unzipped sing the unzip function
3. The data was read individually from each file and stored into the variable using read.table function
4. Using the function rbind, the training and test sets were merged . Similarly, the training and test labels and training and test subjects were merged.
5. Using the function cbind, the sets, labels and subjects were merged into a single dataset called combineall.

Requirement 2:
1. Column names were assigned to the dataframes combineall,activity and features  using the colname function.
2. dplyr verb was applied to combineall dataframe to extract data only for standard deviation and mean measurement and stored into Mean_SD variable.

Requirement 3:
1. The ActivityID column in dataframe Mean_SD, was filled with descriptive activity names using the data avaibale in activity variable.
2. After filling the column was factored using the as.factor function.

Requirement 4:
1. The columns in dataframe Mean_SD was renamed with descriptive names using the gsub function.

Requirement 5:
1. dplyr verbs was applied to Mean_SD dataframe to create new dataframe Mean_SD_Part2 which conatins tidy data set with the average of each variable for each activity and each subject. 

2. The Mean_SD_Part2 was written to a file using the write.table function