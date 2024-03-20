# preprocessing lp2 text data 
if (!require("pacman")) install.packages("pacman") #run this if you don't have pacman 
library(pacman)
pacman::p_load(tidyverse) #for preprocessing 
setwd("/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/phonic-data/wave1") #use box sync to get the data, please try not to save locally 
#load in one of the datasets

#first clear your global environment 
rm(list = ls())

#now load in a piece of data to peek at the structure 

autonomy <- read_csv("Lotic_Autonomy.csv")
head(autonomy) # look at the structure 
# and the column names 
colnames(autonomy)

#to create the word-embeddings we are going to need to extract the text variables and responseID (so we can keep track of who is who)# Specify the directory containing the CSV files
directory_path <- 

# List all files in the directory
file_list <- list.files(path = directory_path, full.names = TRUE)

# Iterate through each file and process it
for (file_path in file_list) {
  # Read the dataframe from the file
  df <- read_csv(file_path)  # Adjust the appropriate read function
  
  # Select the columns you want to keep
  selected_columns <- df %>%
    select(Date, `Session ID`, `User-Agent`, responseId, ends_with("Transcription"))
  
  # Extract the file name (without extension) to use as the new file name
  file_name <- tools::file_path_sans_ext(basename(file_path))
  
  # Define the output file path
  output_file_path <- file.path(directory_path, paste0(file_name, "_processed.csv"))
  
  # Write the selected columns to a new CSV file
  write_csv(selected_columns, output_file_path)  # Adjust the appropriate write function
}



# Specify the source directory containing your dataframes
source_directory <- "/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/phonic-data/wave1"

# Specify the destination directory for the processed dataframes
destination_directory <- "processed-text"

# Create the destination directory if it doesn't exist
if (!dir.exists(destination_directory)) {
  dir.create(destination_directory)
}

# List all files in the source directory
file_list <- list.files(path = source_directory, full.names = TRUE)

# Iterate through each file and process it
for (file_path in file_list) {
  # Read the dataframe from the file
  df <- read_csv(file_path)  # Adjust the appropriate read function
  
  # Select the columns you want to keep
  selected_columns <- df %>%
    select(Date, `Session ID`, `User-Agent`, responseId, ends_with("Transcription"))
  
  # Extract the file name (without extension) to use as the new file name
  file_name <- tools::file_path_sans_ext(basename(file_path))
  
  # Define the output file path in the destination directory
  output_file_path <- file.path(destination_directory, paste0(file_name, "_processed.csv"))
  
  # Write the selected columns to a new CSV file
  write_csv(selected_columns, output_file_path)  # Adjust the appropriate write function
}
