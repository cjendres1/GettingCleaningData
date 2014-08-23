## runAnalysis.R - by Christopher J. Endres
##
## TABLE OF CONTENTS
## Part1 - Lines 11  - 112 Merge the training and the test sets to create one data set.
## Part2 - Lines 114 - 140 Extract only the mean and standard deviation for each measurement. 
## Part3 - Lines 142 - 157 Use descriptive activity names for the activities in the data set.
## Part4 - Lines 159 - 207 Appropriately label the data set with descriptive variable names.
## Part5 - Lines 209 - 232 Create a tidy data set that is averaged per activity and subject.
##
## ---------------------------------------------------------------
## Part 1: MERGE THE TRAINING AND TEST SETS TO CREATE ONE DATA SET.
## ---------------------------------------------------------------
##
library(plyr)
#
## If the root directory is not specified then just use the working directory
rootDir <- "C:/Users/Chris/Desktop/Work/Coursera/courses/03_GettingData/UCIHARDataset/"
if( exists("rootDir") & !(rootDir == "") ) 
  setwd(rootDir)

## Load the test data - am using read.table for all data files
## Set file names
testDir <- paste(c(rootDir,"test/"), collapse = "")
subject_testFile <- paste(c(testDir,"subject_test.txt"), collapse = "")
X_testFile <- paste(c(testDir,"X_test.txt"), collapse = "")
y_testFile <- paste(c(testDir,"y_test.txt"), collapse = "")
## Read files
subject_test <- read.table(subject_testFile)
X_test <- read.table(X_testFile)
y_test <- read.table(y_testFile)

## Load the training data
## Set file names
trainDir <- paste(c(rootDir,"train/"), collapse = "")
subject_trainFile <- paste(c(trainDir,"subject_train.txt"), collapse = "")
X_trainFile <- paste(c(trainDir,"X_train.txt"), collapse = "")
y_trainFile <- paste(c(trainDir,"y_train.txt"), collapse = "")
## Read files
subject_train <- read.table(subject_trainFile)
X_train <- read.table(X_trainFile)
y_train <- read.table(y_trainFile)

## Evidently it was not necessary to load the Inertial Signals, but what the heck
## Set file names
body_acc_x_trainFile  <- paste(c(trainDir,"Inertial Signals/body_acc_x_train.txt"), collapse = "")
body_acc_y_trainFile  <- paste(c(trainDir,"Inertial Signals/body_acc_y_train.txt"), collapse = "")
body_acc_z_trainFile  <- paste(c(trainDir,"Inertial Signals/body_acc_z_train.txt"), collapse = "")
body_gyro_x_trainFile <- paste(c(trainDir,"Inertial Signals/body_gyro_x_train.txt"), collapse = "")
body_gyro_y_trainFile <- paste(c(trainDir,"Inertial Signals/body_gyro_y_train.txt"), collapse = "")
body_gyro_z_trainFile <- paste(c(trainDir,"Inertial Signals/body_gyro_z_train.txt"), collapse = "")
total_acc_x_trainFile <- paste(c(trainDir,"Inertial Signals/total_acc_x_train.txt"), collapse = "")
total_acc_y_trainFile <- paste(c(trainDir,"Inertial Signals/total_acc_y_train.txt"), collapse = "")
total_acc_z_trainFile <- paste(c(trainDir,"Inertial Signals/total_acc_z_train.txt"), collapse = "")
## Read files
body_acc_x_train  <- read.table(body_acc_x_trainFile)
body_acc_y_train  <- read.table(body_acc_y_trainFile)
body_acc_z_train  <- read.table(body_acc_z_trainFile)
body_gyro_x_train <- read.table(body_gyro_x_trainFile)
body_gyro_y_train <- read.table(body_gyro_y_trainFile)
body_gyro_z_train <- read.table(body_gyro_z_trainFile)
total_acc_x_train <- read.table(total_acc_x_trainFile)
total_acc_y_train <- read.table(total_acc_y_trainFile)
total_acc_z_train <- read.table(total_acc_z_trainFile)
## Set file names
body_acc_x_testFile  <- paste(c(testDir,"Inertial Signals/body_acc_x_test.txt"), collapse = "")
body_acc_y_testFile  <- paste(c(testDir,"Inertial Signals/body_acc_y_test.txt"), collapse = "")
body_acc_z_testFile  <- paste(c(testDir,"Inertial Signals/body_acc_z_test.txt"), collapse = "")
body_gyro_x_testFile <- paste(c(testDir,"Inertial Signals/body_gyro_x_test.txt"), collapse = "")
body_gyro_y_testFile <- paste(c(testDir,"Inertial Signals/body_gyro_y_test.txt"), collapse = "")
body_gyro_z_testFile <- paste(c(testDir,"Inertial Signals/body_gyro_z_test.txt"), collapse = "")
total_acc_x_testFile <- paste(c(testDir,"Inertial Signals/total_acc_x_test.txt"), collapse = "")
total_acc_y_testFile <- paste(c(testDir,"Inertial Signals/total_acc_y_test.txt"), collapse = "")
total_acc_z_testFile <- paste(c(testDir,"Inertial Signals/total_acc_z_test.txt"), collapse = "")
## Read files
body_acc_x_test  <- read.table(body_acc_x_testFile)
body_acc_y_test  <- read.table(body_acc_y_testFile)
body_acc_z_test  <- read.table(body_acc_z_testFile)
body_gyro_x_test <- read.table(body_gyro_x_testFile)
body_gyro_y_test <- read.table(body_gyro_y_testFile)
body_gyro_z_test <- read.table(body_gyro_z_testFile)
total_acc_x_test <- read.table(total_acc_x_testFile)
total_acc_y_test <- read.table(total_acc_y_testFile)
total_acc_z_test <- read.table(total_acc_z_testFile)
##
## Now to business - let's set the column names
##
## First read in the labels
featuresFile <- paste(c(rootDir,"features.txt"), collapse = "")
features <- read.table(featuresFile)
## Now set the column names
names(X_test) <- features[[2]]
names(X_train) <- features[[2]]
names(subject_train) <- "subject"
names(subject_test) <- "subject"
names(y_train) <- "activity"
names(y_test)  <- "activity"

