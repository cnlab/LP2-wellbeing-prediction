if (!require("pacman")) install.packages("pacman") #run this if you don't have pacman 
library(pacman)
pacman::p_load(tidyverse,job, text,install = T) 
# Set-up an environment with text-required python packages
textrpp_install()
textrpp_initialize()


#load embeddngs 
embeddings <- read_rds("/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/embeddings/all_embeddings.rds")
df <- read_csv("/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/surveys_scored/LP2_transcriptions_behavioral.csv")

#######Subscale Prediction######################################################################################  



#Setworking directory to where we want the Subscale models ot live
setwd("/Users/stevenmesquiti/Desktop/LP2-within/LP2-intervention-within/Text-Prediction/Subscale-Models/acceptance")
##################purposehips######################################################################################



####Pos Affect Predicting Autonomy############################################################################### 
if (!file.exists("accept_autonomy_sub.RDS")) {
  accept_autonomy_sub <- textTrainRegression(
    x = embeddings$texts[16:18], # the three accept prompts
    y = df$pre_PWB_autonomy, #predicting autonomy 
    method_cor = "pearson",
    model_description = "accept embeddings prediciting Autonomy Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(accept_autonomy_sub, "accept_autonomy_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  accept_autonomy_sub <- readRDS("accept_autonomy_sub.RDS")
}

####accept Predicting accept############################################################################### 
if (!file.exists("accept_purpose_sub.RDS")) {
  accept_purpose_sub <- textTrainRegression(
    x = embeddings$texts[16:18], # the three accept prompts
    y = df$pre_PWB_purpose, #predicting accept 
    method_cor = "pearson",
    model_description = "accept embeddings prediciting accept Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(accept_purpose_sub, "accept_purpose_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  accept_purpose_sub <- readRDS("accept_purpose_sub.RDS")
}

####accept Predicting Relationships###############################################################################
if (!file.exists("accept_relationships_sub.RDS")) {
  accept_relationships_sub <- textTrainRegression(
    x = embeddings$texts[16:18], # the three accept prompts
    y = df$pre_PWB_positive_relations, #predicting accept 
    method_cor = "pearson",
    model_description = "accept embeddings prediciting Relationships Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(accept_relationships_sub, "accept_relationships_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  accept_relationships_sub <- readRDS("accept_relationships_sub.RDS")
}


####accept Predicting Self-Acceptance############################################################################### 
if (!file.exists("accept_acceptance_sub.RDS")) {
  accept_acceptance_sub <- textTrainRegression(
    x = embeddings$texts[16:18], # the three accept prompts
    y = df$pre_PWB_positive_relations, #predicting accept 
    method_cor = "pearson",
    model_description = "accept embeddings prediciting Self-Acceptance Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(accept_acceptance_sub, "accept_acceptance_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  accept_acceptance_sub <- readRDS("accept_acceptance_sub.RDS")
}

####accept Personal Growth############################################################################### 
if (!file.exists("accept_growth_sub.RDS")) {
  accept_growth_sub <- textTrainRegression(
    x = embeddings$texts[16:18], # the three accept prompts
    y = df$pre_PWB_positive_relations, #predicting positive accept 
    method_cor = "pearson",
    model_description = "accept embeddings prediciting Personal Growth Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(accept_growth_sub.RDS, "accept_growth_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  accept_growth_sub.RDS <- readRDS("accept_growth_sub.RDS")
}

####accept PWB############################################################################### 

if (!file.exists("accept_PWB_sub.RDS")) {
  accept_PWB_sub.RDS <- textTrainRegression(
    x = embeddings$texts[16:18], # the three accept prompts
    y = df$pre_PWB_mean, #predicting accept 
    method_cor = "pearson",
    model_description = "accept embeddings prediciting PWB Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(accept_PWB_sub, "accept_PWB_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  accept_PWB_sub <- readRDS("accept_PWB_sub.RDS")
}


####accept SWLS############################################################################### 


if (!file.exists("accept_SWLS_sub.RDS")) {
  accept_PWB_sub <- textTrainRegression(
    x = embeddings$texts[16:18], # the three accept prompts
    y = df$pre_SWLS_mean, #predicting accept 
    method_cor = "pearson",
    model_description = "accept embeddings prediciting SWLS Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(accept_PWB_sub, "accept_SWLS_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  accept_PWB_sub <- readRDS("accept_SWLS_sub.RDS")
}

