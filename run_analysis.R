 setwd("/Users/zoe/Desktop/Data Science/Data Set/UCI HAR Dataset")
 
 # 1. Merges the training and the test sets to create one data set.
 
 train.x <- read.table("./train/X_train.txt")
 train.y <- read.table("./train/y_train.txt")
 train.subject <- read.table("./train/subject_train.txt")
 test.x <- read.table("./test/X_test.txt")
 test.y <- read.table("./test/y_test.txt")
 test.subject <- read.table("./test/subject_test.txt")

 train.data<-cbind(train.subject,train.x,train.y)
 test.data<-cbind(test.subject,test.x,test.y)
 total.data<-rbind(train.data,test.data)
 
 # 2.Extracts only the measurements on the mean and standard deviation for each measurement. 

 feature.name <- read.table("./features.txt")
 feature.measurement <- grep(("mean\\(\\)|std\\(\\)"),feature.name$V2)
 
 select.data<-total.data[,c(1,feature.measurement+1,563)]
 
 colnames(select.data)<-c("Subject",as.vector(feature.name[feature.measurement,2]),"Activity")
 
 # 3. Uses descriptive activity names to name the activities in the data set
 
 activity.name <- read.table("./activity_labels.txt")
 select.data$Activity <- factor(select.data$Activity, levels = activity.name[,1], labels = activity.name[,2])
 
 # 4. Appropriately labels the data set with descriptive variable names.
 
 names(select.data) <- gsub("\\(\\)", "", names(select.data))
 names(select.data) <- gsub("^t", "time", names(select.data))
 names(select.data) <- gsub("^f", "frequency", names(select.data))
 names(select.data) <- gsub("mean", "Mean", names(select.data))
 names(select.data) <- gsub("std", "Std", names(select.data))
 
 # 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 
 library(dplyr)
 mean.data<-summarise_all(group_by(select.data_tbl,Subject,Activity),mean)
 write.table(mean.data, "./MeanData.txt", row.names = FALSE)
