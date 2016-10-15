### run_analysis.R - getting and cleaning data
### Created by RV - 10/15/2016 
#downloaded Zip file into data folder. 

# read the files 

# Read Test Tables into R 

xtest <- read.table("y_test.txt")
ytest <- read.table("y_test.txt")
stest <- read.table("subject_test.txt")

#checked the read of the test tables
head(xtest,2)
head(ytest,2)
head(stest,2)

# Read Training Tables into R

xtrain <- read.table("X_train.txt")
ytrain <- read.table("y_train.txt")
strain <- read.table("subject_train.txt")

#checked the read of the train tables

head(strain,2)
head(ytrain,2)
head(xtrain,2)

## Obtaining Column names

colnames(xtrain) <- t(ftr[2])
colnames(xtest) <- t(ftr[2])

# Appending Activities and Participants columns to the Test data
xtest$activities <- ytest[,1]  
xtest$participants <- stest[,1] 

# Appening Activities and Participants columns to the Train data  

xtrain$activities <- ytrain [,1]
xtrain$participants <- strain [,1]

# Checking the columns were added to Training data
colnames(xtrain)
head(xtrain,2)

# Checking the columns were added to Test data
colnames(xtest)
head(xtest,2)
### =================================================================


### Assignment 1:  Merges the training and the test sets to create one data set.

## Binding the rows from the two datasets 
MasterData1 <- rbind(xtrain, xtest)
View MasterData1 

### On checking the columns of Training and Testing data sets found duplicate columns
## Checking duplicate names 

duplicated(colnames(MasterData1),value = TRUE)


## Getting rid of duplicates
MasterData2 <- MasterData1 [, !duplicated(colnames(MasterData1))]

## Visually checking MasterData2 for duplicates
View(MasterData2)


# Ensured No duplicate Columns... 
duplicated(colnames(MasterData2),value = TRUE)


### Writing a physical file with the merged data 
write.table (MasterData2, file="MergedData-MasterData2.csv", row.names=FALSE)

###### MasterData2 - is the final Merged Data #####################

#### ==========================================================


### Assignment 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
### Using MasterData2 merged data for this section

### Extracting the Means related columns

Mean <- grep("[mM]ean[()]", names(MasterData2), value = FALSE)

# Displaying Mean for a visual check
Mean 

# Creating a Matrix of data that includes all Means related Columns
MeanMatrix = MasterData2[,Mean]

### Extracting Standard Deviation related columns.

SD <- grep("std()", names(MasterData2), value = FALSE)

## Displaying SD for a visual check
SD

## Creating a Matrix of data that includes all SD Related Columns
SDMatrix = MasterData2[,SD]

### Appending SD Related Columns to Mean Related Columns 
MeanSD <- append(Mean,SD)

## Creating a Matrix of data that includes all Means & SD Related Columns
MeanSDMatrix = MasterData2[,MeanSD]


### writing a physical file that captures data with all Means and SD related columns -- just an extra check 
write.table (MeanSDMatrix, file="MeanSDMatrix.csv", row.names=FALSE)

###########===========================================================


### Assignment 3: Uses descriptive activity names to name the activities in the data set
### continued using MasterData2 Merged data for this section


### Visually checking how activities are listed again, and turning the activities to character for manipulation 
head(MasterData2,2)
MasterData2$activities <- as.character(MasterData2$activities)

### using descriptive words for the numbered activities adn updating the fields in MasterData2 

MasterData2$activities[MasterData2$activities==1] <- "Walking"
MasterData2$activities[MasterData2$activities==2] <- "Walking Upstairs"
MasterData2$activities[MasterData2$activities==3] <- "Walking Downstairs"
MasterData2$activities[MasterData2$activities==4] <- "Sitting"
MasterData2$activities[MasterData2$activities==5] <- "Standing"
MasterData2$activities[MasterData2$activities==6] <- "Laying"


#### Finally checking that the updates have gone through & Visually checked the display 

head(MasterData2,2)

#### ============================================

#### Assignment 4: Appropriately labels the data set with descriptive variable names 
###  Continue using MasterData2 Merged data for this section

### Identified some of the variables started with t for time, f for freq and used mag for magnitude.
### Changed them to be descriptive

names(MasterData2)
names(MasterData2) <- gsub("^t", "time", names(MasterData2))
names(MasterData2) <- gsub("^f", "Freq", names(MasterData2))
names(MasterData2)
names(MasterData2) <- gsub("Mag", "Magnitude", names(MasterData2))

#### Participants displayed as numbers 1, 2, 5 etc to something more meaningful
#####

for (i in 1:30) {
MasterData2$participants[MasterData2$participants == i] <- paste("Participant", as.character(i))
}

### Checking Participants are appropriately formatted visually

head(MasterData2,2)
tail(MasterData2,10)

##### ==========================================

#### Assignment 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for #### each activity and each subject. ---#


TidyMasterData <- data.table(MasterData2)

### grouping the data based on participants and Activities

TidyMasterDatagrouped <- TidyMasterData[,lapply(.SD,mean), by='participants,activities']

### Finally writing a physical file with the data grouped by participant and activities. 

write.table(TidyMasterDatagrouped,file="TidyMasterDatagroupedfinal.csv", row.names=FALSE)






