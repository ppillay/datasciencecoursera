#Codebook

###Contents: 
1.  the data set creation process,
2.  an overview of the different categories of features, 
3.  a description of the feature label readability adjustments, and
4.  of the structure of the the feature labels.

###Data Set Creation Process

1. Processed signal data, activity identifiers and subject identifiers are stored in three separate files. There are two sets of data, stored in separate directories called test and train.
2. First, the three files in each directory are read into data frames, using the `data.table()` command. The three data frames are then collated using the `cbind()` command.
3. The two collated data frames are then concatenated using `rbind()`.
4. The activity identifiers are converted into readable words by using the identifier as an index on a vector of activity labels, and applied over the data frame using the `sapply()` command.
5. From a full set of 561 features, a subset of 66 features relating to signal mean and standard deviation was extracted. The technique used to derive this subset was to search for the existence of either a `mean()` or `std()` string in the feature label using the grepl() command.
6. The `sub()` command is used multiple times to make the column names more readable, as described below.
7. The `melt()` and `dcast()` commands are used to reshape the data frame into one oriented by the identifier variables of subject and activity, and displaying means for each of the measured variables. 
8. The `write.matrix()` command is used to output the tidiet dataset to a file format suitable for uploading to Coursera. If desired, the file extension can be manually changed to `.csv` in order to load the file into a spreadsheet program like Excel.


###Categories of features
1. The raw signals are collected from accelerometer and gyrometer (*BodyGyrometer*) instruments in one of three axes (*-X*,*-Y*,*-Z* suffices).
2. The acceleration data is separated by filtration into body and gravity acceleration signals (*BodyAccelerometer* and *GravityAccelerometer*).
3. Jerk signals were obtained by derivation of the body Acc and Gyro data (*BodyAccelerometerJerk* and *BodyGryometerJerk*).
4. The five groups above also had magnitudes calculated using the Euclidean norm (*Magnitude* interfix).
5. Six of the preceding ten groups had a Fast Fourier Transform applied (*f* prefix): *BodyAccelerometer*, *BodyAccelerometerJerk*, *BodyGyrometer*, *BodyAccelerometerJerkMagnitude*, *BodyGyrometerMagnitude*, *BodyGyrometerJerkMagnitude*.
6. Finally, mean and standard deviation calculations were made for each of these measurements (*-mean* and *-std*).

###Feature Label Readability Adjustments

Some thought was given to expanding the feature labels to make them more readable to the layperson, but given the specialised nature of these measurements, this was kept to a minimum.
The specific changes made for to the feature labels for readability are as follows:

1. Removal of *()* from mean and std interfices.
2. Expanding *Acc* to *Accelerometer*, *Gyro* to *Gyrometer* and *Mag* to *Magnitude*.
3. Replacing *BodyBody* phrase with just *Body*.

###Structure of feature labels

The structure of a feature label is therefore as follows:

**abcdef**
where

* **a**: [*f*,*t*] domain of signal (f for frequency from FFT, t for time from direct or derived measurement)
* **b**: [*BodyAccelerometer*, *GravityAccelerometer*, *BodyGyrometer*] one of three groups of direct measurements described above 
* **c**: [*Jerk*,blank] if derivation was applied to obtain a jerk signal
* **d**: [*Magnitude*,blank] if the magnitude was calculated
* **e**: [*-mean*,*-std*] indicates if a mean or a standard deviation
* **f**: [*-X*,*-Y*,*-Z*,blank] indicates axis of measurement (not applicable to magnitude measurements)

###Units of measurements

Since all measurements have been normalised, they are unitless.