# Libraries used in this project
library("data.table")
library("dplyr")
library("tidyr")
library("mgsub")

# Regex table has all the regular expressions for transforming the feature names
regexTable <- as.data.frame(cbind(regex=c("\\()|-",
                            "std",
                            "^(t)",
                            "^(f)",
                            "([Bb]ody)+",
                            "[Gg]yro",
                            "Acc",
                            "[Mm]ag",
                            "Freq",
                            "mean"),
                    replace= c("",
                               "StandardDeviation",
                               "time",
                               "frequency",
                               "Body",
                               "Gyroscope",
                               "Acceleration",
                               "Magnitude",
                               "Frequency",
                               "Mean")))

run_analysis <- function(){
    # Inner function for transforming the feature names to a more readable format
    prettyfyNames <- function(names){
        mgsub(mgsub(names,pattern=regexTable$regex,regexTable$replace),'[0-9]+', '')
    }
    # Inner Function for find the type (Mean or Standard Deviation)
    findType <- function(feature){
        ifelse(grepl(".*std*",feature),"Std","Mean")
    }
    # Loading the activity labels
    activity.labels <- fread("activity_labels.txt",sep=" ",col.names = c('id','activityName'))
    
    # Loading the features and assigning the values to id and feature columns
    features <- fread("features.txt",sep=" ",col.names = c('id','feature'))
    #features <- features %>% mutate(feature=prettyfyNames(feature))
  
    # Loading the train subjects and assigning the values to subjectId column 
    subject.train <- fread("train/subject_train.txt",col.names=c('subjectId'))
    
    # Loading the y_train and assigning the values to label column
    y.train <- fread("train/Y_train.txt",col.names = c('label'))
    
    # Creating a x.train dataset with subject.train (subjecdId), source as train and
    # Loading x_train assigning the values to a unique column name based on id-feature
    x.train <- cbind(subject.train,y.train,source=rep("train",length(subject.train)),
                     fread("train/X_train.txt",col.names = paste0(features$id,"-",features$feature)))
                    # fread("train/X_train.txt",col.names = paste0(features$id,"-",features$feature)))
    
    # Loading the subject_test and assigning the values to subjectId column
    subject.test <- fread("test/subject_test.txt",col.names = c('subjectId'))
    
    # Loading the y_test and assinging the values to label column
    y.test <- fread("test/Y_test.txt",col.names = c('label'))
    
    # Creating a column with the subject.test (subjectId), source as test and
    # Loading x_test assigning the values to a unique column name based on id-feature
    x.test <- cbind(subject.test,y.test,source=rep("test",length(subject.train)),
                    fread("test/X_test.txt",col.names = paste0(features$id,"-",features$feature)))
    # Creating a dataset called merged that concatenate the x.test after x.train
    merged <- rbind(x.train,x.test)
    
    # Creating a filter for use just mean and std features based on the column names of merged dataset
    filterMeanAndStd <- grep(".*mean.*|.*std.*",names(merged))
    
    # Using pipes, where the input is merged following the next steps:
    # 1) Selecting subjectId, label, source, and the filtered features
    # 2) Gathering by feature as key creating a value that is the result of the range from 4 to 82 features columns
    #    Ignoring source and label for avoiding dataset contamination
    # 3) Mutating the dataset adding activity (for the activity name) and type (for Mean or Std)
    transformed <- merged %>% select(subjectId,label,source,names(merged)[filterMeanAndStd]) %>%
        gather(feature,value,4:82,-(source),-(label)) %>% 
        mutate(activity=activity.labels[label]$activityName,type=findType(feature))
    
    # 4) Grouping by activity, source (train or test), subjectId and type (Mean or Std)
    # 5) Summarizing the values and assinging them to average column
    tidyData <- transformed %>% group_by(activity,source,subjectId,type,feature) %>% 
        summarize(average=mean(value)) %>% mutate(feature=prettyfyNames(feature))
    
    # Storing the data inside tidyData.txt
    write.table(tidyData,"tidyData.txt",row.names = FALSE,sep="\t")
}
