#install data.table package if not installed.
if (!require("data.table")){
  install.packages("data.table")
}

#install reshape2 package if not installed
if (!require("reshape2")){
  install.packages("reshape2")
}

require("data.table")
require("reshape2")

#Load activity labels
actlabels<-read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

#Load data column names
features<-read.table("./UCI HAR Dataset/features.txt")[,2]

#Subset only standard deviation and mean for each measurement
stdmean_features<-grepl("mean|std",features)

#Load and process X_test and y_test data

xtest<-read.table("./UCI HAR Dataset/test/X_test.txt")
ytest<-read.table("./UCI HAR Dataset/test/y_test.txt")
subjtest<-read.table("./UCI HAR Dataset/test/subject_test.txt")
names(xtest)=features

#Load and process X_train and y_train data
xtrain<-read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain<-read.table("./UCI HAR Dataset/train/y_train.txt")
subjtrain<-read.table("./UCI HAR Dataset/train/subject_train.txt")
names(xtrain)=features

#Subset only standard deviation and mean for each measurement
xtest<-xtest[,stdmean_features]
xtrain<-xtrain[,stdmean_features]


#Load activity data for y_train
ytrain[,2]=actlabels[ytrain[,1]]
names(ytrain)=c("Activity_ID","Activity_Label")
names(subjtrain)="Subject"

#Load activity labels for y_test
ytest[,2]=actlabels[ytest[,1]]
names(ytest)=c("Activity_ID","Activity_Label")
names(subjtest)="Subject"

#Create complete train data
comptrain<-cbind(as.data.table(subjtrain),ytrain,xtrain)

#Create complete test data
comptest<-cbind(as.data.table(subjtest),ytest,xtest)

#Merge train and test data
compdata<-rbind(comptest,comptrain)

idlabels<-c("Subject","Activity_ID","Activity_Label")
datalabels<-setdiff(colnames(compdata),idlabels)
meltdata<-melt(compdata,id=idlabels,measure.vars=datalabels)

#Use dcast to apply mean to dataset
tidyData<-dcast(meltdata, Subject+Activity_Label ~ variable, mean)

write.table(tidyData,file="./tidyData.txt", row.names = FALSE)
