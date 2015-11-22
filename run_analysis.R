mycast <- function(x) 
{
  x <- as.data.frame(x)
  # caculate the mean on every variable
  result <- dcast(x, Activities~variable, mean) 
  # add the Subjucts colum 
  result <- cbind(Subjects=x$Subjects[[1]],result)
  return(result)
}

## Read all the data sets
testX <- read.table("test/x_test.txt")
testY <- read.table("test/y_test.txt")
testSubjects <- read.table("test/subject_test.txt")

trainX <- read.table("train/x_train.txt")
trainY <- read.table("train/y_train.txt")
trainSubjects <- read.table("train/subject_train.txt")

features <- read.table("features.txt")

activities <- read.table("activity_labels.txt")

## combine the training and testing data sets
X <- rbind(testX,trainX)
Y <- rbind(testY,trainY)
subjects <- rbind(testSubjects,trainSubjects)

## Extracts only the measurements on the mean and standard deviation for each measurement. 
meanstd <- grep("mean|std",features$V2)
X <- X[,meanstd]

## Change activity numbers to activity names
Y <- unlist(Y)
Y <- activities$V2[Y]
Y <- as.data.frame(Y)

## give every feature names 
names(X) <- features$V2[meanstd]

## name the activies
names(Y) <- "Activities"

## name the subjects
names(subjects) <- "Subjects"

## combine data, activitis and subjects to one dataset 
dataset <- cbind(X,Y,subjects)


## creates a second, independent tidy data set with the average of each variable 
## for each activity and each subject
subjectActDataset <- split(dataset,dataset$Subjects)

subjectActDataset <- sapply(subjectActDataset, melt,id=c("Subjects","Activities"))

subjectActDataset <- as.data.frame(subjectActDataset)

actmeand <- sapply(subjectActDataset, mycast)

actmeand <- as.data.frame(actmeand)

## create data frame and write to a txt file
dataframe <- as.data.frame(actmeand[[1]])
for (i in 2:length(actmeand)){
  dataframe <- rbind(dataframe,as.data.frame(actmeand[[i]]))
}

write.table(dataframe,file = "MyData.txt")




