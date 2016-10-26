# Set the working directory to the folder were all the datasets are:
setwd("C:/Users/paul/OneDrive/Coursera/Getting and Cleaning Data/UCI HAR Dataset")

# Get the X datasets:
X_train <- read.table("./train/X_train.txt")
X_test <- read.table("./test/X_test.txt")

# Get the y datasets:
y_train <- read.table("./train/y_train.txt")
y_test <- read.table("./test/y_test.txt")

# Get the subject datasets:
subject_train <- read.table("./train/subject_train.txt")
subject_test <- read.table("./test/subject_test.txt")

# Get the body_acc_x datasets:
body_acc_x_train <- read.table("./train/Inertial Signals/body_acc_x_train.txt")
body_acc_x_test <- read.table("./test/Inertial Signals/body_acc_x_test.txt")

# Get the body_acc_y datasets:
body_acc_y_train <- read.table("./train/Inertial Signals/body_acc_y_train.txt")
body_acc_y_test <- read.table("./test/Inertial Signals/body_acc_y_test.txt")

# Get the body_acc_z datasets:
body_acc_z_train <- read.table("./train/Inertial Signals/body_acc_z_train.txt")
body_acc_z_test <- read.table("./test/Inertial Signals/body_acc_z_test.txt")

# Get the body_gyro_x datasets:
body_gyro_x_train <- read.table("./train/Inertial Signals/body_gyro_x_train.txt")
body_gyro_x_test <- read.table("./test/Inertial Signals/body_gyro_x_test.txt")

# Get the body_gyro_y datasets:
body_gyro_y_train <- read.table("./train/Inertial Signals/body_gyro_y_train.txt")
body_gyro_y_test <- read.table("./test/Inertial Signals/body_gyro_y_test.txt")

# Get the body_gyro_z datasets:
body_gyro_z_train <- read.table("./train/Inertial Signals/body_gyro_z_train.txt")
body_gyro_z_test <- read.table("./test/Inertial Signals/body_gyro_z_test.txt")

# Get the total_acc_x datasets:
total_acc_x_train <- read.table("./train/Inertial Signals/total_acc_x_train.txt")
total_acc_x_test <- read.table("./test/Inertial Signals/total_acc_x_test.txt")

# Get the total_acc_y datasets:
total_acc_y_train <- read.table("./train/Inertial Signals/total_acc_y_train.txt")
total_acc_y_test <- read.table("./test/Inertial Signals/total_acc_y_test.txt")

# Get the total_acc_z datasets:
total_acc_z_train <- read.table("./train/Inertial Signals/total_acc_z_train.txt")
total_acc_z_test <- read.table("./test/Inertial Signals/total_acc_z_test.txt")

# Get the miscellaneous datasets:
activity_labels <- read.table("./activity_labels.txt")
features <- read.table("./features.txt")

# Append the datasets (the assigment says "merge", but that's not the right term):
library(data.table)
X_combined <- rbind (X_train, X_test)
y_combined <- rbind (y_train, y_test)
subject_combined <- rbind (subject_train, subject_test)
body_acc_x_combined <- rbind (body_acc_x_train, body_acc_x_test)
body_acc_y_combined <- rbind (body_acc_y_train, body_acc_y_test)
body_acc_z_combined <- rbind (body_acc_z_train, body_acc_z_test)
body_gyro_x_combined <- rbind (body_gyro_x_train, body_gyro_x_test)
body_gyro_y_combined <- rbind (body_gyro_y_train, body_gyro_y_test)
body_gyro_z_combined <- rbind (body_gyro_z_train, body_gyro_z_test)
total_acc_x_combined <- rbind (total_acc_x_train, total_acc_x_test)
total_acc_y_combined <- rbind (total_acc_y_train, total_acc_y_test)
total_acc_z_combined <- rbind (total_acc_z_train, total_acc_z_test)

# Get the 'explanatory' datasets:
activity_labels <- read.table("./activity_labels.txt")
features <- read.table("./features.txt")

# To get the mean and standard deviation for each measurement, 
# we first get the row indices of the features which contain the word "mean" or "std":
featureIndices <- grep("mean|std", features$V2)
# Then we get the columns from X_combined which correspond to these features:
X_relevant <- X_combined[,featureIndices]

# Use the feature indexes we got through grepping to get the feature descriptions, then assign the descriptions to..
# ...the columns of X_relevant:
colnames(X_relevant) <- features[featureIndices,2]

# The first column of y_combined is the activity number. Use it on activity_labels to get the description:
Activity_desc <- activity_labels[y_combined[,1],2]

# Add the description to X_relevant:
X_relevant <- cbind(Activity_desc, X_relevant)

# Get the average per activity (for all subjects):
aggTable <- aggregate(X_relevant[,2:80], list(X_relevant$Activity_desc), mean)
TidySet <- melt(aggTable, id="Group.1", measure.vars=names(aggTable[,2:80]))

write.table(TidySet, "./TidySet.txt", row.name=FALSE)
