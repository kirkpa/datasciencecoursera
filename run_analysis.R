run_analysis <- function () {
  ##Read test data set
  testData <- read.table("UCI HAR Dataset/test/X_test.txt")
  testLabels <- read.table("UCI HAR Dataset/test/y_test.txt")
  testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
  ##Combine data, labels and subject columns
  testDataSet <- cbind(testSubject, testLabels, testData)
  
  ##Read train data set
  trainData <- read.table("UCI HAR Dataset/train/X_train.txt")
  trainLabels <- read.table("UCI HAR Dataset/train/y_train.txt")
  trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
  ##Combine data, labels and subject columns
  trainDataSet <- cbind(trainSubject, trainLabels, trainData)

  ##combine test and train data by Subject
  combinedDS <- rbind(trainDataSet, testDataSet)
  
  ##Read feature names
  features <- read.table("UCI HAR Dataset/features.txt")
  features <- as.vector(features$V2)
  ##Add Subject and Activity since features.txt does not have Activity and Subject.
  features <- c(c("Subject", "Activity"), features)
  ##Set columns names to the data set
  names(combinedDS) <- features
  combinedDS$Activity[combinedDS$Activity == 1] <- "WALKING"
  combinedDS$Activity[combinedDS$Activity == 2] <- "WALKING_UPSTAIRS"
  combinedDS$Activity[combinedDS$Activity == 3] <- "WALKING_DOWNSTAIRS"
  combinedDS$Activity[combinedDS$Activity == 4] <- "SITTING"
  combinedDS$Activity[combinedDS$Activity == 5] <- "STANDING"
  combinedDS$Activity[combinedDS$Activity == 6] <- "LAYING"
  selectedCols <- c("Subject", "Activity", grep("-mean()", colnames(combinedDS), value=TRUE), grep("-std()", colnames(combinedDS), value=TRUE))
  meanStdCols <- combinedDS[,selectedCols]
  s <- split(meanStdCols, list(meanStdCols$Subject, meanStdCols$Activity))
  aggData <- sapply(s, function(x) colMeans(meanStdCols[,3:length(meanStdCols)])) 
  ##Write data to a file in csv format
  write.table(aggData, file = "UCI HAR Dataset/tidyData.csv", sep = ",", row.names = TRUE, col.names=TRUE)
  aggData

}