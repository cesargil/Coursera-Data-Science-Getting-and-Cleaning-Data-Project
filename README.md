# Getting and Cleaning Data - Course Project

This repository contains the files for the Course Project, for Data Science's track course "Getting and Cleaning data", available in Coursera.

## Purpose
The script reads the data of the [Human Activity Recognition Using Smartphones Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
The data is spread over several files, so the information is joined together in one tidied dataset.
Descriptive column names are also added.
Finally, the measurements are averaged per subject and activity.
The results are written to the file `tidy_averages.txt`.

## Files
- `README.md`         - this file
- `CodeBook.md`       - description of the variables
- `run_analysis.R`    - R script
- `tidy_averages.txt` - resulting file from the execution of the script

## Instructions
1. The data must be previously downloaded and unzipped to a folder named `UCI HAR Dataset`, under the current directory where the R script will be run.
2. The package `plyr` is needed and must be previously installed.
3. Execute the R script `run_analysis.R`. The script is self-contained and does all the processing.
4. The resulting file `tidy_average.txt` will be written to the current directory.
