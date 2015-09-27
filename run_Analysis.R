##  Name:    run_analysis.R
##  Purpose: This script collects data from multiple sources, combine them a single dataset
##               and applies the aggregate function to produce a tidy data set that can be used
##               for further analysis.
##
##           The input data for this comes from 
##             https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
##
##  Output:  This will produce a file "tidy.txt" with the cleaned up data.

## set the working directory and download the file, and unzip it

setwd("C:/users/gvsha/Documents/coursera/3Get_Clean_Data")

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
#download.file(fileUrl, destfile = "proj2_DC.zip", mode='wb')
dateDownloaded <- date()

#unzip("proj2_DC.zip")

## The "train" and "test" data sets are the same data basically split into a 70:30 ratio.
##  Each set has 3 files (X, Y, subject)
##
##    X - the actual test data
##    Y - The labels (names) of the tests
##    subject - The number of people who took the test (30).

tr1 <- read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
tr1[,2] <- read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

train <- read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)

tst1 <- read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
tst1[,2] <- read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

tst <- read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)

train_tst = rbind(train, tst)
tr1_tst1  = rbind(tr1,tst1)

## The "features" file shows the names of the tests conducted.

features = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)

## Only interested in the "mean" and "standard deviation" observations.

##  On the column names file, Read, and filter out the other readings
##  Also, change the names to something meaningful, remove some unwanted characters

mean_std_cols <- grep("*mean*|*std*", ignore.case=TRUE, features$V2)

nfeatures <- features[mean_std_cols,]
nfeatures[,2] = gsub('mean', 'Mean', nfeatures[,2])
nfeatures[,2] = gsub('std', 'SDev', nfeatures[,2])
nfeatures[,2] = gsub('[()]', '', nfeatures[,2])
nfeatures[,2] = gsub(',', '-', nfeatures[,2])

# On the dataset, Select only the mean and standard deviation readings and filter out the rest

new_tt <- train_tst[, mean_std_cols]

# Read the names of the activities that the subjects did.
##   and record it in the name dataset.

actLabels = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

for (i in nrow(tr1_tst1)) {                                
  tr1_tst1$activity <- actLabels[tr1_tst1$V1,]$V2      
} 
tr1_tst1$activity <- as.factor(tr1_tst1$activity)

# Combine the name and the actual data set of the observations.

ntt <- cbind(tr1_tst1, new_tt)
colnames(ntt) <- c("ActNum", "Subject", "Activity", nfeatures$V2)

ntt$ActNum <- as.factor(ntt$ActNum)
ntt$Subject <- as.factor(ntt$Subject)

# Aggregate the data based on the mean for each activity and individual.

tidy = aggregate(ntt, by=list(Activity = ntt$Activity, Subject=ntt$Subject), mean)

# The following columns are not needed in the "mean"

tidy[,5]=NULL
tidy[,4]=NULL
tidy[,3]=NULL

# Produce a result tidy set for upload.

write.table(tidy, "tidy.txt", sep="\t", row.names = FALSE)
