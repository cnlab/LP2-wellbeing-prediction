df <- read_csv("/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/surveys_scored/LP2_transcriptions_behavioral.csv")


df = df %>% 
  select(1,67:85)

### gather the data 
df_long <- pivot_longer(df, cols = c(2:20), names_to = "Prompt", values_to = "Text")

write_csv(df_long, "/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/surveys_scored/LP2_transcriptions_behavioral_LONG.csv")


### read in the content words 

content_words = read_csv("/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/surveys_scored/LP2_transcriptions_behavioral_LONG_CONTENT_WORDS.csv")


content_words$content_words <- gsub("\\[|\\]", "", content_words$content_words)  # Removing square brackets
content_words$content_words <- gsub("'", "", content_words$content_words)

content_words = content_words %>% 
  select(2,3,5)


df_wide <- pivot_wider(content_words, names_from = "Prompt", values_from = "content_words")

#Join back to behavioral data 
df <- read_csv("/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/surveys_scored/LP2_transcriptions_behavioral.csv")

df = df %>% 
  select(1:66)

merged_df <- left_join(df, df_wide, by = "pID")




write_csv(merged_df, "/Users/stevenmesquiti/Box Sync/CurrentProjects_Penn/LP2/within_person_intervention/data/surveys_scored/LP2_transcriptions_behavioral_CONTENT_Words.csv")



