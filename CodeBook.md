# GettingCleaningDataCourseProject

1. Load the data in to R
  Call read.table() function to load the data files: test/x_test.txt, test/y_test.txt, test/subject_test.txt, train/x_train.txt, train/y_train.txt, train/subject_train.txt, features.txt and activity_labels.txt.

2. Combine the data together 
  Call rbind() function to combine all the testing data and training data together

3. Extracts only the measurements on the mean and standard deviation for each measurement
  Call grep() function to extract the mean and standard deviation measurements

4. Labels the data set with descriptive variable names
  Unlist the activity variable "Y" inoder to change its numbers to the activity names from variable "activities". And then name the variables in "Y" as "Activities".
  Rename the variables in "subjects" from "V1" to "Subjects"
  Keep the original variable names in each measurement

5. Combine all the data, activity and subject together as one data set "dataset" 

6. Creates a second, independent tidy data set with the average of each variable for each activity and each subject
   First call split() function to split the dataset based on the subjects
   Then call sapply() function to apply melt() function to every subject section by setting the id to "Subjects" and "Activities". 
   After that, call sapply() again to apply a selfmade function mycast() on every molten data frame to caculate the mean of each variable. The mycast() function first change the input as a data frame and then apply the dcast() method with mean() function to caculate the average of each variables. And then add the subject colum to the result data frame
   At last, combine the result of every subject part together and write to file "MyData.txt"
