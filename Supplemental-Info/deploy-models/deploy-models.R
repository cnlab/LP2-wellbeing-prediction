if (!require("pacman")) install.packages("pacman") #run this if you don't have pacman 
library(pacman)
set.seed(123)
pacman::p_load(tidyverse,rlang, plotrix, ggpubr, caret, broom, kableExtra, reactable, psych,knitr, DT, stringr,ggwordcloud,Metrics,scales,rsample, purrr,psych,apaTables, tibble,install = T) 
#reticulate::conda_list()
#devtools::install_github("oscarkjell/text")
library(text)
textrpp_install(prompt = F)
textrpp_initialize()

### load the models from Study 3
study3_autonomy_model = readRDS("~/Desktop/LP2-wellbeing-prediction/models/Study3/autonomy/autonomy_autonomy.RDS")
study3_swls_model = readRDS("~/Desktop/LP2-wellbeing-prediction/models/Study3/SWL/swls_swls.rds")

### Study 1 

study1_bx = read_csv("~/Desktop/LP2-wellbeing-prediction/data/WBP_Study1_Cleaned.csv")
# pull the text off of box
study1_text = read_csv('/Users/sm9518/Library/CloudStorage/Box-Box/LP2/within_person_intervention/data_prediction/surveys_scored/LP2_transcriptions_behavioral.csv')

autonomy_vars <- names(study1_text) %>% 
  str_subset("autonomy_\\d+.*Transcription")

positive_affect_vars <- names(study1_text) %>% 
  str_subset("positive_affect_\\d+.*Transcription")

# Combine autonomy responses into one column called `autonomy_text`
study1_text <- study1_text %>%
  mutate(autonomy_text = apply(select(., all_of(autonomy_vars)), 1, function(x) {
    str_c(na.omit(x), collapse = " ")  # collapse non-NA values with a space
  })) %>% 
  mutate(positive_affect_text = apply(select(., all_of(positive_affect_vars)), 1, function(x) {
    str_c(na.omit(x), collapse = " ")
  })) |> 
  select(pID, autonomy_text, positive_affect_text)

study1 = study1_bx |> 
  select(!contains("post_")) |> 
  left_join(study1_text, by = "pID") 

### use study 3 model to predict study1 values
prediction1 <- textPredict(
  model_info = study3_autonomy_model,
  study1$autonomy_text,
  save_dir = '~/Desktop/LP2-wellbeing-prediction/Supplemental-Info/deploy-models', 
  save_name = "study1_autonomy_predictions",
  check_matching_word_embeddings = FALSE,
  dim_names = FALSE,
  device = "mps",
  set_seed = 42
)

### correlate the predictions 

autonomy = psych::corr.test(
  prediction1$`word_embeddings__df$\`PWBautonomy\`pred`,
  study1$pre_PWB_autonomy)

print(psych::corr.test(
  prediction1$`word_embeddings__df$\`PWBautonomy\`pred`,
  study1$pre_PWB_autonomy),short = FALSE)

### train the SWLS model 
prediction2 <- textPredict(
  model_info = study3_swls_model,
  study1$positive_affect_text,
  save_dir = '~/Desktop/LP2-wellbeing-prediction/Supplemental-Info/deploy-models', 
  save_name = "study1_pos_affect_predictions",
  check_matching_word_embeddings = FALSE,
  dim_names = FALSE,
  device = "mps",
  set_seed = 42
)

swls = psych::corr.test(
  prediction2$`word_embeddings__df$\`SWLSmean\`pred`,
  study1$pre_SWLS_mean)
swls


print(psych::corr.test(
  prediction2$`word_embeddings__df$\`SWLSmean\`pred`,
  study1$pre_SWLS_mean),short = FALSE)

# Load Study 2 Data

data_dir="/Users/sm9518/Library/CloudStorage/Box-Box/LP2/well-being-prediction"
df = read.csv(file.path(data_dir,"data/osf/data/WBP_Study2_Behavioral_Cleaned.csv"))


df = df %>% 
  select(pID, score, measure) %>% 
  spread(key = measure, value = score)

###prep the text data 
text = read_csv('/Users/sm9518/Library/CloudStorage/Box-Box/LP2/well-being-prediction/data_text/WBP_Study2_wellbeing-prediction-text-long.csv')


text_grouped <- text %>%
  group_by(pID, prompt) %>%
  summarise(
    text_combined = paste(text, collapse = " ")
  ) %>%
  ungroup()

# Reshape data from long to wide format
text_embed <- text_grouped %>%
  spread(key = prompt, value = text_combined)


text_embed_pids <- unique(text_embed$pID)

# Filter df to include only rows with pID in text_embed_pids
study2 <- df %>%
  filter(pID %in% text_embed_pids) |> 
  left_join(text_embed, by = "pID") 



### use study 3 model to predict study1 values
prediction1 <- textPredict(
  model_info = study3_autonomy_model,
  study2$Autonomy,
  save_dir = '~/Desktop/LP2-wellbeing-prediction/Supplemental-Info/deploy-models', 
  save_name = "study2_autonomy_predictions",
  check_matching_word_embeddings = FALSE,
  dim_names = FALSE,
  device = "mps",
  set_seed = 42
)

### correlate the predictions 

autonomy = psych::corr.test(
  prediction1$`word_embeddings__df$\`PWBautonomy\`pred`,
  study2$`PWB autonomy`)



### train the SWLS model 
prediction2 <- textPredict(
  model_info = study3_swls_model,
  study2$SWLS,
  save_dir = '~/Desktop/LP2-wellbeing-prediction/Supplemental-Info/deploy-models', 
  save_name = "study2_SWLS",
  check_matching_word_embeddings = FALSE,
  dim_names = FALSE,
  device = "mps",ga
  set_seed = 42
)

swls = psych::corr.test(
  prediction2$`word_embeddings__df$\`SWLSmean\`pred`,
  study2$`SWLS mean`)
swls

print(psych::corr.test(
  prediction2$`word_embeddings__df$\`SWLSmean\`pred`,
  study2$`SWLS mean`), short = FALSE)
