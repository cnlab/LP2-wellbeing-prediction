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
setwd("/Users/sm9518/Library/CloudStorage/Dropbox/LP2-wellbeing-pred/LP2-wellbeing-prediction/Subscale-Models/purpose")
##################purposehips######################################################################################

job::job({
  
####Pos Affect Predicting Autonomy############################################################################### 
  if (!file.exists("purpose_autonomy_sub.RDS")) {
    purpose_autonomy_sub <- textTrainRegression(
      x = embeddings$texts[10:12], # the three purpose prompts
      y = df$pre_PWB_autonomy, #predicting autonomy 
      method_cor = "pearson",
      model_description = "purpose embeddings prediciting Autonomy Subscale Ratings",
      multi_cores = F,
      save_output = "all",)
    
    # Save the model output to an RDS file
    saveRDS(purpose_autonomy_sub, "purpose_autonomy_sub.RDS")
  } else {
    # If the RDS file already exists, load the data from it
    purpose_autonomy_sub <- readRDS("purpose_autonomy_sub.RDS")
  }
  
####purpose Predicting Purpose############################################################################### 
  if (!file.exists("purpose_purpose_sub.RDS")) {
    purpose_purpose_sub <- textTrainRegression(
      x = embeddings$texts[10:12], # the three purpose prompts
      y = df$pre_PWB_purpose, #predicting purpose 
      method_cor = "pearson",
      model_description = "purpose embeddings prediciting Purpose Subscale Ratings",
      multi_cores = F,
      save_output = "all",)
    
    # Save the model output to an RDS file
    saveRDS(purpose_purpose_sub, "purpose_purpose_sub.RDS")
  } else {
    # If the RDS file already exists, load the data from it
    purpose_purpose_sub <- readRDS("purpose_purpose_sub.RDS")
  }
  
  ####purpose Predicting Relationships###############################################################################
  if (!file.exists("purpose_relationships_sub.RDS")) {
    purpose_relationships_sub <- textTrainRegression(
      x = embeddings$texts[10:12], # the three purpose prompts
      y = df$pre_PWB_positive_relations, #predicting purpose 
      method_cor = "pearson",
      model_description = "purpose embeddings prediciting Relationships Subscale Ratings",
      multi_cores = F,
      save_output = "all",)
    
    # Save the model output to an RDS file
    saveRDS(purpose_relationships_sub, "purpose_relationships_sub.RDS")
  } else {
    # If the RDS file already exists, load the data from it
    purpose_relationships_sub <- readRDS("purpose_relationships_sub.RDS")
  }
  
  
  ####purpose Predicting Self-Acceptance############################################################################### 
  if (!file.exists("purpose_acceptance_sub.RDS")) {
    purpose_acceptance_sub <- textTrainRegression(
      x = embeddings$texts[10:12], # the three purpose prompts
      y = df$pre_PWB_positive_relations, #predicting purpose 
      method_cor = "pearson",
      model_description = "purpose embeddings prediciting Self-Acceptance Subscale Ratings",
      multi_cores = F,
      save_output = "all",)
    
    # Save the model output to an RDS file
    saveRDS(purpose_acceptance_sub, "purpose_acceptance_sub.RDS")
  } else {
    # If the RDS file already exists, load the data from it
    purpose_acceptance_sub <- readRDS("purpose_acceptance_sub.RDS")
  }
  
  ####purpose Personal Growth############################################################################### 
  if (!file.exists("purpose_growth_sub.RDS")) {
    purpose_growth_sub <- textTrainRegression(
      x = embeddings$texts[10:12], # the three purpose prompts
      y = df$pre_PWB_positive_relations, #predicting positive purpose 
      method_cor = "pearson",
      model_description = "purpose embeddings prediciting Personal Growth Subscale Ratings",
      multi_cores = F,
      save_output = "all",)
    
    # Save the model output to an RDS file
    saveRDS(purpose_growth_sub, "purpose_growth_sub.RDS")
  } else {
    # If the RDS file already exists, load the data from it
    purpose_growth_sub <- readRDS("purpose_growth_sub.RDS")
  }
  
  ####purpose PWB############################################################################### 
  
  if (!file.exists("purpose_PWB_sub.RDS")) {
    purpose_PWB_sub <- textTrainRegression(
      x = embeddings$texts[10:12], # the three purpose prompts
      y = df$pre_PWB_mean, #predicting purpose 
      method_cor = "pearson",
      model_description = "purpose embeddings prediciting PWB Subscale Ratings",
      multi_cores = F,
      save_output = "all",)
    
    # Save the model output to an RDS file
    saveRDS(purpose_PWB_sub, "purpose_PWB_sub.RDS")
  } else {
    # If the RDS file already exists, load the data from it
    purpose_PWB_sub <- readRDS("purpose_PWB_sub.RDS")
  }
  
  
  ####purpose SWLS############################################################################### 
  
  
  if (!file.exists("purpose_SWLS_sub.RDS")) {
    purpose_SWLS_sub <- textTrainRegression(
      x = embeddings$texts[10:12], # the three purpose prompts
      y = df$pre_SWLS_mean, #predicting purpose 
      method_cor = "pearson",
      model_description = "purpose embeddings prediciting SWLS Subscale Ratings",
      multi_cores = F,
      save_output = "all",)
    
    # Save the model output to an RDS file
    saveRDS(purpose_SWLS_sub, "purpose_SWLS_sub.RDS")
  } else {
    # If the RDS file already exists, load the data from it
    purpose_SWLS_sub <- readRDS("purpose_SWLS_sub.RDS")
  }
})

####purpose predicting mastery
if (!file.exists("purpose_mastery_sub.RDS")) {
  purpose_mastery_sub <- textTrainRegression(
    x = embeddings$texts[10:12], # the three purpose prompts
    y = df$pre_PWB_environmental_mastery, #predicting autonomy 
    method_cor = "pearson",
    model_description = "purpose embeddings prediciting mastery Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(purpose_mastery_sub, "purpose_mastery_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  purpose_mastery_sub <- readRDS("purpose_mastery_sub.RDS")
}
