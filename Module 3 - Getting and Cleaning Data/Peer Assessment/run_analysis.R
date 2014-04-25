install.packages("reshape2")
install.packages("MASS")
library(reshape2)
library(MASS)

# the three files in the test directory are read into data frames, using data.table()
xtest <- read.table("UCI HAR Dataset//test//X_test.txt")
subject_test <- read.table("UCI HAR Dataset//test//subject_test.txt")
activity_test <- read.table("UCI HAR Dataset//test//y_test.txt")
# the three data frames are then collated using cbind()
test <- cbind(subject_test, activity_test, xtest)

# the three files in the train directory are read into data frames, using data.table()
xtrain <- read.table("UCI HAR Dataset//train//X_train.txt")
subject_train <- read.table("UCI HAR Dataset//train//subject_train.txt")
activity_train <- read.table("UCI HAR Dataset//train//y_train.txt")
# the three data frames are then collated using cbind()
train <- cbind(subject_train, activity_train, xtrain)

# the two collated data frames are then concatenated using rbind()
full_set <- rbind(train,test)

# read in and apply the column names from the features.txt file
col_names <- read.table("UCI HAR Dataset//features.txt",stringsAsFactors=FALSE)
colnames(full_set)[3:563] <- col_names[,2]
colnames(full_set)[1:2] <- c("subjectId","activityId")

# define a vector of activity labels based on the activity_labels.txt file
activities <- c("Walking","Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Lying")
# use the activity id as a vector index and apply over the data frame using sapply()
full_set$activity <- sapply(full_set$activityId, function(v) {activities[v]})

# search for the existence of either a `mean()` or `std()` string in the feature label using the grepl() command.
tryout <- full_set[ , grepl( "-mean\\(\\)|-std\\(\\)" , names( full_set ) ) ]
filtered <- cbind(full_set[,c(1,564)],tryout)

# the `sub()` command is used multiple times to make the column names more readable
names(filtered) <- sub("\\(\\)","",names(filtered),)
names(filtered) <- sub("Acc","Accelerometer",names(filtered),)
names(filtered) <- sub("Gyro","Gyrometer",names(filtered),)
names(filtered) <- sub("BodyBody","Body",names(filtered),)
names(filtered) <- sub("Mag","Magnitude",names(filtered),)

# melt() and dcast() are used to reshape the data frame into one oriented by the 
# identifier variables of subject and activity, 
# and displaying means for each of the measured variables
filtered_melt <- melt(filtered,id=c("subjectId","activity"))
tidied_dataset <- dcast(filtered_melt,subjectId + activity ~ variable, mean)

# write.matrix() is used to output the tidiet dataset to a file format suitable for uploading to Coursera. 
# If desired, the file extension can be manually changed to `.csv` in order to load the file into a spreadsheet program like Excel.
write.matrix(tidied_dataset,file="tidied-dataset.txt", sep=",")