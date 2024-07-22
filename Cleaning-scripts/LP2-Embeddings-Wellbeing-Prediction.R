setwd("/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data_text/embeddings/wellbeing-prediction") #use box sync to get the data, please try not to save locally 
if (!require("pacman")) install.packages("pacman") #run this if you don't have pacman 
library(pacman)
pacman::p_load(tidyverse,job, text,install = T) 
#devtools::install_github("oscarkjell/text")
# Set-up an environment with text-required python packages
textrpp_install()
textrpp_initialize()


###Load in the data 
textData <- read_csv("/Users/stevenmesquiti/Downloads/wellbeing-prediction-text-long.csv")
colnames(textData)

###prep the text data 

text = textData %>% 
  select(pID,prompt,text) 

text_grouped <- text %>%
  group_by(pID, prompt) %>%
  summarize(
    text_combined = paste(text, collapse = " "),
    .groups = "drop"  # To avoid keeping group structure
  )

# Reshape data from long to wide format
text_embed <- text_grouped %>%
  spread(key = prompt, value = text_combined)


######## Get embeddings for alll the data##################################################################################################################################################

# Run them all at once 
job::job({
  all_embeddings <- textEmbed(text_embed[2:3], #embed the transcription questions 5 through 23
                              model = "bert-large-uncased",#use bert-large-uncased
                              layers = -2, #second to last layer, this is empirically driven... 
                              aggregation_from_layers_to_tokens = "concatenate",
                              aggregation_from_tokens_to_texts = "mean",
                              aggregation_from_tokens_to_word_types = "mean",
                              keep_token_embeddings = F)
  
  saveRDS(all_embeddings, "/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data_text/embeddings/wellbeing-prediction/wellbeing-prediction-embeddings.rds")
  rm(all_embeddings) #remove the object from our working environment 
}
)


###### Text ONLY responses ########################################################################################################################

textData <- read_csv("/Users/stevenmesquiti/Downloads/wellbeing-prediction-text-long.csv")
colnames(textData)

###prep the text data 

text = textData %>% 
  select(pID,prompt,text,type) %>% 
  filter(type == "Text") %>% 
  select(-type)

text_grouped <- text %>%
  group_by(pID, prompt) %>%
  summarize(
    text_combined = paste(text, collapse = " "),
    .groups = "drop"  # To avoid keeping group structure
  )

# Reshape data from long to wide format
text_embed_text_only <- text_grouped %>%
  spread(key = prompt, value = text_combined)


###embedding 89 responses


job::job({
  all_embeddings <- textEmbed(text_embed_text_only[2:3], #embed the transcription questions 5 through 23
                              model = "bert-large-uncased",#use bert-large-uncased
                              layers = -2, #second to last layer, this is empirically driven... 
                              aggregation_from_layers_to_tokens = "concatenate",
                              aggregation_from_tokens_to_texts = "mean",
                              aggregation_from_tokens_to_word_types = "mean",
                              keep_token_embeddings = F)
  
  saveRDS(all_embeddings, "/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data_text/embeddings/wellbeing-prediction/Text_Only_wellbeing-prediction-embeddings.rds")
  rm(all_embeddings) #remove the object from our working environment 
}
)


######audio only 
text = textData %>% 
  select(pID,prompt,text,type) %>% 
  filter(type == "Audio") %>% 
  select(-type)

text_grouped <- text %>%
  group_by(pID, prompt) %>%
  summarize(
    text_combined = paste(text, collapse = " "),
    .groups = "drop"  # To avoid keeping group structure
  )

# Reshape data from long to wide format
text_embed_audio_only <- text_grouped %>%
  spread(key = prompt, value = text_combined)

###embedding 89 responses

job::job({
  all_embeddings <- textEmbed(text_embed_audio_only[2:3], #embed the transcription questions 5 through 23
                              model = "bert-large-uncased",#use bert-large-uncased
                              layers = -2, #second to last layer, this is empirically driven... 
                              aggregation_from_layers_to_tokens = "concatenate",
                              aggregation_from_tokens_to_texts = "mean",
                              aggregation_from_tokens_to_word_types = "mean",
                              keep_token_embeddings = F)
  
  saveRDS(all_embeddings, "/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data_text/embeddings/wellbeing-prediction/Audio_Only_wellbeing-prediction-embeddings.rds")
  rm(all_embeddings) #remove the object from our working environment 
}
)

