
 # Chunk 1 (see the explanations in the codebook - Project.Rmd)
   download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="HARUSD.zip") 
 # Chunk 2
   unzip(zipfile="HARUSD.zip")
   closeAllConnections()
 # Chunk 3
   headers <- read.table ("UCI HAR Dataset/features.txt")
   activity <- read.table ("UCI HAR Dataset/activity_labels.txt")
   subjectid_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
   subjectid_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
 # Chunk 4
   X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
   X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
 # Chunk 5
   y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
   y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
 # Chunk 6
   colnames(X_train) <- headers[ ,2]
   colnames(X_test) <- headers[ ,2]
 # Chunk 7
   colnames(y_train) <- "activitycode"
   colnames(y_test) <- "activitycode"
   colnames(subjectid_test) <- "subjectid"
   colnames(subjectid_train) <- "subjectid"
 # Chunk 8
   colnames(activity) <- c("activitycode", "activitytype")
 # Chunk 9
   train <- cbind(y_train, subjectid_train, X_train)
   test <- cbind(y_test, subjectid_test, X_test)
   fullset <- rbind(train, test)
 # Chunk 10
   COLS <- colnames(fullset)
   selectdata <- (grepl("activitycode", COLS) | grepl("subjectid", COLS) | grepl("mean()..", COLS) & !grepl("-meanFreq..", COLS) | grepl("std()...", COLS))
   fullset_ms <-fullset[ ,selectdata==TRUE]
 # Chunk 11  
   finaldata <- aggregate(. ~subjectid + activitycode, fullset_ms, mean)
   finaldata <- merge (activity, finaldata, by="activitycode")
   write.table(finaldata, "finaldata.txt", row.names=FALSE)
 # End of script