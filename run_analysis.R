go <- function() {
    
    ## download files if necessary
    downloadfiles()
    
    ## read test and train files
    ## Extract only the measurements on the mean and standard deviation 
    ## for each measurement (Step 2)
    ## Appropriately label the data set with descriptive names (Step 4)
    testdata <- readtest()
    traindata <- readtrain()
    
    ## Merges the training and the test sets to create one data set. (Step 1)
    data <- rbind(testdata, traindata)
    
    ## Assign friendly names to activities
    ## Uses descriptive activity names to name the activities in the data set (Step 3)
    data$activity <- factor(data$activity, levels = c(1, 2, 3, 4, 5, 6), 
                            labels = c("Walking", "Walking Upstairs", "Walking Downstairs", 
                                       "Sitting", "Standing", "Laying"))
    
    ## Creates a second, independent tidy data set with the average of each 
    ## variable for each activity and each subject. (Step 5)
    tidy <- aggregate(.~subject+activity, data=data, mean)

    ## Write the output to a csv file - used to create file for submission
    ## File extension is txt because web page doesn't accept .csv extension
    ## Commented out here, because the github script is supposed to output
    ## the tidy data set, not necessarily write it to disk
##    write.table(tidy, "UCI-HAR-Dataset-Tidy.txt", sep=",")
    
    ## Output the tidy dataset
    tidy
}

## Read test files, assign column names, and merge with activities and subjects
readtest <- function() {
    
    ## read X, which has 561 readings per observation
    x <- read.fwf("UCI\ HAR\ Dataset/test/X_test.txt", c(17, rep(16,560)) )
    
    ## read features and use this to name the columns
    features <- read.table("UCI\ HAR\ Dataset/features.txt", sep=" ", 
                           col.names=c("x","feature"), stringsAsFactors=FALSE)
    colnames(x) <- as.vector(features$feature)
    
    ## choose desired columns: mean or std
    meancol <- features[grep("mean", features$feature), 2]
    stdcol <- features[grep("std", features$feature), 2]
    mycols <- c( meancol, stdcol )
    
    ## read corresponding list of activities
    y <- read.table("UCI\ HAR\ Dataset/test/y_test.txt", col.names="activity")
    
    ## read corresponding list of subjects
    s <- read.table("UCI\ HAR\ Dataset/test/subject_test.txt", col.names="subject")
    
    ## merge tables, choosing only columns involving mean or std
    m <- cbind(s, y, x[ ,mycols])
    
    ## clean up column names, by removing dashes and parens
    names(m) <- gsub("-","", names(m))
    names(m) <- gsub("\\(\\)","", names(m))
    
    ## make column names more intelligible
    names(m) <- gsub("^t","time",names(m))
    names(m) <- gsub("^f","freq",names(m))
    
    m
}

## Read train files, assign column names, and merge with activities and subjects
readtrain <- function() {
    
    ## read X, which has 561 readings per observation
    x <- read.fwf("UCI\ HAR\ Dataset/train/X_train.txt", c(17, rep(16,560)) )

    ## read features and use this to name the columns    
    features <- read.table("UCI\ HAR\ Dataset/features.txt", sep=" ", 
                           col.names=c("x","feature"), stringsAsFactors=FALSE)
    colnames(x) <- as.vector(features$feature)
    
    ## choose desired columns: mean or std
    meancol <- features[grep("mean", features$feature), 2]
    stdcol <- features[grep("std", features$feature), 2]
    mycols <- c( meancol, stdcol )
    
    ## read corresponding list of activities
    y <- read.table("UCI\ HAR\ Dataset/train/y_train.txt", col.names="activity")
    
    ## read corresponding list of subjects
    s <- read.table("UCI\ HAR\ Dataset/train/subject_train.txt", col.names="subject")
    
    ## merge tables, choosing only columns involving mean or std
    m <- cbind(s, y, x[ ,mycols])

    ## clean up column names, by removing dashes and parens
    names(m) <- gsub("-","", names(m))
    names(m) <- gsub("\\(\\)","", names(m))
    
    ## make column names more intelligible
    names(m) <- gsub("^t","time",names(m))
    names(m) <- gsub("^f","freq",names(m))
    
    m
}


## Download the zip file and extract, if it doesn't already exist in the working directory
downloadfiles <- function( ) {    
    ## download file to working directory and unzip, if necessary
    if ( !file.exists("UCI HAR Dataset")) {
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                      method="curl", destfile="getdata-projectfiles-UCI-HAR-Dataset.zip")
        system("unzip getdata-projectfiles-UCI-HAR-Dataset.zip")
    }
    
}