## Will merge in two stages for clarity
## First do a column bind to merge the subject and activity information
## Do for both training and test data sets.
testing_set  <- cbind(X_test, subject_test, y_test)
training_set <- cbind(X_train, subject_train, y_train)

## Now combine into one master data set.
## Here it is! The combined data set
combined_set <- rbind(testing_set, training_set)
##
## OK, now we have combined the data. Let's delete the training and test data as
## henceforth we will work with the combined_set
rm(testing_set)
rm(training_set)
##
## ---------------------------------------------------------------
## Part 2: EXTRACT ONLY THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT.
## ---------------------------------------------------------------
##
## First lets do a simple data quality check
## Test to see if there are any NA's
total_na <- sum(is.na(combined_set))
total_not_na <- sum(!is.na(combined_set))
total_values <- total_na + total_not_na  # Sum of NA + !NA = total number of elements
  
nrows <- nrow(combined_set)
ncols <- length(combined_set)
if(total_values == nrows*ncols) {        # nrows*ncols = total number of elements
  print("Dimension check passed ... ")   
  if(total_na == 0) {
    print(" and there are no NA's!")     # life is easier without NA's!
  }
  else {
    print(" with ", total_na, " values")
  }
}
##
## Now extract the columns for mean and standard deviation of each value.
## Some variables are named meanFreq but those will be ignored.
## Only want to retrieve variables that have both mean and std columns.
mean_std_set <- combined_set[,grep("mean[(][)]|std", names(combined_set), value=TRUE)]
## mean_std_set has 66 columns, i.e. 33 variables with mean and std columns for each
##
## ---------------------------------------------------------------
## Part 3: USE DESCRIPTIVE ACTIVITY NAMES FOR THE ACTIVITIES IN THE DATA SET.
## ---------------------------------------------------------------
##
## Will use the combined_set and provide descriptive activity names
## for the activities in the data set.
## Read in activity labels
activity_labelsFile <- paste(c(rootDir,"activity_labels.txt"), collapse = "")
activity_labels <- read.table(activity_labelsFile)
## The first column of activity labels is the index, which ranges from 1:6
## The second column is an explicit label (e.g. WALKING)
## Will map the index to the labels using the mapvalues command
names(activity_labels) <- c("index", "activity")
combined_set[["activity"]] <- mapvalues(combined_set[["activity"]], from = c(activity_labels$index), 
          to = c(as.character(activity_labels$activity)))
