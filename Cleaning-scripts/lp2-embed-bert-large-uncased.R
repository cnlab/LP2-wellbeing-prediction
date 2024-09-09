setwd("/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/phonic-data/wave1") #use box sync to get the data, please try not to save locally 
if (!require("pacman")) install.packages("pacman") #run this if you don't have pacman 
library(pacman)
pacman::p_load(tidyverse,job, text,install = T) 
# Set-up an environment with text-required python packages
textrpp_install()
textrpp_initialize()

#now begin to create the embeddings 

#check to see that bert-large-uncased is available locally. if not, you'll need to download it but that should happen automatically... 
#if you'd like to use another model you can check hugging face to see what's available 
textModels()

#Now we will run the embeddings as a background job

#load in all the data
textData <- read_csv("/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/surveys_scored/LP2_transcriptions_behavioral.csv")
colnames(textData)


######## Get embeddings for alll the data##################################################################################################################################################

# Run them all at once 
job::job({
  all_embeddings <- textEmbed(textData[21:39], #embed the transcription questions 5 through 23
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


