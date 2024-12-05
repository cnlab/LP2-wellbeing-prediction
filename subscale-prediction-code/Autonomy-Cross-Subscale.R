if (!require("pacman")) install.packages("pacman") #run this if you don't have pacman 
library(pacman)
pacman::p_load(tidyverse,job, text,install = T) 
# Set-up an environment with text-required python packages
textrpp_install()
textrpp_initialize()




#load embeddngs 

data_dir="/Users/sm9518/Library/CloudStorage/Box-Box/LP2/within_person_intervention"
df <- read_csv(file.path(data_dir,"/data_prediction/surveys_scored/LP2_transcriptions_behavioral.csv"))
embeddings <- readRDS(file.path(data_dir,"/data_prediction/embeddings/study_1/all_embeddings.rds"))


#######Subscale Prediction######################################################################################  

#Setworking directory to where we want the Subscale models ot live
setwd("/Users/sm9518/Library/CloudStorage/Dropbox/LP2-wellbeing-pred/LP2-wellbeing-prediction/Subscale-Models/autonomy")
##################Autonomy######################################################################################

####Autonomy Predicting Autonomy############################################################################### 
if (!file.exists("autonomy_autonomy_sub.RDS")) {
  autonomy_autonomy_sub <- textTrainRegression(
    x =embeddings$texts[1:3], # the three autonomy prompts
    y = df$pre_PWB_autonomy, #predicting autonomy 
    method_cor = "pearson",
    model_description = "Autonomy embeddings prediciting Autonomy Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(autonomy_autonomy_sub, "autonomy_autonomy_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  autonomy_autonomy_sub <- readRDS("autonomy_autonomy_sub.RDS")
}

####Autonomy Predicting Purpose############################################################################### 
if (!file.exists("autonomy_purpose_sub.RDS")) {
  autonomy_purpose_sub <- textTrainRegression(
    x =embeddings$texts[1:3], # the three autonomy prompts
    y = df$pre_PWB_purpose, #predicting autonomy 
    method_cor = "pearson",
    model_description = "Autonomy embeddings prediciting Purpose Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(autonomy_purpose_sub, "autonomy_purpose_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  autonomy_purpose_sub <- readRDS("autonomy_purpose_sub.RDS")
}
                                                                                                                                                                   
####Autonomy Predicting Relationships###############################################################################
if (!file.exists("autonomy_relationships_sub.RDS")) {
  autonomy_relationships_sub <- textTrainRegression(
    x =embeddings$texts[1:3], # the three autonomy prompts
    y = df$pre_PWB_positive_relations, #predicting autonomy 
    method_cor = "pearson",
    model_description = "Autonomy embeddings prediciting Relationships Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(autonomy_relationships_sub, "autonomy_relationships_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  autonomy_relationships_sub <- readRDS("autonomy_relationships_sub.RDS")
}


####Autonomy Predicting Self-Acceptance############################################################################### 
if (!file.exists("autonomy_acceptance_sub.RDS")) {
  autonomy_acceptance_sub <- textTrainRegression(
    x =embeddings$texts[1:3], # the three autonomy prompts
    y = df$pre_PWB_positive_relations, #predicting autonomy 
    method_cor = "pearson",
    model_description = "Autonomy embeddings prediciting Self-Acceptance Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(autonomy_acceptance_sub, "autonomy_acceptance_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  autonomy_acceptance_sub <- readRDS("autonomy_acceptance_sub.RDS")
}

####Autonomy Personal Growth############################################################################### 
if (!file.exists("autonomy_growth_sub.RDS")) {
  autonomy_growth_sub <- textTrainRegression(
    x =embeddings$texts[1:3], # the three autonomy prompts
    y = df$pre_PWB_positive_relations, #predicting autonomy 
    method_cor = "pearson",
    model_description = "Autonomy embeddings prediciting Personal Growth Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(autonomy_growth_sub, "autonomy_growth_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  autonomy_growth_sub <- readRDS("autonomy_growth_sub.RDS")
}

####Autonomy PWB############################################################################### 
if (!file.exists("autonomy_PWB_sub.RDS")) {
  autonomy_PWB_sub <- textTrainRegression(
    x =embeddings$texts[1:3], # the three autonomy prompts
    y = df$pre_PWB_mean, #predicting autonomy 
    method_cor = "pearson",
    model_description = "Autonomy embeddings prediciting PWB Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(autonomy_PWB_sub, "autonomy_PWB_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  autonomy_PWB_sub.RDS <- readRDS("autonomy_PWB_sub.RDS")
}

####Autonomy SWLS############################################################################### 
if (!file.exists("autonomy_SWLS_sub.RDS")) {
  autonomy_SWLS_sub <- textTrainRegression(
    x =embeddings$texts[1:3], # the three autonomy prompts
    y = df$pre_SWLS_mean, #predicting autonomy 
    method_cor = "pearson",
    model_description = "Autonomy embeddings prediciting SWLS Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(autonomy_SWLS_sub, "autonomy_SWLS_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  autonomy_SWLS_sub <- readRDS("autonomy_SWLS_sub.RDS")
}


####Autonomy mastery############################################################################### 
if (!file.exists("autonomy_mastery_sub.RDS")) {
  autonomy_mastery_sub <- textTrainRegression(
    x =embeddings$texts[1:3], # the three autonomy prompts
    y = df$pre_PWB_environmental_mastery, #predicting autonomy 
    method_cor = "pearson",
    model_description = "Autonomy embeddings prediciting mastery Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(autonomy_mastery_sub, "autonomy_mastery_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  autonomy_mastery_sub <- readRDS("autonomy_mastery_sub.RDS")
}
