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
#######Subscale Prediction######################################################################################  

#Setworking directory to where we want the Subscale models ot live
setwd("/Users/sm9518/Library/CloudStorage/Dropbox/LP2-wellbeing-pred/LP2-wellbeing-prediction/subscale-models-post/affect")
##################Personal affect######################################################################################

####Pos Affect Predicting Autonomy############################################################################### 
if (!file.exists("affect_autonomy_sub.RDS")) {
  affect_autonomy_sub <- textTrainRegression(
    x = embeddings$texts[7:9], # the three affect prompts
    y = df$pre_PWB_autonomy, #predicting autonomy 
    method_cor = "pearson",
    model_description = "affect embeddings prediciting Autonomy Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(affect_autonomy_sub, "affect_autonomy_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  affect_autonomy_sub <- readRDS("affect_autonomy_sub.RDS")
}

####affect Predicting Purpose############################################################################### 
if (!file.exists("affect_purpose_sub.RDS")) {
  affect_purpose_sub <- textTrainRegression(
    x = embeddings$texts[7:9], # the three affect prompts
    y = df$pre_PWB_purpose, #predicting affect 
    method_cor = "pearson",
    model_description = "affect embeddings prediciting Purpose Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(affect_purpose_sub, "affect_purpose_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  affect_purpose_sub <- readRDS("affect_purpose_sub.RDS")
}

####affect Predicting Relationships###############################################################################
if (!file.exists("affect_relationships_sub.RDS")) {
  affect_relationships_sub <- textTrainRegression(
    x = embeddings$texts[7:9], # the three affect prompts
    y = df$pre_PWB_positive_relations, #predicting affect 
    method_cor = "pearson",
    model_description = "affect embeddings prediciting Relationships Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(affect_relationships_sub, "affect_relationships_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  affect_relationships_sub <- readRDS("affect_relationships_sub.RDS")
}


####affect Predicting Self-Acceptance############################################################################### 
if (!file.exists("affect_acceptance_sub.RDS")) {
  affect_acceptance_sub <- textTrainRegression(
    x = embeddings$texts[7:9], # the three affect prompts
    y = df$pre_PWB_positive_relations, #predicting affect 
    method_cor = "pearson",
    model_description = "affect embeddings prediciting Self-Acceptance Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(affect_acceptance_sub, "affect_acceptance_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  affect_acceptance_sub <- readRDS("affect_acceptance_sub.RDS")
}

####affect Personal Growth############################################################################### 
if (!file.exists("affect_growth_sub.RDS")) {
  affect_growth_sub <- textTrainRegression(
    x = embeddings$texts[7:9], # the three affect prompts
    y = df$pre_PWB_positive_relations, #predicting positive relations 
    method_cor = "pearson",
    model_description = "affect embeddings prediciting Personal Growth Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(affect_growth_sub, "affect_growth_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  affect_growth_sub <- readRDS("affect_growth_sub.RDS")
}

####affect PWB############################################################################### 
job::job({

if (!file.exists("affect_PWB_sub.RDS")) {
  affect_PWB_sub <- textTrainRegression(
    x = embeddings$texts[7:9], # the three affect prompts
    y = df$pre_PWB_mean, #predicting affect 
    method_cor = "pearson",
    model_description = "affect embeddings prediciting PWB Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(affect_PWB_sub, "affect_PWB_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  affect_PWB_sub.RDS <- readRDS("affect_PWB_sub.RDS")
}
  
})

####affect SWLS############################################################################### 

job::job({
if (!file.exists("affect_SWLS_sub.RDS")) {
  affect_SWLS_sub <- textTrainRegression(
    x = embeddings$texts[7:9], # the three affect prompts
    y = df$pre_SWLS_mean, #predicting affect 
    method_cor = "pearson",
    model_description = "affect embeddings prediciting SWLS Subscale Ratings",
    multi_cores = F,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(affect_SWLS_sub, "affect_SWLS_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  affect_SWLS_sub <- readRDS("affect_SWLS_sub.RDS")
}
})


if (!file.exists("affect_mastery_sub.RDS")) {
  affect_mastery_sub <- textTrainRegression(
    x = embeddings$texts[7:9], # the three affect prompts
    y = df$post_PWB_environmental_mastery, #predicting affect 
    method_cor = "pearson",
    model_description = "affect embeddings prediciting Mastery Subscale Ratings",
    multi_cores = T,
    save_output = "all",)
  
  # Save the model output to an RDS file
  saveRDS(affect_mastery_sub, "affect_mastery_sub.RDS")
} else {
  # If the RDS file already exists, load the data from it
  affect_mastery_sub <- readRDS("affect_mastery_sub.RDS")
}
