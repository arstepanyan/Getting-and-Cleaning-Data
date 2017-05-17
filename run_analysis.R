####### 1. MERGE THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET. ######

# 1. Change working directory to the directory where the Samsung data is stored.
# 2. Read training and test data into dataframes. Name dataframes similar to the file names.
# 3 Combine training sets using cbind(). I chose to put y_train column first,
#    then subject_train column and then x_train dataset.
# 4. Combine test sets using cbind(). I chose the same order as in step 3.
# 5. Combine the above two datasets using rbind()

library(dplyr) 

# 1
# setwd("Your_working_directory_here")

# 2
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# 3
combined_train <- cbind(y_train, subject_train, x_train)
# 4
combined_test <- cbind(y_test, subject_test, x_test)
# 5
comb_train_test <- rbind(combined_train, combined_test)

####### 2. EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT. ######

# 1. Read features into dataframe. Name the dataframe as the name of the file.
# 2. In features dataframe the second column is the descriptive names of the features. 
#    Search for indices where "mean" or "std" are found.
# 3. From our comb_train_test data frame select only those columns which correspond to the indices found in step 2.
#    Here we should not forget that we added two columns to the dataframe and we want to keep them. 

# 1
features <- read.table("./UCI HAR Dataset/features.txt")
# 2
mean_std_indices <- grep("[Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]", features[,2])
# 3
mean_std_data <- cbind(comb_train_test[,c(1,2)], comb_train_test[,mean_std_indices + 2])

####### 3. USES DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET. ######

# 1. First we need to read activities from file activity_labels.txt. These will be descriptive activity names.
# 2. As activities are the first column in our mean_std_data data frame, 
#    let's change the numbers in the first column with their corresponding descriptive names. 

# 1
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
# 2
mean_std_data[[1]] <- activity_labels$V2[match(mean_std_data[[1]], activity_labels$V1)]

####### 4. APPROPRIATELY LABELS THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES. ######

# 1. First let's change the first two column names.
# 2. Second, let's change the rest of the names with the names contained in features vector. 
#    Remember that we have the indices of names we need from features vector?
#    Those indices are still in mean_std_indices vector.
# 3. Do some changes to column names to make them more appealing.
#    First, let's remove any punctuation marks. I want to leave only letters.
#    Nice, then let's replace all the "mean" and "std" with "Mean" "Std". This promotes visibility.
# 4. Finally, I like the suggestion made by Luis Sandino:
#    https://www.coursera.org/learn/data-cleaning/discussions/weeks/4/threads/wDoBFcHgEeWjNw6BzriyBQ
#    I am going to change "t" to "time" and "f" to "freq".
#    I also noticed that "gravity" is not visible as it begins with lowercase. Changing it to uppercase.
# 5. Finally I will make all variables begin with capital letters. Example from ?toupper is helpfull.
#    Also removed any repeated "Body" in variable names and changed "t" to "Time" in the middle of variable names.


# 1
colnames(mean_std_data)[1] <- "activities"
colnames(mean_std_data)[2] <- "individualsID"
# 2
colnames(mean_std_data)[3:88] <- as.character(features[,2][mean_std_indices])
# 3
colnames(mean_std_data) <- gsub("[^a-zA-Z]", "", colnames(mean_std_data))
colnames(mean_std_data) <- gsub("mean", "Mean", colnames(mean_std_data))
colnames(mean_std_data) <- gsub("std", "Std", colnames(mean_std_data))
# 4
colnames(mean_std_data) <- gsub("^t", "time", colnames(mean_std_data))
colnames(mean_std_data) <- gsub("^f", "freq", colnames(mean_std_data))
colnames(mean_std_data) <- gsub("gravity", "Gravity", colnames(mean_std_data))
# 5
colnames(mean_std_data) <- paste(toupper(substring(colnames(mean_std_data), 1, 1)), 
                                        substring(colnames(mean_std_data), 2), sep = "")
colnames(mean_std_data) <- gsub("(Body){2}", "Body", colnames(mean_std_data))
colnames(mean_std_data) <- gsub("Anglet", "AngleTime", colnames(mean_std_data))

####### 5. FROM THE DATA SET IN STEP 4, CREATE A SECOND, INDEPENDENT TIDY DATA SET #######
#######    WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT.   #######

my_solution_df <- mean_std_data %>% group_by(IndividualsID, Activities) %>% summarize_each(funs(mean))

#  Finally I will write this data frame into a .txt file and save it in my working directory
write.table(my_solution_df, file = "tidy_data.txt", row.name=FALSE)
