if (!require("pacman")) install.packages("pacman") #run this if you don't have pacman 
library(pacman)
pacman::p_load(tidyverse,job, text,install = T) 

#install.packages("devtools")
devtools::install_version("text", version = "1.2.1", repos = "http://cran.us.r-project.org")

#### as of 8/29 need to exclusively use version 1.2.1 to get around a fatal R issue

library(text)
textrpp_install(prompt = F)
textrpp_initialize()


data_dir="/Users/sm9518/Library/CloudStorage/Box-Box/LP2/within_person_intervention"
df = read.csv(file.path(data_dir,"/data_prediction/phonic-data/wave1/LP2_transcriptions_behavioral.csv"))


textModels()

### only keeping people where we have post data 

df <- df %>%
  filter(rowSums(is.na(select(., starts_with("post")))) == 0)


### create embeddings with the post data 

# Run them all at once 
job::job({
  post_embeddings <- textEmbed(df[21:39], #embed the transcription questions 5 through 23
                              model = "bert-large-uncased",#use bert-large-uncased
                              layers = -2, #second to last layer, this is empirically driven... 
                              aggregation_from_layers_to_tokens = "concatenate",
                              aggregation_from_tokens_to_texts = "mean",
                              aggregation_from_tokens_to_word_types = "mean",
                              keep_token_embeddings = F)
  
  saveRDS(post_embeddings,"/Users/sm9518/Library/CloudStorage/Box-Box/LP2/well-being-prediction/embeddings/Study1_post__embeddings.rds")
  rm(post_embeddings) #remove the object from our working environment 
}
)

### post score prediction using embeddings

post_model <- textTrainLists(
  x = post_embeddings$texts[1:18], # embeddings
  y = df[3:10], # using post scores
  force_train_method = "regression",
  save_output = "all",
  method_cor = "pearson",
  eval_measure = "rmse",
  p_adjust_method = "fdr",
  model_description = "embeddings to ~ post Wb scores; N = 181"
)

saveRDS(post_model,"/Users/sm9518/Library/CloudStorage/Box-Box/LP2/well-being-prediction/models/Study1_post_model.rds")

post_model$results

