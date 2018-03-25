DATA  DICTIONARY

"activities"
Activity labels, including LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS.

"subject" 
A group of 30 volunteers within an age bracket of 19-48 years. Each row in each label represents a person, from 1 to 30.

"tBodyAcc-mean()-X" —— "angle(Z,gravityMean)"
Features that extracting only the measurements on the mean and standard deviation.

Data in each feature
Representing the average of each feature for each activity and each subject.

Working on the data set
1.	Reading the “X_train” and “X_test” data into R and merging into one data set with rbind() command.
2.	Extracting features with regular expressions that only containing the measurements on the mean and standard deviation.
3.	Adding a new column to extracted data above to represent specific activity within each row in data set.
4.	Adding the column names to the data set with the specific features extracted from original features set.
5.	Grouping the extracted data by dual standard activities and subject, and building a new tidy data set with the average of each variable.
6.	Importing data set above to form an text file called “averagedata.txt”.
