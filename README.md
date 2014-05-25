### Overview

The Course Project for Getting and Cleaning Data class involves the "Human Activity Recognition Using Smartphones Dataset". The "run_analysis.R" file in this repo downloads the data if necessary, and performs a series of operations on it, in order to produce a tidy data set.

The source file is located here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### How to run

In R, source the run_analysis.R file and then invoke the go() function. The zip file will be downloaded, data files extracted, and then the appropriate tables will be read and manipulated. The output of go is an object with the tidy data set. (This script was created on OS X. If you encounter errors with running the script, try downloading and extracting the zip manually into the working directory instead.)

### How the script works

1. Check for the presence of "UCI HAR Dataset" in working directory. If absent, download the file and unzip it, so that directory is created containing the appropriate files.
2. Read test data in the fixed-width file X_test.txt and apply column labels from the features.txt file.
3. Select only the column names which contain the text "mean" or "std" since we are only interested in mean and standard deviation values.  (As specified in step 2 in the course project instructions.)
4. Read in the activity column from y_test.txt and the subject column from subject_txt.txt
5. Join the activity, subject, and "mean" and "std" columns into one big table containing all of the test observations for the columns we care about.
6. Rename the columns to be more R-friendly by removing dashes and parenthesis. Convert "t" prefix to "time" and "f" prefix to "freq" in order to make labels more readable. (As specified in step 4 in the course project instructions.) 
_NOTE: The instructor expresses a preference for variable names without dots, dashes, or other punctuation, and all lower case. However, the lower case is more of an "if possible" than a requiement- given the length of these variable names, I decided to preserve the capitalization for readability._
7. Repeat steps 2-6 for the train data.
8. Merge the test and train data. (As specified in step 1 in the course project instructions.)
9. The "activity" column consists of numbers 1-6. Replace those with meaningful values like "Walking" and "Standing".  (As specified in step 3 in the course project instructions.)
10. Calculate mean values for all the columns, grouped by subject and activity, in order to create a new, tidy data set.

### Data dictionary

More details on the data contained in the tidy output is contained in the codebook.txt file also in this repo.