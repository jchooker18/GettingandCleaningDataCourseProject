# GettingandCleaningDataCourseProject

The purpose of the run_analysis.R file is to read the Samsung data into workable tables, consolidate these into a single data frame with only relevant data, and clean the data to ultimately produce a tidy data set. 

Getting the data:

    1. Read in the "features.txt" file to be used as variable names, and the
    "activity_lables.txt" file to be used as descriptive activity names.
    2. Read in the "X_test.txt", "y_test.txt", and "subject_test.txt" files within the
    "test" directory.
    3. Repeat step 2 for the "train" directory.

Consolidating the data:

    1. Column bind all "test" tables into a single data frame.
    2. Repeat step 1 for all "train" tables.
    3. Row bind the "test" and "train" data frames into "alldata" data frame.
    4. Extract only Mean and Standard Deviation measurements (excluding MeanFrequency) from
    "alldata" and store in "alldata_meanstd".

Creating tidy data sets:

    1. Merge the "activity_labels" table with "alldata_meanstd" and drop the "activityID"
    column. Store in "dataset1" - this is a tidy data set.
    2. Further tidy the data by cleaning up and standardizing the variable names, making
    them more descriptive.
    3. Create a second tidy data set ("dataset2) by grouping "dataset1" by "subject" 
    and "activity", then summarizing each variable with the mean() function. This is a
    horizontal tidy data set, where each row contains the means of all variable for one
    subject doing one activity.
    4. Write "dataset2" to a text file named "tidy_data.txt" and return as output.
