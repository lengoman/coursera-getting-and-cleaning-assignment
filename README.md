# Getting and Cleaning Data - Course Project


#### Platform Specs

**macOS** Mojave

`platform       x86_64-apple-darwin15.6.0 `  
`arch           x86_64  `                    
`os             darwin15.6.0  `              
`system         x86_64, darwin15.6.0  `      
`version.string R version 3.5.1 (2018-07-02)`

# Project Overview

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

# The dataset includes the following files:

>'README.txt'
>'features_info.txt': Shows information about the variables used on the feature vector.
>'features.txt': List of all features.
>'activity_labels.txt': Links the class labels with their activity name.
>'train/X_train.txt': Training set.
>'train/y_train.txt': Training labels.
>'test/X_test.txt': Test set.
>'test/y_test.txt': Test labels.

### The following files are available for the train and test data. Their descriptions are equivalent. 

>- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

>- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

>- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

>- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

## Data Source 
> Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

[Link to Data Source](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[Link to Zip file with data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

---

### Install Required Packages

```sh
$ install.package ("data.table")
$ install.package ("dplyr")
$ install.package ("tidyr")
$ install.package ("mgsub")
```

# Run ...

```sh
$ run_analysis()
```

### Libraries Used in this project

| Name | Package |
| ------ | ------ |
| Data Table | data.table |
| dplyr | dplyr |
| tidyr | tidyr |
| mgsub | mgsub |

### Installation Instructions

```sh
unzip FUCI HAR Dataset.zip
setwd("UCI HAR Dataset")
download libraries
load libraries
run_analysis()
enjoy!
```
