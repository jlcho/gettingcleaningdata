#Code book for Getting & Cleaning Data - Project 1

##Variable Names - Definition

*actlables - reads activity_label data

*features - reads feature data

*stdmean_features - logical vector that subsets standard deviation and mean

*xtest - reads x_test data. The standard deviation and mean gets subsetted in the end.

*ytest - reads y_test data

*subjtest - reads subject_test data

*xtrain - reads x_train data. The standard deviation and mean gets subsetted in the end.

*ytrain - reads y_train data

*subjtrain - reads subject_train data

*comptrain - column binds subject train, ytrain, and xtrain data

*comptest - column binds subject test, ytest, xtest data

*compdata - complete data set by row binding comptest and comptrain

*meltdata - melted down data compdata

*tidydata - tidyd dataset
