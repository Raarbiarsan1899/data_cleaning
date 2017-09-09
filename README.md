# data_cleaning
data cleaning course from Coursera of John Hopkins

##
run_analysis.R:

this script process the dataset downloaded from

"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

according to the instructions from Getting and Cleaning Data Course Project.

files should not moved after unzipping the zip file, and this script function in the unzipped folder

###
Step 1: load all data sets in the memory, 

        features.txt: indicate what each column is for each data set
        
        activity_labels.txt: indicate which number stand for which activity
        
        y_train.txt & y_test.txt: indicate the activity for each row, 
                                  converted from number to descriptive names,
                                  as indicated in activity_labels.txt
        
        X_train.txt & X_test.txt: the data sets
        
        subject_train.txt & subject_test.txt: indicate the subject for each row
 
 ###
 Step 2: label/append the data sets with varible names, subjects, activities
 
 ###
 Step 3: subset the data sets which are means and standard deviations
        
         use grep to get features which are means and standard deviations
 
 ###
 Step 4: bind the data sets

 ###
 Step 5: Get the means for each variable for each subject and each activity
 
         split data frame according to subject and activity
         
         use lapply to subset and get average of each column
         
         change list back to the data frame
         
         append Subjects and Activities back to the data frame
         
         label the columns properly

###
Step 6: save the table into ZF_Submission.txt

##
code book.txt:

describe the names of the variables in ZF_Submission.txt

##
ZF_Submission.txt

the processed clean data set

##
README.md

this file
