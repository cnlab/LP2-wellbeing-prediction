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


model_dir = "/Users/sm9518/Library/CloudStorage/Dropbox/LP2-wellbeing-pred/LP2-wellbeing-prediction/subscale-models-post/acceptance"

####acceptance Predicting Autonomy############################################################################### 

rds_file_path <- file.path(model_dir, "accept_autonomy_sub.RDS") #update with the path to each model


if (!file.exists(rds_file_path)) {
  accept_autonomy_sub <- textTrainRegression(
    x = embeddings$texts[16:18], # the three accept prompts
    y = df$post_PWB_autonomy, #predicting autonomy 
    method_cor = "pearson",
    model_description = "accept embeddings prediciting Autonomy Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(accept_autonomy_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  accept_autonomy_sub <- readRDS(rds_file_path)
}



####accept Predicting purpose############################################################################### 


rds_file_path <- file.path(model_dir, "accept_purpose_sub.RDS") #update with the path to each model

if (!file.exists(rds_file_path)) {
  accept_purpose_sub <- textTrainRegression(
    x = embeddings$texts[16:18], # the three accept prompts
    y = df$post_PWB_purpose, #predicting accept 
    method_cor = "pearson",
    model_description = "accept embeddings prediciting accept Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(accept_purpose_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  accept_purpose_sub <- readRDS(rds_file_path)
}

####accept Predicting Relationships###############################################################################
rds_file_path <- file.path(model_dir, "accept_relationships_sub.RDS") #update with the path to each model


if (!file.exists(rds_file_path)) {
  accept_relationships_sub <- textTrainRegression(
    x = embeddings$texts[16:18], # the three accept prompts
    y = df$post_PWB_positive_relations, #predicting accept 
    method_cor = "pearson",
    model_description = "accept embeddings prediciting Relationships Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(accept_relationships_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  accept_relationships_sub <- readRDS(rds_file_path)
}


####accept Predicting Self-Acceptance############################################################################### 

rds_file_path <- file.path(model_dir, "accept_acceptance_sub.RDS") #update with the path to each model



if (!file.exists(rds_file_path)) {
  accept_acceptance_sub <- textTrainRegression(
    x = embeddings$texts[16:18], # the three accept prompts
    y = df$post_PWB_self_acceptance, #predicting accept 
    method_cor = "pearson",
    model_description = "accept embeddings prediciting Self-Acceptance Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(accept_acceptance_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  accept_acceptance_sub <- readRDS(rds_file_path)
}

####accept Personal Growth############################################################################### 

rds_file_path <- file.path(model_dir, "accept_growth_sub.RDS") #update with the path to each model


if (!file.exists(rds_file_path)) {
  accept_growth_sub <- textTrainRegression(
    x = embeddings$texts[16:18], # the three accept prompts
    y = df$post_PWB_personal_growth, #predicting positive accept 
    method_cor = "pearson",
    model_description = "accept embeddings prediciting Personal Growth Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(accept_growth_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  accept_growth_subS <- readRDS(rds_file_path)
}

####accept PWB############################################################################### 

rds_file_path <- file.path(model_dir, "accept_PWB_sub.RDS") #update with the path to each model


if (!file.exists(rds_file_path)) {
  accept_PWB_sub <- textTrainRegression(
    x = embeddings$texts[16:18], # the three accept prompts
    y = df$post_PWB_mean, #predicting accept 
    method_cor = "pearson",
    model_description = "accept embeddings prediciting PWB Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(accept_PWB_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  accept_PWB_sub <- readRDS(rds_file_path)
}


####accept SWLS############################################################################### 


rds_file_path <- file.path(model_dir, "accept_SWLS_sub.RDS") #update with the path to each model


if (!file.exists(rds_file_path)) {
  accept_SWLS_sub <- textTrainRegression(
    x = embeddings$texts[16:18], # the three accept prompts
    y = df$post_SWLS_mean, #predicting accept 
    method_cor = "pearson",
    model_description = "accept embeddings prediciting SWLS Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(accept_SWLS_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  accept_SWLS_sub <- readRDS(rds_file_path)
}

