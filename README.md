# Getting-and-Cleaning-Data
Coursera Getting and Cleaning Data course project. A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## Porpuse of this document
  * Tell what documents Getting-and-Cleaning-Data repository contains  
  * Help on understanding and running the run_analysis.R script  

### What documents Getting-and-Cleaning-Data repository contains
1. README.md  
    _Current document_
2. run_analysis.R  
    _The script to transform data from Coursera website to a tidy data_
3. CodeBook.md  
    _List of all variables in tidy data set with their descriptions_
  
### Understanding and running the run_analysis.R script

**Understanding run_analysis.R script**

run_analysis.R file has a detailed explanation on how the code works. You can either read the comments in run_analysis.R or follow the summary below.   

_Five major parts of the code(Coursera site served as a guideline):_  
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

_How each part works_
1. Reads Samsung data into data frames and using _cbind()_ and _rbind()_ creates one data set.
2. Reads features.txt file into a data frame and using _grep()_ finds features whith "mean" and "std" in their names.
Selects only columns of means and stds.
3. Reads activity_labels.txt into a data frame and uses those descriptive names to name the activities.
4. A bunch of _gsub()_ change variable names into readable and understandable names.
5. Uses _dplyr_ package to group and summarize data. The result is our tidy data. Tidy data is then written into a file named tidy_data.txt in your working directory.

**Running run_analysis.R script**  

* Before running run_analysis.R script make sure you have Samsung data in your working directory.
* When you run the script the resulting tidy data is written into tidy_data.txt file. This file will be created in your working directory. Make sure you don't have another file with the same name as you will lose it.
* The command for reading tidy_data.txt back into R and looking at it in R is (suggested in [David Hood's post](https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/))
     ```R
     data <- read.table(change_this_to_the_file_path, header = TRUE)
     View(data)
     ```
* To view the data I submitted in Coursera site, run the following code (suggested in [David Hood' s post](https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/))
    ```R
    address <- "https://s3.amazonaws.com/coursera-uploads/peer-review/c2bb9231d83f0442ee6110a7f7d1d0f1/tidy_data.txt"
    address <- sub("^https", "http", address)
    data_from_coursera <- read.table(url(address), header = TRUE)
    View(data)
    ```
* To check if above two data frames are the same (data vs data_from_coursera), run one of the following commands:
    ```R
    all.equal(data, data_from_coursera)
    ```
    or
    ```R
    identical(data, data_from_coursera)
    ```
    Both will return TRUE if data frames are the same.
    
## References
1. David Hood's post  
    [Coursera discussion forums about David Hood's post](https://www.coursera.org/learn/data-cleaning/discussions/weeks/4/threads/g7dwW25DEeaFmBJqjnMcrw)  
    [Getting and Cleaning the Assignment, David Hood](https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/)
2. ["Tidy Data", Journal of Statistical Software, Hadley Wickham](http://vita.had.co.nz/papers/tidy-data.pdf)
3. [Coursera discussion by Luis Sandino](https://www.coursera.org/learn/data-cleaning/discussions/weeks/4/threads/wDoBFcHgEeWjNw6BzriyBQ)

    


