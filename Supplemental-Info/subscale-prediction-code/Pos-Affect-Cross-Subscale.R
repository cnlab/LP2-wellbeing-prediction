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


model_dir = "/Users/sm9518/Library/CloudStorage/Dropbox/LP2-wellbeing-pred/LP2-wellbeing-prediction/subscale-models-post/affect"
##################Personal affect######################################################################################

####Pos Affect Predicting Autonomy############################################################################### 

rds_file_path <- file.path(model_dir, "affect_autonomy_sub.RDS") #update with the path to each model

if (!file.exists(rds_file_path)) {
  affect_autonomy_sub <- textTrainRegression(
    x = embeddings$texts[7:9], # the three affect prompts
    y = df$post_PWB_autonomy, #predicting autonomy 
    method_cor = "pearson",
    model_description = "affect embeddings prediciting Autonomy Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(affect_autonomy_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  affect_autonomy_sub <- readRDS(rds_file_path)
}

####affect Predicting Purpose############################################################################### 

rds_file_path <- file.path(model_dir, "affect_purpose_sub.RDS") #update with the path to each model

if (!file.exists(rds_file_path)) {
  affect_purpose_sub <- textTrainRegression(
    x = embeddings$texts[7:9], # the three affect prompts
    y = df$post_PWB_purpose, #predicting affect 
    method_cor = "pearson",
    model_description = "affect embeddings prediciting Purpose Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(affect_purpose_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  affect_purpose_sub <- readRDS(rds_file_path)
}

####affect Predicting Relationships###############################################################################
rds_file_path <- file.path(model_dir, "affect_relationships_sub.RDS") #update with the path to each model

if (!file.exists(rds_file_path)) {
  affect_relationships_sub <- textTrainRegression(
    x = embeddings$texts[7:9], # the three affect prompts
    y = df$post_PWB_positive_relations, #predicting affect 
    method_cor = "pearson",
    model_description = "affect embeddings prediciting Relationships Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(affect_relationships_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  affect_relationships_sub <- readRDS(rds_file_path)
}


####affect Predicting Self-Acceptance############################################################################### 
rds_file_path <- file.path(model_dir, "affect_acceptance_sub.RDS") #update with the path to each model

if (!file.exists(rds_file_path)) {
  affect_acceptance_sub <- textTrainRegression(
    x = embeddings$texts[7:9], # the three affect prompts
    y = df$post_PWB_positive_relations, #predicting affect 
    method_cor = "pearson",
    model_description = "affect embeddings prediciting Self-Acceptance Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(affect_acceptance_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  affect_acceptance_sub <- readRDS(rds_file_path)
}

####affect Personal Growth############################################################################### 
rds_file_path <- file.path(model_dir, "affect_growth_sub.RDS") #update with the path to each model


if (!file.exists(rds_file_path)) {
  affect_growth_sub <- textTrainRegression(
    x = embeddings$texts[7:9], # the three affect prompts
    y = df$post_PWB_positive_relations, #predicting positive relations 
    method_cor = "pearson",
    model_description = "affect embeddings prediciting Personal Growth Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(affect_growth_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  affect_growth_sub <- readRDS(rds_file_path)
}

####affect PWB############################################################################### 
rds_file_path <- file.path(model_dir, "affect_PWB_sub.RDS") #update with the path to each model

if (!file.exists(rds_file_path)) {
  affect_PWB_sub <- textTrainRegression(
    x = embeddings$texts[7:9], # the three affect prompts
    y = df$post_PWB_mean, #predicting affect 
    method_cor = "pearson",
    model_description = "affect embeddings prediciting PWB Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(affect_PWB_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  affect_PWB_sub <- readRDS(rds_file_path)
}
  
####affect SWLS############################################################################### 

rds_file_path <- file.path(model_dir, "affect_SWLS_sub.RDS") #update with the path to each model

job::job({
if (!file.exists(rds_file_path)) {
  affect_SWLS_sub <- textTrainRegression(
    x = embeddings$texts[7:9], # the three affect prompts
    y = df$post_SWLS_mean, #predicting affect 
    method_cor = "pearson",
    model_description = "affect embeddings prediciting SWLS Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(affect_SWLS_sub, rds_file_path)
} else {
  # If the RDS file already exists, load the data from it
  affect_SWLS_sub <- readRDS(rds_file_path)
}
})



data_dir="/Users/sm9518/Library/CloudStorage/Box-Box/LP2/within_person_intervention"
df <- read_csv(file.path(data_dir,"/data_prediction/surveys_scored/LP2_transcriptions_behavioral.csv"))
embeddings <- readRDS(file.path(data_dir,"/data_prediction/embeddings/study_1/all_embeddings.rds"))

#######Subscale Prediction######################################################################################  

#Setworking directory to where we want the Subscale models ot live
setwd("/Users/sm9518/Library/CloudStorage/Dropbox/LP2-wellbeing-pred/LP2-wellbeing-prediction/Subscale-Models/affect")

if (!file.exists("affect_mastery_sub.RDS")) {
  affect_mastery_sub <- textTrainRegression(
    x = embeddings$texts[7:9], # the three accept prompts
    y = df$pre_PWB_environmental_mastery, #predicting autonomy 
    method_cor = "pearson",
    model_description = "pos affect embeddings prediciting mastery Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(affect_mastery_sub, "affect_mastery_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  affect_mastery_sub <- readRDS("affect_mastery_sub.RDS")
}
