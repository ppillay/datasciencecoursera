#README

###Contents: 
1.  assumptions, and
2.  an overview of the different categories of features, 

###Assumptions
The unpacked Samsung sensor data will be present in the working directory of the R environment.
ie. the UCI HAR Dataset top-level directory will be present in the working directory.

###Data Set Creation Process

1. Processed signal data, activity identifiers and subject identifiers are stored in three separate files. There are two sets of data, stored in separate directories called test and train.
2. First, the three files in each directory are read into data frames, using the `data.table()` command. The three data frames are then collated using the `cbind()` command.
3. The two collated data frames are then concatenated using `rbind()`.
4. The activity identifiers are converted into readable words by using the identifier as an index on a vector of activity labels, and applied over the data frame using the `sapply()` command.
5. From a full set of 561 features, a subset of 66 features relating to signal mean and standard deviation was extracted. The technique used to derive this subset was to search for the existence of either a `mean()` or `std()` string in the feature label using the grepl() command.
6. The `sub()` command is used multiple times to make the column names more readable, as described below.
7. The `melt()` and `dcast()` commands are used to reshape the data frame into one oriented by the identifier variables of subject and activity, and displaying means for each of the measured variables. 
8. The `write.matrix()` command is used to output the tidiet dataset to a file format suitable for uploading to Coursera. If desired, the file extension can be manually changed to `.csv` in order to load the file into a spreadsheet program like Excel.
