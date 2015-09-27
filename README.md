# getting_and_cleaning_data
Getting and Cleaning Data Project

This is the course project for the Coursera course "Getting and Cleaning data", part of the Data Science specialization.

The following file serves as the dataset for this project

  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

includes the following files:
=========================================

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt' and 'test/subject_test.txt': 
     Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 


The R script run_analysis.R merges the test and training sets together. 
The mean and standard deviation columns of the observations are then extracted, labels are added to identify the columns.
The script applies the "aggregate" function for the columns, calculates the means for each test for each activity.
A tidy data set is produced with this "aggregate" output, a tab-delimited file "tidy.txt".

About the Code Book

The CodeBook.md file explains the transformations performed and the resulting data and variables.
