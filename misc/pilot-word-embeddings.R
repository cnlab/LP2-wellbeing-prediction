#generate word embeddings using text 
setwd("~/Box Sync/LP2-Pilot1/LP2-pilot1")
if (!require("pacman")) install.packages("pacman") #run this if you don't have pacman 
library(pacman)
pacman::p_load(tidyverse,rlang, zoo, lubridate, plotrix, ggpubr, caret, broom, kableExtra, reactable, text,install = T) 
#devtools::install_github("oscarkjell/text")
# Set-up an environment with text-required python packages
textrpp_install()
textrpp_initialize()

data <- read_csv("~/Box Sync/LP2-Pilot1/LIWC_transcripts_alldays_tokenized.csv")
data$category <- as.factor(data$category) #set category to class to partition 

# neg emo 
neg <- data %>% 
  filter(category=="neg") %>% 
  select(1:3,6,7,73:91)


neg_word_embeddings <- textEmbed(neg$text,
                                 model = "bert-base-uncased",
                                 layers = -2,
                                 aggregation_from_layers_to_tokens = "concatenate",
                                 aggregation_from_tokens_to_texts = "mean",
                                 aggregation_from_tokens_to_word_types = "mean",
                                 keep_token_embeddings = F)


#save embeddings as rds so we don't need to do this again 
saveRDS(neg_word_embeddings, "~/Box Sync/LP2-Pilot1/LP2-pilot1/neg_word_embeddings.rds")


# pos emo
pos <- data %>%
  filter(category == "pos") %>%
  select(1:3, 6, 7, 73:91) %>% 
  na.omit()

#make a dataframe of ONLY the text data 
positive_text <- pos %>% 
  select(1,2,3)




#embed with textEmbedRawLayers. gives more contorl over how we embed

# Record the start time
start_time <- Sys.time()
pos_word_embeddings <- textEmbed(positive_text,
                                 model = "bert-base-uncased",
                                 layers = -2,
                                 aggregation_from_layers_to_tokens = "concatenate",
                                 aggregation_from_tokens_to_texts = "mean",
                                 aggregation_from_tokens_to_word_types = "mean",
                                 keep_token_embeddings = F)


# Record the end time
end_time <- Sys.time()

# Calculate the runtime
runtime <- end_time - start_time

# Print the runtime
cat("Code execution completed in", as.numeric(runtime), "seconds.\n")
#This code will display the runtime of your code in seconds after it has finished executing.






#save embeddings as rds so we don't need to do this again 
saveRDS(pos_word_embeddings, "~/Box Sync/LP2-Pilot1/LP2-pilot1/pos_word_embeddings.rds")


pos_word_embeddings <- readRDS("~/Box Sync/LP2-Pilot1/LP2-pilot1/pos_word_embeddings.rds")


#only select the second to last layer 






# pos emo
neg <- data %>%
  filter(category == "neg") %>%
  select(1:3, 6, 7, 73:91) %>% 
  na.omit()

#make a dataframe of ONLY the text data 
negative_text <- neg %>% 
  select(1,2,3)



start_time <- Sys.time()
neg_word_embeddings <- textEmbed(negative_text,
                                 model = "bert-base-uncased",
                                 layers = -2,
                                 aggregation_from_layers_to_tokens = "concatenate",
                                 aggregation_from_tokens_to_texts = "mean",
                                 aggregation_from_tokens_to_word_types = "mean",
                                 keep_token_embeddings = F)


# Record the end time
end_time <- Sys.time()

# Calculate the runtime
runtime <- end_time - start_time

# Print the runtime
cat("Code execution completed in", as.numeric(runtime), "seconds.\n")
#This code will display the runt

#save embeddings as rds so we don't need to do this again 
saveRDS(neg_word_embeddings, "~/Box Sync/LP2-Pilot1/LP2-pilot1/neg_word_embeddings.rds")


neg_word_embeddings <- readRDS("~/Box Sync/LP2-Pilot1/LP2-pilot1/neg_word_embeddings.rds")



###start to model 

###Positive emotion 

results <- textTrainRegression(
  x = pos_word_embeddings$texts$text,
  y = pos$day4_posemo,
  multi_cores = FALSE # This is FALSE due to CRAN testing and Windows machines.
)

results

#preprocessing
projection_results <- textProjection(words = positive_text$text,
                                     word_embeddings = pos_word_embeddings$texts,
                                     word_types_embeddings = pos_word_embeddings$word_types,
                                     x = pos$day4_posemo)


# Supervised Dimension Projection Plot
# To avoid warnings -- and that words do not get plotted, first increase the max.overlaps
options(ggrepel.max.overlaps = 1000)

plot_projection <- textProjectionPlot(
  word_data = projection_results,
  min_freq_words_plot = 1,
  plot_n_word_extreme = 10,
  plot_n_word_frequency = 1,
  plot_n_words_middle = 1,
  y_axes = FALSE,
  p_alpha = 0.05,
  p_adjust_method = "fdr",
  title_top = "Positive Emotion words (Supervised Dimension Projection)",
  x_axes_label = "Day 4 Positive Emotion Scores",
  y_axes_label = "",
  bivariate_color_codes = c("#FFFFFF", "#FFFFFF", "#FFFFFF",
                            "#E07f6a", "green", "blue",
                            "#FFFFFF", "#FFFFFF", "#FFFFFF")
)

plot_projection$final_plot










