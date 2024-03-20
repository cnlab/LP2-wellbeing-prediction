if (!require("pacman")) install.packages("pacman") #run this if you don't have pacman 
library(pacman)
pacman::p_load(tidyverse,job, text,install = T) 
# Set-up an environment with text-required python packages
textrpp_install(prompt = FALSE)
textrpp_initialize()


#load embeddngs 
embeddings <- read_rds("/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/embeddings/Content_word_embeddings.rds")
df <- read_csv("/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/surveys_scored/LP2_transcriptions_behavioral.csv")

#######Subscale Prediction######################################################################################  

#Setworking directory to where we want the Subscale models ot live
setwd("/Users/stevenmesquiti/Desktop/LP2-within/LP2-intervention-within/Text-Prediction/Content-word-analysis/subscale-models/models/growth")
##################Personal Growth######################################################################################

####Growth Predicting Autonomy############################################################################### 
if (!file.exists("growth_autonomy_content_sub.RDS")) {
  growth_autonomy_sub <- textTrainRegression(
    x = embeddings$texts[4:6], # the three growth prompts
    y = df$pre_PWB_autonomy, #predicting autonomy 
    method_cor = "pearson",
    model_description = "Growth embeddings prediciting Autonomy Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(growth_autonomy_sub, "growth_autonomy_content_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  growth_autonomy_sub <- readRDS("growth_autonomy_content_sub.RDS")
}

####growth Predicting Purpose############################################################################### 
if (!file.exists("growth_purpose_content_sub.RDS")) {
  growth_purpose_sub <- textTrainRegression(
    x = embeddings$texts[4:6], # the three growth prompts
    y = df$pre_PWB_purpose, #predicting growth 
    method_cor = "pearson",
    model_description = "growth embeddings prediciting Purpose Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(growth_purpose_sub, "growth_purpose_content_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  growth_purpose_sub <- readRDS("growth_purpose_content_sub.RDS")
}

####growth Predicting Relationships###############################################################################
if (!file.exists("growth_relationships_content_sub.RDS")) {
  growth_relationships_sub <- textTrainRegression(
    x = embeddings$texts[4:6], # the three growth prompts
    y = df$pre_PWB_positive_relations, #predicting growth 
    method_cor = "pearson",
    model_description = "growth embeddings prediciting Relationships Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(growth_relationships_sub, "growth_relationships_content_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  growth_relationships_sub <- readRDS("growth_relationships_content_sub.RDS")
}


####growth Predicting Self-Acceptance############################################################################### 
if (!file.exists("growth_acceptance_content_sub.RDS")) {
  growth_acceptance_sub <- textTrainRegression(
    x = embeddings$texts[4:6], # the three growth prompts
    y = df$pre_PWB_self_acceptance, #predicting growth 
    method_cor = "pearson",
    model_description = "growth embeddings prediciting Self-Acceptance Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(growth_acceptance_sub, "growth_acceptance_content_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  growth_acceptance_sub <- readRDS("growth_acceptance_content_sub.RDS")
}

####growth Personal Growth############################################################################### 
if (!file.exists("growth_growth_content_sub.RDS")) {
  growth_growth_sub <- textTrainRegression(
    x = embeddings$texts[4:6], # the three growth prompts
    y = df$pre_PWB_personal_growth, #predicting positive relations 
    method_cor = "pearson",
    model_description = "growth embeddings prediciting Personal Growth Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(growth_growth_sub, "growth_growth_content_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  growth_growth_sub <- readRDS("growth_growth_content_sub.RDS")
}

####growth PWB############################################################################### 
if (!file.exists("growth_PWB_content_sub.RDS")) {
  growth_PWB_sub <- textTrainRegression(
    x = embeddings$texts[4:6], # the three growth prompts
    y = df$pre_PWB_mean, #predicting growth 
    method_cor = "pearson",
    model_description = "growth embeddings prediciting PWB Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(growth_PWB_sub, "growth_PWB_content_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  growth_PWB_sub.RDS <- readRDS("growth_PWB_content_sub.RDS")
}

####growth SWLS############################################################################### 
if (!file.exists("growth_SWLS_content_sub.RDS")) {
  growth_SWLS_sub <- textTrainRegression(
    x = embeddings$texts[4:6], # the three growth prompts
    y = df$pre_SWLS_mean, #predicting growth 
    method_cor = "pearson",
    model_description = "growth embeddings prediciting SWLS Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(growth_SWLS_sub, "growth_SWLS_content_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  growth_SWLS_sub <- readRDS("growth_SWLS_content_sub.RDS")
}
