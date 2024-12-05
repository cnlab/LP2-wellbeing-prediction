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
df <- read_csv(file.path(data_dir,"/data_prediction/surveys_scored/LP2_transcriptions_behavioral.csv"))

### keep only people with post data 
df <- df %>%
  filter(rowSums(is.na(select(., starts_with("post")))) == 0)

### load the post embeddings 
embeddings <- read_rds("/Users/sm9518/Library/CloudStorage/Box-Box/LP2/well-being-prediction/embeddings/Study1_post__embeddings.rds")

#######Subscale Prediction######################################################################################  


model_dir = "/Users/sm9518/Library/CloudStorage/Dropbox/LP2-wellbeing-pred/LP2-wellbeing-prediction/subscale-models-post/growth"
##################Personal Growth######################################################################################


####Growth Predicting Autonomy############################################################################### 

rds_file_path <- file.path(model_dir, "growth_autonomy_sub.RDS") #update with the path to each model
if (!file.exists(rds_file_path)) {
  growth_autonomy_sub <- textTrainRegression(
    x = embeddings$texts[4:6], # the three growth prompts
    y = df$post_PWB_autonomy, #predicting autonomy 
    method_cor = "pearson",
    model_description = "Growth embeddings prediciting Autonomy Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(growth_autonomy_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  growth_autonomy_sub <- readRDS(rds_file_path)
}

####growth Predicting Purpose############################################################################### 

rds_file_path <- file.path(model_dir, "growth_purpose_sub.RDS") #update with the path to each model


if (!file.exists(rds_file_path)) {
  growth_purpose_sub <- textTrainRegression(
    x = embeddings$texts[4:6], # the three growth prompts
    y = df$post_PWB_purpose, #predicting growth 
    method_cor = "pearson",
    model_description = "growth embeddings prediciting Purpose Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(growth_purpose_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  growth_purpose_sub <- readRDS(rds_file_path)
}

####growth Predicting Relationships###############################################################################

rds_file_path <- file.path(model_dir, "growth_relationships_sub.RDS") #update with the path to each model

if (!file.exists(rds_file_path)) {
  growth_relationships_sub <- textTrainRegression(
    x = embeddings$texts[4:6], # the three growth prompts
    y = df$post_PWB_positive_relations, #predicting growth 
    method_cor = "pearson",
    model_description = "growth embeddings prediciting Relationships Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(growth_relationships_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  growth_relationships_sub <- readRDS(rds_file_path)
}


####growth Predicting Self-Acceptance############################################################################### 

rds_file_path <- file.path(model_dir, "growth_acceptance_sub.RDS") #update with the path to each model

if (!file.exists(rds_file_path)) {
  growth_acceptance_sub <- textTrainRegression(
    x = embeddings$texts[4:6], # the three growth prompts
    y = df$post_PWB_positive_relations, #predicting growth 
    method_cor = "pearson",
    model_description = "growth embeddings prediciting Self-Acceptance Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(growth_acceptance_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  growth_acceptance_sub <- readRDS(rds_file_path)
}

####growth Personal Growth############################################################################### 

rds_file_path <- file.path(model_dir, "growth_growth_sub.RDS") #update with the path to each model

if (!file.exists(rds_file_path)) {
  growth_growth_sub <- textTrainRegression(
    x = embeddings$texts[4:6], # the three growth prompts
    y = df$post_PWB_positive_relations, #predicting positive relations 
    method_cor = "pearson",
    model_description = "growth embeddings prediciting Personal Growth Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(growth_growth_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  growth_growth_sub <- readRDS(rds_file_path)
}

####growth PWB############################################################################### 

rds_file_path <- file.path(model_dir, "growth_PWB_sub.RDS") #update with the path to each model

if (!file.exists(rds_file_path)) {
  growth_PWB_sub <- textTrainRegression(
    x = embeddings$texts[4:6], # the three growth prompts
    y = df$post_PWB_mean, #predicting growth 
    method_cor = "pearson",
    model_description = "growth embeddings prediciting PWB Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(growth_PWB_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  growth_PWB_sub <- readRDS(rds_file_path)
}

####growth SWLS############################################################################### 
rds_file_path <- file.path(model_dir, "growth_SWLS_sub.RDS") #update with the path to each model


if (!file.exists(rds_file_path)) {
  growth_SWLS_sub <- textTrainRegression(
    x = embeddings$texts[4:6], # the three growth prompts
    y = df$post_SWLS_mean, #predicting growth 
    method_cor = "pearson",
    model_description = "growth embeddings prediciting SWLS Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(growth_SWLS_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  growth_SWLS_sub <- readRDS(rds_file_path)
}


###mastery 

rds_file_path <- file.path(model_dir, "growth_mastery_sub.RDS") #update with the path to each model


if (!file.exists(rds_file_path)) {
  growth_mastery_sub <- textTrainRegression(
    x = embeddings$texts[4:6], # the three growth prompts
    y = df$post_PWB_environmental_mastery, #predicting growth 
    method_cor = "pearson",
    model_description = "growth embeddings prediciting mastery Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(growth_mastery_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  growth_mastery_sub <- readRDS(rds_file_path)
}

