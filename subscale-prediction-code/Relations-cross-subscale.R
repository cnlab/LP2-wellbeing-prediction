if (!require("pacman")) install.packages("pacman") #run this if you don't have pacman 
library(pacman)
pacman::p_load(tidyverse,job, text,install = T) 

#install.packages("devtools")
#devtools::install_version("text", version = "1.2.1", repos = "http://cran.us.r-project.org")

#### as of 8/29 need to exclusively use version 1.2.1 to get around a fatal R issue

library(text)
textrpp_install(prompt = F)
textrpp_initialize()


data_dir="/Users/sm9518/Library/CloudStorage/Box-Box/LP2/within_person_intervention"
df = read.csv(file.path(data_dir,"/data_prediction/phonic-data/wave1/LP2_transcriptions_behavioral.csv"))

### keep only people with post data 
df <- df %>%
  filter(rowSums(is.na(select(., starts_with("post")))) == 0)

### load the post embeddings 
embeddings <- read_rds("/Users/sm9518/Library/CloudStorage/Box-Box/LP2/well-being-prediction/embeddings/Study1_post__embeddings.rds")

#######Subscale Prediction######################################################################################  


model_dir = "/Users/sm9518/Library/CloudStorage/Dropbox/LP2-wellbeing-pred/LP2-wellbeing-prediction/subscale-models-post/relations"
##################purposehips######################################################################################

rds_file_path <- file.path(model_dir, "relations_autonomy_sub.RDS") #update with the path to each model

####Pos Affect Predicting Autonomy############################################################################### 
if (!file.exists(rds_file_path)) {
  relations_autonomy_sub <- textTrainRegression(
    x = embeddings$texts[13:15], # the three relations prompts
    y = df$post_PWB_autonomy, #predicting autonomy 
    method_cor = "pearson",
    model_description = "relations embeddings prediciting Autonomy Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(relations_autonomy_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  relations_autonomy_sub <- readRDS(rds_file_path)
}

####relations Predicting Purpose############################################################################### 

rds_file_path <- file.path(model_dir, "relations_purpose_sub.RDS") #update with the path to each model


if (!file.exists(rds_file_path)) {
  relations_purpose_sub <- textTrainRegression(
    x = embeddings$texts[13:15], # the three relations prompts
    y = df$post_PWB_purpose, #predicting relations 
    method_cor = "pearson",
    model_description = "relations embeddings prediciting Purpose Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(relations_purpose_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  relations_purpose_sub <- readRDS(rds_file_path)
}

####relations Predicting Relationships###############################################################################
rds_file_path <- file.path(model_dir, "relations_relationships_sub.RDS") #update with the path to each model


if (!file.exists(rds_file_path)) {
  relations_relationships_sub <- textTrainRegression(
    x = embeddings$texts[13:15], # the three relations prompts
    y = df$post_PWB_positive_relations, #predicting relations 
    method_cor = "pearson",
    model_description = "relations embeddings prediciting Relationships Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(relations_relationships_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  relations_relationships_sub <- readRDS(rds_file_path)
}


####relations Predicting Self-Acceptance############################################################################### 
rds_file_path <- file.path(model_dir, "relations_acceptance_sub.RDS") #update with the path to each model

if (!file.exists(rds_file_path)) {
  relations_acceptance_sub <- textTrainRegression(
    x = embeddings$texts[13:15], # the three relations prompts
    y = df$post_PWB_positive_relations, #predicting relations 
    method_cor = "pearson",
    model_description = "relations embeddings prediciting Self-Acceptance Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(relations_acceptance_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  relations_acceptance_sub <- readRDS(rds_file_path)
}

####relations Personal Growth############################################################################### 

rds_file_path <- file.path(model_dir, "relations_growth_sub.RDS") #update with the path to each model
if (!file.exists(rds_file_path)) {
  relations_growth_sub <- textTrainRegression(
    x = embeddings$texts[13:15], # the three relations prompts
    y = df$post_PWB_positive_relations, #predicting positive relations 
    method_cor = "pearson",
    model_description = "relations embeddings prediciting Personal Growth Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(relations_growth_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  relations_growth_sub <- readRDS(rds_file_path)
}

####relations PWB############################################################################### 
rds_file_path <- file.path(model_dir, "relations_PWB_sub.RDS") #update with the path to each model

  if (!file.exists(rds_file_path)) {
    relations_PWB_sub <- textTrainRegression(
      x = embeddings$texts[13:15], # the three relations prompts
      y = df$post_PWB_mean, #predicting relations 
      method_cor = "pearson",
      model_description = "relations embeddings prediciting PWB Subscale Ratings",
      multi_cores = T,
      save_output = "all",)
    
    # Save the model output to an RDS file
    saveRDS(relations_PWB_sub, rds_file_path)
  } else {
    # If the RDS file already exists, load the data from it
    relations_PWB_sub.RDS <- readRDS(rds_file_path)
  }
  

####relations SWLS############################################################################### 
rds_file_path <- file.path(model_dir, "relations_SWLS_sub.RDS") #update with the path to each model


  if (!file.exists(rds_file_path)) {
    relations_SWLS_sub <- textTrainRegression(
      x = embeddings$texts[13:15], # the three relations prompts
      y = df$post_SWLS_mean, #predicting relations 
      method_cor = "pearson",
      model_description = "relations embeddings prediciting SWLS Subscale Ratings",
      multi_cores = T,
      save_output = "all",)
    
    # Save the model output to an RDS file
    saveRDS(relations_SWLS_sub, rds_file_path)
  } else {
    # If the RDS file already exists, load the data from it
    relations_SWLS_sub <- readRDS(rds_file_path)
  }

####relations mastery###############################################################################


data_dir="/Users/sm9518/Library/CloudStorage/Box-Box/LP2/within_person_intervention"
df <- read_csv(file.path(data_dir,"/data_prediction/surveys_scored/LP2_transcriptions_behavioral.csv"))
embeddings <- readRDS(file.path(data_dir,"/data_prediction/embeddings/study_1/all_embeddings.rds"))

#######Subscale Prediction######################################################################################  

#Setworking directory to where we want the Subscale models ot live
setwd("/Users/sm9518/Library/CloudStorage/Dropbox/LP2-wellbeing-pred/LP2-wellbeing-prediction/Subscale-Models/relations")

if (!file.exists("relations_mastery_sub.RDS")) {
  relations_mastery_sub <- textTrainRegression(
    x = embeddings$texts[13:15], # the three accept prompts
    y = df$pre_PWB_environmental_mastery, #predicting autonomy 
    method_cor = "pearson",
    model_description = "accept embeddings prediciting mastery Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(relations_mastery_sub, "relations_mastery_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  relations_mastery_sub <- readRDS("relations_mastery_sub.RDS")
}

