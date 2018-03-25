setwd("c:/users/x/desktop/getdata_projectfiles_UCI HAR Dataset")
library(dplyr)
library(xlsx)

# step1: Merges the training and the test sets to create one data set.
xtrain <- read.table('X_train.txt')
xtest <- read.table('X_test.txt')
mergedata <- rbind(xtrain , xtest)

# step2: Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table('features.txt')
features_mean_std <- grep('[Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]' , features[ ,2])
extractdata <- mergedata[ , features_mean_std]

# step3: Uses descriptive activity names to name the activities in the data set.
ytrain <- read.table('y_train.txt')
ytest <- read.table('y_test.txt')
mergey <- rbind(ytrain , ytest)
mergey[grep("1" , mergey[,1]) , ] = 'WALKING'
mergey[grep("2" , mergey[,1]) , ] = 'WALKING_UPSTAIRS'
mergey[grep("3" , mergey[,1]) , ] = 'WALKING_DOWNSTAIRS'
mergey[grep("4" , mergey[,1]) , ] = 'SITTING'
mergey[grep("5" , mergey[,1]) , ] = 'STANDING'
mergey[grep("6" , mergey[,1]) , ] = 'LAYING'
extractdata$activities <- factor(mergey$V1)

# step4: Appropriately labels the data set with descriptive variable names. 
colnames(extractdata)[-length(extractdata)] <- as.character(features[,2][features_mean_std])

# step5: From the data set in step 4, creates a second, independent tidy data set 
#        with the average of each variable for each activity and each subject.
subtrain <- read.table('subject_train.txt')
subtest <- read.table('subject_test.txt')
mergesub <- rbind(subtrain , subtest)
extractdata$subject <- factor(mergesub$V1)

for (i in seq_len(ncol(extractdata)-2)) {
       sub_extractdata <- select(extractdata , i , activities , subject)
       colnames(sub_extractdata)[1] = 'var'
       group_extractdata <- group_by(sub_extractdata , activities , subject)
       avedata <- as.data.frame(summarize(group_extractdata , var = mean(var)))
       if (i == 1) {
               averagedata <- avedata
       } else {
               averagedata <- cbind(averagedata , avedata$var)
       }
}
colnames(averagedata)[3 : length(colnames(averagedata))] <- as.character(features[,2][features_mean_std])

# Build a tidy data set in text file
write.table(averagedata , './averagedata.txt' , row.name = FALSE)
