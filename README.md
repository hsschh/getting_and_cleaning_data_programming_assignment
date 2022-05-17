This is the README for my course assignment.
The required upload consists of three documents:
1. this README including info about the data source
2. an R Script showing the code used to get from the source data to the tidy data file
3. the tidy data file (.txt format)


DATA:
The data was obtained from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones, provided within in the course assignment. 

DATA PROCESSING:
As indicated by comment headers in the R Script, there were several steps of data preparation:
Part 1 consists of reading the different data files provided in the source folders. In order to be able to patch them all together in one big dataset, I named the variables using info from the features-file (also provided with the source files). After building one dataset consisting of all test data, I did the same for all training data and for a last step, used rbind to patch the two together.

EXTRACTING MEAN & SD MEASUREMENTS:
For the first task, I extracted all variables which report means or standard deviations to a separate dataset called "msddata". I did so by using grepl() to select columns by name. 

DESCRIPTIVE ACTIVITY NAMES:
Acitivity was indicitated by numbers in the raw dataset. Using the activity_labels file (also provided with the data), I changed the variable activityID to a factor.

LABEL EVERYTHING:
This part is merely cosmetic, I removed all non-statistical abbreviations from the variable names and changed activityID to activity as it now consists of readable factor values. Furthermore, I removed all special characters from the variable names except the , which has content-related value. For better usage, I changed the - to _. 

TIDY DATASET WITH MEANS:
For a last step, I made a new tidy dataset, including subjectID, activity and all the mean values collected in msddata a few steps before. Using mean(), I calculated the average for each activity & subject and saved it all to the .txt file which is also uploaded in this repository (tidydataset.txt).