## combined_set now has descriptive activity names in the activity column
##
## ---------------------------------------------------------------
## Part 4: APPROPRIATELY LABEL THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES.
## ---------------------------------------------------------------
##
## I personally prefer lowerCamelCase for function names and lowercase for for column names
## I will use the following rules for changing column names : 
## The beginning of the description will be lower case
## parentheses '()' or ')' will be deleted
## If the left parenthesis '(' is not followed immediately by ')', then replace with underscore '_'
## A hyphen '-' or comma ',' in the variable name will be replaced with an underscore
## The camelCase format used for the function descriptor will be preserved.
##
## For convenience let's extract the names and process as a vector
## Now loop through the names to convert first string to lower case, concatenate the result,
## then rename the corresponding combined_set column
##
for( name in 1:ncols ) {
  column_header <- strsplit(names(combined_set[name]), '-') ## Split on hyphen's, which will be removed
  column_header <- gsub('[(][)]|[)]','', unlist(column_header)) ## Delete parantheses
  column_header <- gsub('[(]|,', '_', unlist(column_header)) ## Replace '(' and ',' with '_'
  if((npieces = length(column_header)) > 1) {         ## This adds an '_' before the function name
    column_header[[1]] <- tolower(column_header[[1]])   ## Convert first parsed string element to lowercase
    column_header[npieces] <- paste(c('_', column_header[npieces]), collapse="")
  }    
  column_header <- paste(c(column_header),collapse="") ## Piece the name back together
  colnames(combined_set)[name] <- column_header        ## Assign the column its new name!
}
##
## Now do this for the mean_std_set
##
nmcols <- length(mean_std_set)
for( name in 1:nmcols ) {
  column_header <- strsplit(names(mean_std_set[name]), '-') ## Split on hyphen's, which will be removed
  column_header <- gsub('[(][)]|[)]','', unlist(column_header)) ## Delete parantheses
  column_header <- gsub('[(]|,', '_', unlist(column_header)) ## Replace '(' and ',' with '_'
  if((npieces = length(column_header)) > 1) {         ## This adds an '_' before the function name
    column_header[[1]] <- tolower(column_header[[1]])   ## Convert first parsed string element to lowercase
    column_header[npieces] <- paste(c('_', column_header[npieces]), collapse="")
  }    
  column_header <- paste(c(column_header),collapse="") ## Piece the name back together
  colnames(mean_std_set)[name] <- column_header        ## Assign the column its new name!
}
## Some examples of the renaming process
## Original fBodyAccJerk-bandsEnergy()-49,64
## New      fbodyaccjerkbandsEnergy_49_64
## Original tBodyAcc-correlation()-X,Z
## New      tbodyacccorrelation_X_Z
## Original tBodyGyroJerkMag-arCoeff()3
## New      tbodygyrojerkmag_arCoeff3
##
## ---------------------------------------------------------------
## Part 5: CREATE A TIDY DATA SET THAT IS AVERAGED PER ACTIVITY AND SUBJECT.
## ---------------------------------------------------------------
##
## Create a second, independent tidy data set with the average of each variable 
## for each activity and each subject.
## Grouping is done efficiently with the aggregate function. Use "mean" as the aggregating function.
## Do not average the last 2 columns as those will be used for grouping
all_by_subject_and_activity <- aggregate(x = combined_set[1:(length(combined_set)-2)], 
                             by = list(combined_set$subject, combined_set$activity), FUN = "mean")
meanstd_by_subject_and_activity <- aggregate(x = mean_std_set[1:(length(mean_std_set))], 
                                         by = list(combined_set$subject, combined_set$activity), FUN = "mean")
# Change the names of the grouping columns
colnames(all_by_subject_and_activity)[1] <- "subject"
colnames(all_by_subject_and_activity)[2] <- "activity"
colnames(meanstd_by_subject_and_activity)[1] <- "subject"
colnames(meanstd_by_subject_and_activity)[2] <- "activity"
#avg_by_subject_and_activity[["activity"]] <- mapvalues(avg_by_subject_and_activity[["activity"]], 
#                                        from = c(activity_labels$index), 
#                                        to = c(as.character(activity_labels$activity)))
## And finally ... write out the result!
write.table(meanstd_by_subject_and_activity, file = "EndresCJ_CleaningData_CourseProject.txt", row.names=FALSE)
## After running the preceding command, we create avg_by_subject_activity
## which is a data frame that contains 180 rows = 30 subjects * 6 activities
##
