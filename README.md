GettingCleaningData
===================

This is a repository for the Coursera/JHU Getting and Cleaning Data course

All code for this project contained in runAnalysis.R

The program loads in all data from the UCI HAR Dataset
Note - since I don't like spaces in directory names I renamed the main folder to UCIHARDataset
At the beginning of runAnalysis.R I do a simple check to see if an alternative folder is defined
for the data. Otherwise, it will be assumed that the data are in the working directory.
All data are read in even though all is not used.

The training data set is pieced together as follows
X_train       = 7352 observations of 561 variables
subject_train = 7352 subject ID's
y_train       = 7352 observations of activity type

X_test        = 2947 observations of 561 variables
subject_test  = 2947 observations of subject ID's
y_test        = 2947 observations of activity type

X columns names are obtained from features.txt
subject column is entitled "subject"
y columns is entitled "activity"

For training and test sets the subject and y columns are appended to the X columns
Thus after the append, the data sets are:

Training set = 7352 rows x 563 columns
Testing set  = 2947 rows x 563 columns

The training and testing sets are then combined (with rbind) to get
a combined set, where combined_set = 10299 rows x 563 columns

The initial y data sets (y_train, y_test) contain numeric identifiers (1:6) indicating the activity type.
These values are replaced with the actual activity names using the mapvalues function.

Data columns were relabeled according to my personal preference, which is to use mostly lower case.
For function names contained within the column header I used lowerCamelCase.
For some separators such as '(', ',', or '-' I inserted an underscore '_'

For the tidy data set I selected variables that had both a mean and std column. This resulted in 66 columns
that corresponded to the mean and standard deviation of 33 variables. Thus the mean + std data set was:
mean_std_set = 10299 rows x 66 columns
After grouping by 30 subjects and 6 activitys, the final tidy data set was
meanstd_by_subject_and_activity = 180 rows x 68 columns.

Note that in the tidy data set there were two columns inserted at the beginning to indicate the subject
and activity group. Thus columns 3-68 in the tidy data set correspond to columns 1-66 in the original mean_std set.



