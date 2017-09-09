##need dplyr package
library(dplyr)


features<-read.table("./features.txt",colClasses="character")   #load name of variable names
meanCols<-grep("mean",features[,2])                             #get the features which are "means"
stdCols<-grep("std",features[,2])                               #get the features which are "standard deviations"

activity_labels<-read.table("./activity_labels.txt")            #load activities

train<-read.table("./train/X_train.txt",colClasses="numeric")   #load training set
subject_train<-read.table("./train/subject_train.txt")          #load subjects of training set
y_train<-read.table("./train/y_train.txt")                      #load activities of training set

test<-read.table("./test/X_test.txt",colClasses="numeric")      #load test set
subject_test<-read.table("./test/subject_test.txt")             #load subjects of test set
y_test<-read.table("./test/y_test.txt")                         #load activities of test set

#change activity labels to descriptive names

  for(i in 1:6){
    y_train[which(y_train==i),1]<-as.character(activity_labels[which(activity_labels==i),2])
    y_test[which(y_test==i),1]<-as.character(activity_labels[which(activity_labels==i),2])
  }

#append subject ids and activity names to data sets

    train<-cbind(train,subject_train,y_train)
    test<-cbind(test,subject_test,y_test)

#bind training and test sets

    merged_Data<-rbind(train,test)

#get only means and stds of the dataset

    MeanAndStd<-merged_Data[,c(meanCols,stdCols,ncol(merged_Data)-1,ncol(merged_Data))]

#name and arrange the variables
    names(MeanAndStd)<-c(grep("mean",features[,2],value=TRUE),grep("std",features[,2],value=TRUE),"Subjects","Activities")
    MeanAndStd<-MeanAndStd[,c(80,81,1:79)]

#get average of each variable for each activity and each subject
Inter1<-split(MeanAndStd,list(MeanAndStd$Subjects,MeanAndStd$Activities))                 #split according to subjects/activities
Inter2<-lapply(Inter1,select,3:81)                                                        #choose variables to average for each list
Inter3<-lapply(Inter2,colMeans)                                                           #average each variables for each list
Inter4<-data.frame(Inter3)                                                                #change list to data frame
Inter5<-data.frame(t(Inter4))                                                             #inverse data frame
Inter6<-cbind(Inter5,t(data.frame(strsplit(row.names(Inter5),"\\."))))                    #bind data frame with subjects/activities
Inter6<-Inter6[,c(80,81,1:79)]                                                            #order the variables
names(Inter6)<-c("Subjects","Activities",paste("mean_of_",names(Inter6[3:81]),sep=""))    #name the variables
rownames(Inter6)<-1:180                                                                   #number the rows
Inter6[,1]<-as.character(Inter6[,1])                                                      #change subjects to character
Inter6[,2]<-as.character(Inter6[,2])                                                      #change activities to character
ForSubmission<-Inter6                                                                     #final version

write.table(ForSubmission,file="ZF_Submission.txt",row.names=FALSE)                       #write the table into file for submission
