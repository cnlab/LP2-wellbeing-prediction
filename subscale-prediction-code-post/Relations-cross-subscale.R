if (!require("pacman")) install.packages("pacman") #run this if you don't have pacman 
library(pacman)
pacman::p_load(tidyverse,job, text,install = T) 
# Set-up an environment with text-required python packages
textrpp_install()
textrpp_initialize()


#load embeddngs 
data_dir="/Users/sm9518/Library/CloudStorage/Box-Box/LP2/within_person_intervention"
df <- read_csv(file.path(data_dir,"/data_prediction/surveys_scored/LP2_transcriptions_behavioral.csv"))

### keep only people with post data 
df <- df %>%
  filter(rowSums(is.na(select(., starts_with("post")))) == 0)


embeddings <- read_rds("/Users/sm9518/Library/CloudStorage/Box-Box/LP2/well-being-prediction/embeddings/Study1_post__embeddings.rds")


##Subscale Prediction######################################################################################  

#Setworking directory to where we want the Subscale models ot live
setwd("/Users/sm9518/Library/CloudStorage/Dropbox/LP2-wellbeing-pred/LP2-wellbeing-prediction/subscale-models-post/relations")
##################relationships######################################################################################


job::job({

####Pos Affect Predicting Autonomy############################################################################### 
if (!file.exists("relations_autonomy_sub.RDS")) {
  relations_autonomy_sub <- textTrainRegression(
    x = embeddings$texts[13:15], # the three relations prompts
    y = df$pre_PWB_autonomy, #predicting autonomy 
    method_cor = "pearson",
    model_description = "relations embeddings prediciting Autonomy Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(relations_autonomy_sub, "relations_autonomy_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  relations_autonomy_sub <- readRDS("relations_autonomy_sub.RDS")
}

####relations Predicting Purpose############################################################################### 
if (!file.exists("relations_purpose_sub.RDS")) {
  relations_purpose_sub <- textTrainRegression(
    x = embeddings$texts[13:15], # the three relations prompts
    y = df$pre_PWB_purpose, #predicting relations 
    method_cor = "pearson",
    model_description = "relations embeddings prediciting Purpose Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(relations_purpose_sub, "relations_purpose_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  relations_purpose_sub <- readRDS("relations_purpose_sub.RDS")
}

####relations Predicting Relationships###############################################################################
if (!file.exists("relations_relationships_sub.RDS")) {
  relations_relationships_sub <- textTrainRegression(
    x = embeddings$texts[13:15], # the three relations prompts
    y = df$pre_PWB_positive_relations, #predicting relations 
    method_cor = "pearson",
    model_description = "relations embeddings prediciting Relationships Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(relations_relationships_sub, "relations_relationships_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  relations_relationships_sub <- readRDS("relations_relationships_sub.RDS")
}


####relations Predicting Self-Acceptance############################################################################### 
if (!file.exists("relations_acceptance_sub.RDS")) {
  relations_acceptance_sub <- textTrainRegression(
    x = embeddings$texts[13:15], # the three relations prompts
    y = df$pre_PWB_positive_relations, #predicting relations 
    method_cor = "pearson",
    model_description = "relations embeddings prediciting Self-Acceptance Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(relations_acceptance_sub, "relations_acceptance_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  relations_acceptance_sub <- readRDS("relations_acceptance_sub.RDS")
}

####relations Personal Growth############################################################################### 
if (!file.exists("relations_growth_sub.RDS")) {
  relations_growth_sub <- textTrainRegression(
    x = embeddings$texts[13:15], # the three relations prompts
    y = df$pre_PWB_positive_relations, #predicting positive relations 
    method_cor = "pearson",
    model_description = "relations embeddings prediciting Personal Growth Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(relations_growth_sub, "relations_growth_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  relations_growth_sub <- readRDS("relations_growth_sub.RDS")
}

####relations PWB############################################################################### 
  
  if (!file.exists("relations_PWB_sub.RDS")) {
    relations_PWB_sub <- textTrainRegression(
      x = embeddings$texts[13:15], # the three relations prompts
      y = df$pre_PWB_mean, #predicting relations 
      method_cor = "pearson",
      model_description = "relations embeddings prediciting PWB Subscale Ratings",
      multi_cores = F,
      save_output = "all",)
    
    # Save the model output to an RDS file
    saveRDS(relations_PWB_sub, "relations_PWB_sub.RDS")
  } else {
    # If the RDS file already exists, load the data from it
    relations_PWB_sub.RDS <- readRDS("relations_PWB_sub.RDS")
  }
  

####relations SWLS############################################################################### 


  if (!file.exists("relations_SWLS_sub.RDS")) {
    relations_SWLS_sub <- textTrainRegression(
      x = embeddings$texts[13:15], # the three relations prompts
      y = df$pre_SWLS_mean, #predicting relations 
      method_cor = "pearson",
      model_description = "relations embeddings prediciting SWLS Subscale Ratings",
      multi_cores = F,
      save_output = "all",)
    
    # Save the model output to an RDS file
    saveRDS(relations_SWLS_sub, "relations_SWLS_sub.RDS")
  } else {
    # If the RDS file already exists, load the data from it
    relations_SWLS_sub <- readRDS("relations_SWLS_sub.RDS")
  }
})



setwd("/Users/sm9518/Library/CloudStorage/Dropbox/LP2-wellbeing-pred/LP2-wellbeing-prediction/subscale-models-post/relations")
###mastery 
if (!file.exists("relations_mastery_sub.RDS")) {
  relations_mastery_sub <- textTrainRegression(
    x = embeddings$texts[13:15], # the three relations prompts
    y = df$post_PWB_environmental_mastery, #predicting relations 
    method_cor = "pearson",
    model_description = "relations embeddings prediciting Mastery Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(relations_mastery_sub, "relations_mastery_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  relations_mastery_sub <- readRDS("relations_mastery_sub.RDS")
}


