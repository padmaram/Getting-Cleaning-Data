# Getting-Cleaning-Data
### Created by RV - 10/15/2016
Downloaded the various data files from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Extracted the files.

Read the tables into R 

Appended activities and participants columns to X_train and X_test datasets 

Obtained column names from features.txt

Merged the training and test datesets to create one dataset and removed duplicated columns

Used the Merged master data set to answer the questions required.

Code: run_analysis.R

Code is well documented to explain the process used.

Required Outputs generated:

Physical file : TidyMasterDatagroupedfinal.CSV - displays data broken down by participants and activities .
