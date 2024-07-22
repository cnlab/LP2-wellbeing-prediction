#Generate Word Embeddings with text 
setwd("/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/phonic-data/wave1") #use box sync to get the data, please try not to save locally 
if (!require("pacman")) install.packages("pacman") #run this if you don't have pacman 
library(pacman)
pacman::p_load(tidyverse,job, text,install = T) 
#devtools::install_github("oscarkjell/text")
# Set-up an environment with text-required python packages
textrpp_install()
textrpp_initialize()


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




#save them all as separate dataframes to get the embeddings 
Autonomy <- df_list$Lotic_Autonomy_processed
Relationships <- df_list$Lotic_Relationships_processed
Personal_Growth <- df_list$Lotic_Personal_Growth_processed
Purpose <- df_list$Lotic_Purpose_processed
Positive_Affect <- df_list$Lotic_Positive_Affect_processed
Self_Acceptance <- df_list$Lotic_Self_Acceptance_processed






#remove df_list from global environment 
rm(df_list)



#now begin to create the embeddings 

#check to see that bert-large-uncased is available locally. if not, you'll need to download it but that should happen automatically... 
#if you'd like to use another model you can check hugging face to see what's available 
textModels()

#Now we will run the embeddings as a background job

#load in all the data
textData <- read_csv("/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/phonic-data/wave1/Lotic_all_transcriptions.csv")
colnames(textData)



# Run them all at once 
job::job({
  all_embeddings <- textEmbed(textData[5:23], #embed the transcription questions 5 through 23
                                        model = "bert-large-uncased",#use bert-large-uncased
                                        layers = -2, #second to last layer, this is empirically driven... 
                                        aggregation_from_layers_to_tokens = "concatenate",
                                        aggregation_from_tokens_to_texts = "mean",
                                        aggregation_from_tokens_to_word_types = "mean",
                                        keep_token_embeddings = F)
  
  saveRDS(all_embeddings, "/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/embeddings/all_embeddings.rds")
  rm(all_embeddings) #remove the object from our working environment 
}
)


############################################################################################################################################################################################

# Individual embeddings 

############################################################################################################################################################################################



#Relationships

job::job({
  relationships_embeddings <- textEmbed(Relationships[5:7], #embed the transcription questions 
                                   model = "bert-large-uncased",#use bert-large-uncased
                                   layers = -2, #second to last layer, this is empirically driven... 
                                   aggregation_from_layers_to_tokens = "concatenate",
                                   aggregation_from_tokens_to_texts = "mean",
                                   aggregation_from_tokens_to_word_types = "mean",
                                   keep_token_embeddings = F)
  
 saveRDS(relationships_embeddings, "/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/embeddings/relationships_embeddings.rds")
 rm(relationships_embeddings) #remove the object from our working environment 
}
)



#Personal_Growth

job::job({
  personal_growth_embeddings <- textEmbed(Personal_Growth[5:7], #embed the transcription questions 
                                        model = "bert-large-uncased",#use bert-large-uncased
                                        layers = -2, #second to last layer, this is empirically driven... 
                                        aggregation_from_layers_to_tokens = "concatenate",
                                        aggregation_from_tokens_to_texts = "mean",
                                        aggregation_from_tokens_to_word_types = "mean",
                                        keep_token_embeddings = F)
  
  saveRDS(personal_growth_embeddings, "/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/embeddings/personal_growth_embeddings.rds")
  rm(personal_growth_embeddings) #remove the object from our working environment 
}
)

# Purpose
job::job({
  purpose_embeddings <- textEmbed(Purpose[5:7], #embed the transcription questions 
                                          model = "bert-large-uncased",#use bert-large-uncased
                                          layers = -2, #second to last layer, this is empirically driven... 
                                          aggregation_from_layers_to_tokens = "concatenate",
                                          aggregation_from_tokens_to_texts = "mean",
                                          aggregation_from_tokens_to_word_types = "mean",
                                          keep_token_embeddings = F)
  
  saveRDS(purpose_embeddings, "/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/embeddings/purpose_embeddings.rds")
  rm(purpose_embeddings) #remove the object from our working environment 
}
)

# Positive Affect
job::job({
  positive_affect_embeddings <- textEmbed(Positive_Affect[5:7], #embed the transcription questions 
                                  model = "bert-large-uncased",#use bert-large-uncased
                                  layers = -2, #second to last layer, this is empirically driven... 
                                  aggregation_from_layers_to_tokens = "concatenate",
                                  aggregation_from_tokens_to_texts = "mean",
                                  aggregation_from_tokens_to_word_types = "mean",
                                  keep_token_embeddings = F)
  
  saveRDS(positive_affect_embeddings, "/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/embeddings/positive_affect_embeddings.rds")
  rm(positive_affect_embeddings) #remove the object from our working environment 
}
)

# Self_Acceptance
job::job({
  self_acceptance_embeddings <- textEmbed(Self_Acceptance[5:7], #embed the transcription questions 
                                          model = "bert-large-uncased",#use bert-large-uncased
                                          layers = -2, #second to last layer, this is empirically driven... 
                                          aggregation_from_layers_to_tokens = "concatenate",
                                          aggregation_from_tokens_to_texts = "mean",
                                          aggregation_from_tokens_to_word_types = "mean",
                                          keep_token_embeddings = F)
  
  saveRDS(self_acceptance_embeddings, "/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/embeddings/self_acceptance_embeddings.rds")
  rm(self_acceptance_embeddings) #remove the object from our working environment 
}
)


# Autonomy
job::job({
  autonomy_embeddings <- textEmbed(Autonomy[5:8], #embed the transcription questions, autonomy has 4 prompts
                                          model = "bert-large-uncased",#use bert-large-uncased
                                          layers = -2, #second to last layer, this is empirically driven... 
                                          aggregation_from_layers_to_tokens = "concatenate",
                                          aggregation_from_tokens_to_texts = "mean",
                                          aggregation_from_tokens_to_word_types = "mean",
                                          keep_token_embeddings = F)
  
  saveRDS(autonomy_embeddings, "/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/embeddings/autonomy_embeddings.rds")
  rm(autonomy_embeddings) #remove the object from our working environment 
}
)

