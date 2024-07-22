####Generating Prolific Word Embeddings 

setwd("/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data_text/embeddings/wellbeing-prediction") #use box sync to get the data, please try not to save locally 
if (!require("pacman")) install.packages("pacman") #run this if you don't have pacman 
library(pacman)
pacman::p_load(tidyverse,job, text,install = T) 
#devtools::install_github("oscarkjell/text")
# Set-up an environment with text-required python packages
textrpp_install()
textrpp_initialize()


###Load in the data 
textData <- read_csv("/Users/stevenmesquiti/Downloads/Prolific_wellbeing-prediction-text-long.csv")

text = textData %>% 
  select(pID, `Autonomy-Text`,`SWLS-Text`)



######## Get embeddings for alll the data##################################################################################################################################################

# Run them all at once 
job::job({
  all_embeddings <- textEmbed(text[2:3], #embed the transcription questions 5 through 23
                              model = "bert-large-uncased",#use bert-large-uncased
                              layers = -2, #second to last layer, this is empirically driven... 
                              aggregation_from_layers_to_tokens = "concatenate",
                              aggregation_from_tokens_to_texts = "mean",
                              aggregation_from_tokens_to_word_types = "mean",
                              keep_token_embeddings = F)
  saveRDS(all_embeddings, "/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/well-being-prediction/embeddings/Study3-WBP-embeddings.rds")
  rm(all_embeddings)
}
)

rm(all_embeddings) #remove the object from our working environment 