Following are the steps used to clean and tidy the data
1. Load both test and train data into R, including x, y, and subject data
2. Load names in the features.txt file in another data table.
3. Assign Activity names from activity_labels.txt.
4. Assign column names to the 2 X data tables, table with subject IDs and table with Activity data.
5. Assign Activity description to numbers indicating activity
6. Add the subject ID and Activity columns to other columns of test and train data tables.
7. Change the names of the 2nd column in both the test and the train data tables to make them same before rbind().
8. rbind all the rows of both the data sets to get data of all the subjects in one data table.
9. Create a vector with column indices of the columns needed.
10. Extract only the columns required.
11. Summarise the data using group_by for each subject and Activity.
12. Write the tidy data table to a file.
