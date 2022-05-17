# read features
features <- read.table("./features.txt")

### test data
# read 
xtest <- read.table("./test/X_test.txt")
ytest <- read.table("./test/y_test.txt")
subjecttest <- read.table("./test/subject_test.txt")

# name 
colnames(xtest) <- features[, 2]
colnames(ytest) <- "activityID"
colnames(subjecttest) <- "subjectID"

# merge
test <- cbind(subjecttest, ytest, xtest)

### train data
# read
xtrain <- read.table("./train/X_train.txt")
ytrain <- read.table("./train/y_train.txt")
subjecttrain <- read.table("./train/subject_train.txt")

# name
colnames(xtrain) <- features[, 2]
colnames(ytrain) <- "activityID"
colnames(subjecttrain) <- "subjectID"

# merge
train <- cbind(subjecttrain, ytrain, xtrain)

### merge training & test
merged <- rbind(train, test)

# extract only the measurements on the mean & sd for each measurement
msdcols <- grepl("subject|activity|mean|std", colnames(merged))
msddata <- merged[, msdcols]

### descriptive activity names for the variables
activitylabels <- read.table("./activity_labels.txt", col.names = c("activityID", "activitylabel"))
merged$activityID <- factor(merged$activityID,  
                          levels = activitylabels[, 1],
                          labels = activitylabels[, 2])

### label everything
allcols <- colnames(merged)

# remove abbreviations from names
allcols <- gsub("^t", "Time", allcols)
allcols <- gsub("^f", "Frequency", allcols)
allcols <- gsub("Acc", "Acceleration", allcols)
allcols <- gsub("Gyro", "Gyroscope", allcols)
allcols <- gsub("Mag", "Magnitude", allcols)

# change activityID to activity
allcols <- gsub("activityID", "activity", allcols)

# remove special characters from names
allcols <- gsub("[\\(\\)-]", "", allcols)
allcols <- gsub(",", "_", allcols)

colnames(merged) <- allcols

### new dataset with the average of each variable for each activity & subject
class(msddata$subjectID)
msddata$subjectID <- as.factor(msddata$subjectID)

tidydataset <- aggregate(. ~subjectID + activity, msddata, mean)
tidydataset <- tidydataset[order(tidydataset$subjectID, tidydataset$activity),]

# write to .txt file
write.table(tidydataset, file="tidydataset.txt", row.names = F)
