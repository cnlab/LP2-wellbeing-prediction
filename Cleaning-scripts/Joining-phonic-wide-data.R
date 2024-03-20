
setwd("/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/phonic-data/wave1") #use box sync to get the data, please try not to save locally 
if (!require("pacman")) install.packages("pacman") #run this if you don't have pacman 
library(pacman)
pacman::p_load(tidyverse, install = T) 



#read in all the CSVS with the processed data 
directory <- "/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/phonic-data/wave1/processed-text"
# List all CSV files in the directory
csv_files <- list.files(directory, pattern = "*.csv")

# Create a list to store the data frames
df_list <- list()

# Read each CSV file into a separate data frame and store them in the list
for (file in csv_files) {
  # Construct the full file path
  file_path <- file.path(directory, file)
  
  # Read the CSV file into a data frame and assign it a name
  df <- read.csv(file_path)
  
  # Extract the name of the data frame from the file name (excluding the ".csv" extension)
  df_name <- sub(".csv$", "", file)
  
  # Assign the data frame to a list with the same name
  df_list[[df_name]] <- df
}



# Assuming df_list is a list of data frames
# Find the number of rows in each data frame
row_counts <- sapply(df_list, nrow)

# Identify the minimum number of rows among the data frames
min_rows <- min(row_counts)

# Trim the data frames to have the same number of rows
df_list <- lapply(df_list, function(df) df[1:min_rows, ])

# Now you can safely use bind_cols
combined_df <- bind_cols(df_list)


columns_to_keep <- c("Date...1", "Session.ID...2", "User.Agent...3", "responseId...4", grep("Transcription$", colnames(combined_df), value = TRUE))

# Subset the data frame to keep only the selected columns
subset_combined_df <- combined_df[, columns_to_keep]

subset_combined_df <- subset_combined_df %>%
  rename(
    Date = "Date...1",
    Session.ID = "Session.ID...2",
    User.Agent = "User.Agent...3",
    responseId = "responseId...4"
  )

View(subset_combined_df)

#write.csv(subset_combined_df, "/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/phonic-data/wave1/Lotic_all_transcriptions.csv")



