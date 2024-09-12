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


model_dir = "/Users/sm9518/Library/CloudStorage/Dropbox/LP2-wellbeing-pred/LP2-wellbeing-prediction/subscale-models-post/purpose"
##################purposehips######################################################################################


  
####Pos Affect Predicting Autonomy############################################################################### 

rds_file_path <- file.path(model_dir, "purpose_autonomy_sub.RDS") #update with the path to each model


  if (!file.exists(rds_file_path)) {
    purpose_autonomy_sub <- textTrainRegression(
      x = embeddings$texts[10:12], # the three purpose prompts
      y = df$post_PWB_autonomy, #predicting autonomy 
      method_cor = "pearson",
      model_description = "purpose embeddings prediciting Autonomy Subscale Ratings",
      multi_cores = T,
      save_output = "all",)
    
    # Save the model output to an RDS file
    saveRDS(purpose_autonomy_sub, rds_file_path)
  } else {
    # If the RDS file already exists, load the data from it
    purpose_autonomy_sub <- readRDS(rds_file_path)
  }
  
####purpose Predicting Purpose############################################################################### 
rds_file_path <- file.path(model_dir, "purpose_purpose_sub.RDS") #update with the path to each model


  if (!file.exists(rds_file_path)) {
    purpose_purpose_sub <- textTrainRegression(
      x = embeddings$texts[10:12], # the three purpose prompts
      y = df$post_PWB_purpose, #predicting purpose 
      method_cor = "pearson",
      model_description = "purpose embeddings prediciting Purpose Subscale Ratings",
      multi_cores = T,
      save_output = "all",)
    
    # Save the model output to an RDS file
    saveRDS(purpose_purpose_sub, rds_file_path)
  } else {
    # If the RDS file already exists, load the data from it
    purpose_purpose_sub <- readRDS(rds_file_path)
  }
  
  ####purpose Predicting Relationships###############################################################################

rds_file_path <- file.path(model_dir, "purpose_relationships_sub.RDS") #update with the path to each model

  if (!file.exists(rds_file_path)) {
    purpose_relationships_sub <- textTrainRegression(
      x = embeddings$texts[10:12], # the three purpose prompts
      y = df$post_PWB_positive_relations, #predicting purpose 
      method_cor = "pearson",
      model_description = "purpose embeddings prediciting Relationships Subscale Ratings",
      multi_cores = T,
      save_output = "all",)
    
    # Save the model output to an RDS file
    saveRDS(purpose_relationships_sub, rds_file_path)
  } else {
    # If the RDS file already exists, load the data from it
    purpose_relationships_sub <- readRDS(rds_file_path)
  }
  
  
  ####purpose Predicting Self-Acceptance############################################################################### 

rds_file_path <- file.path(model_dir, "purpose_acceptance_sub.RDS") #update with the path to each model


  if (!file.exists(rds_file_path)) {
    purpose_acceptance_sub <- textTrainRegression(
      x = embeddings$texts[10:12], # the three purpose prompts
      y = df$post_PWB_positive_relations, #predicting purpose 
      method_cor = "pearson",
      model_description = "purpose embeddings prediciting Self-Acceptance Subscale Ratings",
      multi_cores = T,
      save_output = "all",)
    
    # Save the model output to an RDS file
    saveRDS(purpose_acceptance_sub, rds_file_path)
  } else {
    # If the RDS file already exists, load the data from it
    purpose_acceptance_sub <- readRDS(rds_file_path)
  }
  
  ####purpose Personal Growth############################################################################### 

rds_file_path <- file.path(model_dir, "purpose_growth_sub.RDS") #update with the path to each model


  if (!file.exists(rds_file_path)) {
    purpose_growth_sub <- textTrainRegression(
      x = embeddings$texts[10:12], # the three purpose prompts
      y = df$post_PWB_positive_relations, #predicting positive purpose 
      method_cor = "pearson",
      model_description = "purpose embeddings prediciting Personal Growth Subscale Ratings",
      multi_cores = T,
      save_output = "all",)
    
    # Save the model output to an RDS file
    saveRDS(purpose_growth_sub, rds_file_path)
  } else {
    # If the RDS file already exists, load the data from it
    purpose_growth_sub <- readRDS(rds_file_path)
  }
  
  ####purpose PWB############################################################################### 


rds_file_path <- file.path(model_dir, "purpose_PWB_sub.RDS") #update with the path to each model
  
  if (!file.exists(rds_file_path)) {
    purpose_PWB_sub <- textTrainRegression(
      x = embeddings$texts[10:12], # the three purpose prompts
      y = df$post_PWB_mean, #predicting purpose 
      method_cor = "pearson",
      model_description = "purpose embeddings prediciting PWB Subscale Ratings",
      multi_cores = T,
      save_output = "all",)
    
    # Save the model output to an RDS file
    saveRDS(purpose_PWB_sub, rds_file_path)
  } else {
    # If the RDS file already exists, load the data from it
    purpose_PWB_sub <- readRDS(rds_file_path)
  }
  
  
  ####purpose SWLS############################################################################### 
rds_file_path <- file.path(model_dir, "purpose_SWLS_sub.RDS") #update with the path to each model

  
  if (!file.exists(rds_file_path)) {
    purpose_SWLS_sub <- textTrainRegression(
      x = embeddings$texts[10:12], # the three purpose prompts
      y = df$post_SWLS_mean, #predicting purpose 
      method_cor = "pearson",
      model_description = "purpose embeddings prediciting SWLS Subscale Ratings",
      multi_cores = T,
      save_output = "all",)
    
    # Save the model output to an RDS file
    saveRDS(purpose_SWLS_sub, rds_file_path)
  } else {
    # If the RDS file already exists, load the data from it
    purpose_SWLS_sub <- readRDS(rds_file_path)
  }
