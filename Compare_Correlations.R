library(pacman)
pacman::p_load(tidyverse, DescTools, psych, install = TRUE)

# Load GPT-3.5 predictions
autonomy <- read_csv('~/Desktop/LP2-wellbeing-prediction/data/GPT/WBP-Autonomy-Text-GPT-gpt-3.5-turbo-1106-0-scores.csv')

autonomy <- autonomy |> 
  select(-ends_with("-Text")) |> 
  rename_with(~ .x |> 
                str_remove("^Autonomy_") |> 
                str_remove("-3.5-turbo-1106$")) |> 
  mutate(PWB_gpt = rowMeans(across(11:17), na.rm = TRUE)) 

autonomy_gpt35 <- autonomy |> 
  rename(Autonomy_gpt_35 = gpt) |> 
  select(pID, Autonomy_gpt_35)

swls <- read_csv('~/Desktop/LP2-wellbeing-prediction/data/GPT/WBP-SWLS-Text-GPT-gpt-3.5-turbo-1106-0-scores.csv')

swls <- swls |> 
  select(-ends_with("-Text")) |> 
  rename_with(~ .x |> 
                str_remove("^SWLS_") |> 
                str_remove("-3.5-turbo-1106$")) |> 
  mutate(PWB_gpt = rowMeans(across(11:17), na.rm = TRUE))

swls_gpt35 <- swls |> 
  rename(SWLS_gpt_35 = gpt) |>
  select(pID, SWLS_gpt_35)

# Load GPT-4 predictions
autonomy <- read_csv('~/Desktop/LP2-wellbeing-prediction/data/GPT/WBP-Autonomy-Text-GPT-gpt-4-0-scores.csv')

autonomy <- autonomy |> 
  select(-ends_with("-Text")) |> 
  rename_with(~ .x |> 
                str_remove("^Autonomy_") |> 
                str_remove("-4")) |> 
  mutate(PWB_gpt = rowMeans(across(11:17), na.rm = TRUE)) 

autonomy_gpt4 <- autonomy |> 
  rename(Autonomy_gpt_4 = Autonomy_gpt) |> 
  select(pID, Autonomy_gpt_4)

swls <- read_csv('~/Desktop/LP2-wellbeing-prediction/data/GPT/WBP-SWLS-Text-GPT-gpt-4-0-scores.csv')

swls <- swls |> 
  select(-ends_with("-Text")) |> 
  rename_with(~ .x |> 
                str_remove("^SWLS_") |> 
                str_remove("-4")) |> 
  mutate(PWB_gpt = rowMeans(across(11:17), na.rm = TRUE)) 

swls_gpt4 <- swls |> 
  rename(SWLS_gpt_4 = SWLS_gpt) |>
  select(pID, SWLS_gpt_4)

##### Load BERT predictions
data_dir <- "~/Desktop/LP2-wellbeing-prediction"
rds_file_path <- file.path(data_dir, "models/Study3/SWLS_subscale.RDS")

if (!file.exists(rds_file_path)) {
  SWLS_subscale <- textTrainLists(
    x = embeddings$texts$`SWLS-Text`,
    y = df[3:10],
    force_train_method = "regression",
    save_output = "all",
    method_cor = "pearson",
    eval_measure = "rmse",
    p_adjust_method = "fdr",
    model_description = "SWLS embeddings Well-being, N = 285"
  )
  saveRDS(SWLS_subscale, rds_file_path)
} else {
  SWLS_subscale <- readRDS(rds_file_path)
}

filtered_predictions <- na.omit(SWLS_subscale$predictions[1:8])
SWLS_subscale_predictions <- as.data.frame(filtered_predictions)
SWLS_bert_predictions <- SWLS_subscale_predictions %>% 
  mutate(pID = sprintf("WBP%03d", row_number())) %>%
  select(pID, SWLS_BERT = contains("SWLS mean_pred"))

# Load Autonomy BERT predictions
rds_file_path_autonomy <- file.path(data_dir, "models/Study3/autonomy_subscale.RDS")

if (!file.exists(rds_file_path_autonomy)) {
  Autonomy_subscale <- textTrainLists(
    x = embeddings$texts$`Autonomy-Text`,
    y = df[3:10],
    force_train_method = "regression",
    save_output = "all",
    method_cor = "pearson",
    eval_measure = "rmse",
    p_adjust_method = "fdr",
    model_description = "Autonomy embeddings well-being, N = 285"
  )
  saveRDS(Autonomy_subscale, rds_file_path_autonomy)
} else {
  Autonomy_subscale <- readRDS(rds_file_path_autonomy)
}

filtered_predictions <- na.omit(Autonomy_subscale$predictions[1:8])
Autonomy_subscale_predictions <- as.data.frame(filtered_predictions)
Autonomy_bert_predictions <- Autonomy_subscale_predictions %>% 
  mutate(pID = sprintf("WBP%03d", row_number())) %>%
  select(pID, Autonomy_BERT = contains("autonomy_pred"))

# ============================================================================
# COMPUTE CORRELATIONS BETWEEN MODEL PREDICTIONS
# ============================================================================

study3_model_corrs <- autonomy_gpt35 |> 
  inner_join(swls_gpt35, by = "pID") |> 
  inner_join(autonomy_gpt4, by = "pID") |> 
  inner_join(swls_gpt4, by = "pID") |> 
  inner_join(SWLS_bert_predictions, by = "pID") |>
  inner_join(Autonomy_bert_predictions, by = "pID")

# Correlations between BERT and GPT-4
Study3_Autonomy_BERT_GPT_4_corr <- cor(
  study3_model_corrs$Autonomy_BERT,
  study3_model_corrs$Autonomy_gpt_4,
  use = "complete.obs"
)

Study3_SWLS_BERT_GPT_4_corr <- cor(
  study3_model_corrs$SWLS_BERT,
  study3_model_corrs$SWLS_gpt_4,
  use = "complete.obs"
)

# Correlations between BERT and GPT-3.5
Study3_Autonomy_BERT_GPT_35_corr <- cor(
  study3_model_corrs$Autonomy_BERT,
  study3_model_corrs$Autonomy_gpt_35,
  use = "complete.obs"
)

Study3_SWLS_BERT_GPT_35_corr <- cor(
  study3_model_corrs$SWLS_BERT,
  study3_model_corrs$SWLS_gpt_35,
  use = "complete.obs"
)

# Correlations between GPT-3.5 and GPT-4
Study3_Autonomy_GPT_35_GPT_4_corr <- cor(
  study3_model_corrs$Autonomy_gpt_35,
  study3_model_corrs$Autonomy_gpt_4,
  use = "complete.obs"
)

Study3_SWLS_GPT_35_GPT_4_corr <- cor(
  study3_model_corrs$SWLS_gpt_35,
  study3_model_corrs$SWLS_gpt_4,
  use = "complete.obs"
)

cat("========================================\n")
cat("INTER-MODEL CORRELATIONS (Study 3)\n")
cat("========================================\n\n")
cat("Autonomy - BERT vs GPT-4:", round(Study3_Autonomy_BERT_GPT_4_corr, 3), "\n")
cat("SWLS - BERT vs GPT-4:", round(Study3_SWLS_BERT_GPT_4_corr, 3), "\n")
cat("Autonomy - BERT vs GPT-3.5:", round(Study3_Autonomy_BERT_GPT_35_corr, 3), "\n")
cat("SWLS - BERT vs GPT-3.5:", round(Study3_SWLS_BERT_GPT_35_corr, 3), "\n")
cat("Autonomy - GPT-3.5 vs GPT-4:", round(Study3_Autonomy_GPT_35_GPT_4_corr, 3), "\n")
cat("SWLS - GPT-3.5 vs GPT-4:", round(Study3_SWLS_GPT_35_GPT_4_corr, 3), "\n\n")

# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

compare_independent_correlations <- function(r1, n1, r2, n2) {
  z1 <- 0.5 * log((1 + r1) / (1 - r1))
  z2 <- 0.5 * log((1 + r2) / (1 - r2))
  se_diff <- sqrt((1 / (n1 - 3)) + (1 / (n2 - 3)))
  z_stat <- (z1 - z2) / se_diff
  p_value <- 2 * pnorm(-abs(z_stat))
  ci_lower <- (z1 - z2) - 1.96 * se_diff
  ci_upper <- (z1 - z2) + 1.96 * se_diff
  
  return(data.frame(
    r1 = r1, r2 = r2, n1 = n1, n2 = n2,
    z1 = z1, z2 = z2,
    z_stat = z_stat,
    p_value = p_value,
    ci_lower = ci_lower,
    ci_upper = ci_upper,
    sig = ifelse(p_value < 0.05, "*", "")
  ))
}

compare_to_literature <- function(your_r, your_n, literature_r, literature_n) {
  z_yours <- 0.5 * log((1 + your_r) / (1 - your_r))
  z_lit <- 0.5 * log((1 + literature_r) / (1 - literature_r))
  se_diff <- sqrt((1 / (your_n - 3)) + (1 / (literature_n - 3)))
  z_stat <- (z_yours - z_lit) / se_diff
  p_value <- 2 * pnorm(-abs(z_stat))
  
  return(data.frame(
    your_r = your_r,
    literature_r = literature_r,
    difference = your_r - literature_r,
    z_stat = z_stat,
    p_value = p_value,
    interpretation = ifelse(
      p_value < 0.05,
      "Significantly different from literature",
      "Not significantly different from literature"
    )
  ))
}


# Calculate CI for independent correlations (different samples)
calc_independent_ci <- function(r1, n1, r2, n2, conf_level = 0.95) {
  # Fisher's z transformation
  z1 <- 0.5 * log((1 + r1) / (1 - r1))
  z2 <- 0.5 * log((1 + r2) / (1 - r2))
  
  # Standard error of difference
  se_diff <- sqrt((1 / (n1 - 3)) + (1 / (n2 - 3)))
  
  # Z critical value
  z_crit <- qnorm((1 + conf_level) / 2)
  
  # CI in z-space
  diff_z <- z1 - z2
  ci_lower_z <- diff_z - z_crit * se_diff
  ci_upper_z <- diff_z + z_crit * se_diff
  
  # Transform back to correlation space
  ci_lower_r <- tanh(ci_lower_z)
  ci_upper_r <- tanh(ci_upper_z)
  
  return(list(lower = ci_lower_r, upper = ci_upper_r))
}

# Calculate CI for dependent correlations WITHOUT r23 (Steiger's test)
calc_dependent_ci_no_r23 <- function(r1, r2, n, conf_level = 0.95) {
  # Fisher's z transformation
  z1 <- 0.5 * log((1 + r1) / (1 - r1))
  z2 <- 0.5 * log((1 + r2) / (1 - r2))
  
  # Standard error (simplified for non-overlapping variables)
  se_diff <- sqrt(2 / (n - 3))
  
  # Z critical value
  z_crit <- qnorm((1 + conf_level) / 2)
  
  # CI in z-space
  diff_z <- z1 - z2
  ci_lower_z <- diff_z - z_crit * se_diff
  ci_upper_z <- diff_z + z_crit * se_diff
  
  # Transform back to correlation space
  ci_lower_r <- tanh(ci_lower_z)
  ci_upper_r <- tanh(ci_upper_z)
  
  return(list(lower = ci_lower_r, upper = ci_upper_r))
}

# Calculate CI for dependent correlations WITH r23 (Williams's test)
calc_dependent_ci_with_r23 <- function(r12, r13, r23, n, conf_level = 0.95) {
  # Fisher's z transformation
  z12 <- 0.5 * log((1 + r12) / (1 - r12))
  z13 <- 0.5 * log((1 + r13) / (1 - r13))
  
  # Determinant calculation
  R_bar <- (r12 + r13) / 2
  det_R <- 1 - r12^2 - r13^2 - r23^2 + 2 * r12 * r13 * r23
  
  # Standard error with r23
  se_diff <- sqrt((2 * (1 - r23^2) * det_R) / ((n - 3) * (1 - R_bar^2)^2))
  
  # t critical value (use t-distribution for dependent correlations with r23)
  t_crit <- qt((1 + conf_level) / 2, df = n - 3)
  
  # CI in z-space
  diff_z <- z12 - z13
  ci_lower_z <- diff_z - t_crit * se_diff
  ci_upper_z <- diff_z + t_crit * se_diff
  
  # Transform back to correlation space
  ci_lower_r <- tanh(ci_lower_z)
  ci_upper_r <- tanh(ci_upper_z)
  
  return(list(lower = ci_lower_r, upper = ci_upper_r))
}

# ============================================================================
# DEFINE CORRELATION VALUES (UPDATED WITH STUDY-SPECIFIC r23)
# ============================================================================

CorKjell2022 <- 0.74 # Correlation between LBAMs for SWLS in Kjell et al. (2022)
NKjell2022 <- 608 # Sample size in Kjell et al. (2022)

# Study 1
Study1_Autonomy_Cor <- 0.36 # Correlation between BERT Autonomy and actual Autonomy in Study 1
Study1_N <- 181 # Sample size in Study 1

# Study 2
Study2_N <- 215 
Study2_Autonomy_Cor <- 0.16
Study2_SWLS_Cor <- 0.44
r_autonomy_swls_actual_study2 <- 0.26  # Correlation between actual Autonomy and SWLS in Study 2

# Study 3
Study3_N <- 285
Study3_Autonomy_Cor_BERT <- 0.41
Study3_SWLS_Cor_BERT <- 0.62
Study3_Autonomy_Cor_GPT_35 <- 0.41
Study3_SWLS_Cor_GPT_35 <- 0.71
Study3_Autonomy_Cor_GPT_4 <- 0.49
Study3_SWLS_Cor_GPT_4 <- 0.75
r_autonomy_swls_actual_study3 <- 0.15  # Correlation between actual Autonomy and SWLS in Study 3


# ============================================================================
# Study 1 COMPARISONS: Best vs Best 
# ============================================================================

cat("========================================\n")
cat("STUDY 1 COMPARISONS\n")
cat("========================================\n\n")

# 1. Compare BERT Autonomy to Literature
Study1_Autonomy_vs_Lit <- compare_to_literature(
  your_r = Study1_Autonomy_Cor,
  your_n = Study1_N,
  literature_r = CorKjell2022,
  literature_n = NKjell2022
)
cat("Study 1: BERT Autonomy vs (Kjell et al. 2022):\n")
print(Study1_Autonomy_vs_Lit)
cat("\n")



# ============================================================================
# STUDY 2 COMPARISONS 
# ============================================================================

cat("========================================\n")
cat("STUDY 2 COMPARISONS\n")
cat("========================================\n\n")

# 1. Compare BERT SWLS to Literature
Study2_SWLS_vs_Lit <- compare_to_literature(
  your_r = Study2_SWLS_Cor,
  your_n = Study2_N,
  literature_r = CorKjell2022,
  literature_n = NKjell2022
)
cat("Study 2: BERT SWLS vs (Kjell et al. 2022):\n")
print(Study2_SWLS_vs_Lit)
cat("\n")

# 2. Compare BERT Autonomy to Literature
Study2_Autonomy_vs_Lit <- compare_to_literature(
  your_r = Study2_Autonomy_Cor,
  your_n = Study2_N,
  literature_r = CorKjell2022,
  literature_n = NKjell2022
)
cat("Study 2: BERT Autonomy vs (Kjell et al. 2022):\n")
print(Study2_Autonomy_vs_Lit)
cat("\n")

# 3. Compare Autonomy vs SWLS within Study 2 (CORRECTED - dependent with r23)
study2_autonomy_vs_swls <- r.test(
  n = Study2_N,
  r12 = Study2_Autonomy_Cor,
  r34 = Study2_SWLS_Cor,
  twotailed = TRUE
)

cat("Study 2: BERT Autonomy vs BERT SWLS (Dependent correlation test with r23):\n")
print(study2_autonomy_vs_swls)
cat("\n")


# ============================================================================
# STUDY 3 COMPARISONS (CORRECTED)
# ============================================================================

cat("========================================\n")
cat("STUDY 3 COMPARISONS\n")
cat("========================================\n\n")

# 1. Compare BERT SWLS to Literature
Study3_SWLS_BERT_vs_Lit <- compare_to_literature(
  your_r = Study3_SWLS_Cor_BERT,
  your_n = Study3_N,
  literature_r = CorKjell2022,
  literature_n = NKjell2022
)
cat("Study 3: BERT SWLS vs(Kjell et al. 2022):\n")
print(Study3_SWLS_BERT_vs_Lit)
cat("\n")

# 2. Compare BERT Autonomy vs BERT SWLS (dependent - different variables, use r12 vs r34)
study3_bert_autonomy_vs_swls <- r.test(
  n = Study3_N,
  r12 = Study3_Autonomy_Cor_BERT,
  r34 = Study3_SWLS_Cor_BERT,
  twotailed = TRUE
)
cat("Study 3: BERT Autonomy vs BERT SWLS (Dependent correlation test with r23):\n")
print(study3_bert_autonomy_vs_swls)
cat("\n")


# 3. Compare BERT vs GPT-4 for Autonomy (dependent - overlapping outcome)
study3_autonomy_bert_vs_gpt4 <- r.test(
  n = Study3_N,
  r12 = Study3_Autonomy_Cor_BERT,
  r13 = Study3_Autonomy_Cor_GPT_4,
  r23 = Study3_Autonomy_BERT_GPT_4_corr,
  twotailed = TRUE
)
cat("Study 3: BERT vs GPT-4 for Autonomy (Dependent correlation test with r23):\n")
print(study3_autonomy_bert_vs_gpt4)
cat("\n")

# 4. Compare BERT vs GPT-4 for SWLS (dependent - overlapping outcome)
study3_swls_bert_vs_gpt4 <- r.test(
  n = Study3_N,
  r12 = Study3_SWLS_Cor_BERT,
  r13 = Study3_SWLS_Cor_GPT_4,
  r23 = Study3_SWLS_BERT_GPT_4_corr,
  twotailed = TRUE
)
cat("Study 3: BERT vs GPT-4 for SWLS (Dependent correlation test with r23):\n")
print(study3_swls_bert_vs_gpt4)
cat("\n")

# 5. Compare BERT vs GPT-3.5 for Autonomy
study3_autonomy_bert_vs_gpt35 <- r.test(
  n = Study3_N,
  r12 = Study3_Autonomy_Cor_BERT,
  r13 = Study3_Autonomy_Cor_GPT_35,
  r23 = Study3_Autonomy_BERT_GPT_35_corr,
  twotailed = TRUE
)
cat("Study 3: BERT vs GPT-3.5 for Autonomy (Dependent correlation test with r23):\n")
print(study3_autonomy_bert_vs_gpt35)
cat("\n")

# 6. Compare BERT vs GPT-3.5 for SWLS
study3_swls_bert_vs_gpt35 <- r.test(
  n = Study3_N,
  r12 = Study3_SWLS_Cor_BERT,
  r13 = Study3_SWLS_Cor_GPT_35,
  r23 = Study3_SWLS_BERT_GPT_35_corr,
  twotailed = TRUE
)
cat("Study 3: BERT vs GPT-3.5 for SWLS (Dependent correlation test with r23):\n")
print(study3_swls_bert_vs_gpt35)
cat("\n")

# 7. Compare GPT-3.5 vs GPT-4 for SWLS (UPDATED - now uses r23)
study3_swls_gpt35_vs_gpt4 <- r.test(
  n = Study3_N,
  r12 = Study3_SWLS_Cor_GPT_35,
  r13 = Study3_SWLS_Cor_GPT_4,
  r23 = Study3_SWLS_GPT_35_GPT_4_corr,
  twotailed = TRUE
)
cat("Study 3: GPT-3.5 vs GPT-4 for SWLS (Dependent correlation test with r23):\n")
print(study3_swls_gpt35_vs_gpt4)
cat("\n")

# 8. Compare GPT-3.5 vs GPT-4 for Autonomy (UPDATED - now uses r23)
study3_autonomy_gpt35_vs_gpt4 <- r.test(
  n = Study3_N,
  r12 = Study3_Autonomy_Cor_GPT_35,
  r13 = Study3_Autonomy_Cor_GPT_4,
  r23 = Study3_Autonomy_GPT_35_GPT_4_corr,
  twotailed = TRUE
)
cat("Study 3: GPT-3.5 vs GPT-4 for Autonomy (Dependent correlation test with r23):\n")
print(study3_autonomy_gpt35_vs_gpt4)
cat("\n")

# 9. Compare GPT-3.5 Autonomy vs GPT-3.5 SWLS (same model, different outcomes - different variables)
study3_gpt35_autonomy_vs_swls <- r.test(
  n = Study3_N,
  r12 = Study3_Autonomy_Cor_GPT_35,
  r34 = Study3_SWLS_Cor_GPT_35,
  twotailed = TRUE
)
cat("Study 3: GPT-3.5 Autonomy vs GPT-3.5 SWLS (Dependent correlation test - Z-test):\n")
print(study3_gpt35_autonomy_vs_swls)
cat("\n")

# 10. Compare GPT-4 Autonomy vs GPT-4 SWLS (same model, different outcomes - different variables)
study3_gpt4_autonomy_vs_swls <- r.test(
  n = Study3_N,
  r12 = Study3_Autonomy_Cor_GPT_4,
  r34 = Study3_SWLS_Cor_GPT_4,
  twotailed = TRUE
)
cat("Study 3: GPT-4 Autonomy vs GPT-4 SWLS (Dependent correlation test - Z-test):\n")
print(study3_gpt4_autonomy_vs_swls)
cat("\n")

# ============================================================================
# CALCULATE ALL CIs (UPDATED WITH STUDY 1 AND STUDY 2 AUTONOMY)
# ============================================================================

# Study 1
ci_study1_auto_lit <- calc_independent_ci(Study1_Autonomy_Cor, Study1_N, CorKjell2022, NKjell2022)

# Study 2
ci_study2_swls_lit <- calc_independent_ci(Study2_SWLS_Cor, Study2_N, CorKjell2022, NKjell2022)
ci_study2_auto_lit <- calc_independent_ci(Study2_Autonomy_Cor, Study2_N, CorKjell2022, NKjell2022)
ci_study2_auto_swls <- calc_dependent_ci_no_r23(Study2_Autonomy_Cor, Study2_SWLS_Cor, Study2_N)

# Study 3
ci_study3_swls_lit <- calc_independent_ci(Study3_SWLS_Cor_BERT, Study3_N, CorKjell2022, NKjell2022)
ci_study3_auto_swls <- calc_dependent_ci_no_r23(Study3_Autonomy_Cor_BERT, Study3_SWLS_Cor_BERT, Study3_N)
ci_study3_auto_bert_gpt4 <- calc_dependent_ci_with_r23(Study3_Autonomy_Cor_BERT, Study3_Autonomy_Cor_GPT_4, Study3_Autonomy_BERT_GPT_4_corr, Study3_N)
ci_study3_swls_bert_gpt4 <- calc_dependent_ci_with_r23(Study3_SWLS_Cor_BERT, Study3_SWLS_Cor_GPT_4, Study3_SWLS_BERT_GPT_4_corr, Study3_N)
ci_study3_auto_bert_gpt35 <- calc_dependent_ci_with_r23(Study3_Autonomy_Cor_BERT, Study3_Autonomy_Cor_GPT_35, Study3_Autonomy_BERT_GPT_35_corr, Study3_N)
ci_study3_swls_bert_gpt35 <- calc_dependent_ci_with_r23(Study3_SWLS_Cor_BERT, Study3_SWLS_Cor_GPT_35, Study3_SWLS_BERT_GPT_35_corr, Study3_N)
ci_study3_swls_gpt35_gpt4 <- calc_dependent_ci_with_r23(Study3_SWLS_Cor_GPT_35, Study3_SWLS_Cor_GPT_4, Study3_SWLS_GPT_35_GPT_4_corr, Study3_N)
ci_study3_auto_gpt35_gpt4 <- calc_dependent_ci_with_r23(Study3_Autonomy_Cor_GPT_35, Study3_Autonomy_Cor_GPT_4, Study3_Autonomy_GPT_35_GPT_4_corr, Study3_N)
ci_study3_gpt35_auto_swls <- calc_dependent_ci_no_r23(Study3_Autonomy_Cor_GPT_35, Study3_SWLS_Cor_GPT_35, Study3_N)
ci_study3_gpt4_auto_swls <- calc_dependent_ci_no_r23(Study3_Autonomy_Cor_GPT_4, Study3_SWLS_Cor_GPT_4, Study3_N)

# ============================================================================
# CREATE SUMMARY TABLE WITH CORRECTED TEST TYPES (INCLUDING STUDY 1 & STUDY 2 AUTONOMY)
# ============================================================================

comparison_summary <- data.frame(
  Study = c(
    "Study 1",
    "Study 2", "Study 2", "Study 2",
    "Study 3", "Study 3", "Study 3", "Study 3", 
    "Study 3", "Study 3", "Study 3", "Study 3",
    "Study 3", "Study 3"
  ),
  Comparison = c(
    "BERT Autonomy vs Kjell et al. 2022",
    "BERT SWLS vs Kjell et al. 2022",
    "BERT Autonomy vs Kjell et al. 2022",
    "BERT Autonomy vs BERT SWLS",
    "BERT SWLS vs Kjell et al. 2022",
    "BERT Autonomy vs BERT SWLS",
    "BERT vs GPT-4 (Autonomy)",
    "BERT vs GPT-4 (SWLS)",
    "BERT vs GPT-3.5 (Autonomy)",
    "BERT vs GPT-3.5 (SWLS)",
    "GPT-3.5 vs GPT-4 (SWLS)",
    "GPT-3.5 vs GPT-4 (Autonomy)",
    "GPT-3.5 Autonomy vs GPT-3.5 SWLS",
    "GPT-4 Autonomy vs GPT-4 SWLS"
  ),
  Test_Type = c(
    "Independent (Z-test)",
    "Independent (Z-test)",
    "Independent (Z-test)",
    "Dependent (Z-test)",
    "Independent (Z-test)",
    "Dependent (Z-test)",
    "Dependent (t-test)",
    "Dependent (t-test)",
    "Dependent (t-test)",
    "Dependent (t-test)",
    "Dependent (t-test)",
    "Dependent (t-test)",
    "Dependent (Z-test)",
    "Dependent (Z-test)"
  ),
  Test_Description = c(
    "Two independent correlations",
    "Two independent correlations",
    "Two independent correlations",
    "Two dependent correlations with different variables (Steiger)",
    "Two independent correlations",
    "Two dependent correlations with different variables (Steiger)",
    "Two dependent correlations sharing one variable (Williams)",
    "Two dependent correlations sharing one variable (Williams)",
    "Two dependent correlations sharing one variable (Williams)",
    "Two dependent correlations sharing one variable (Williams)",
    "Two dependent correlations sharing one variable (Williams)",
    "Two dependent correlations sharing one variable (Williams)",
    "Two dependent correlations with different variables (Steiger)",
    "Two dependent correlations with different variables (Steiger)"
  ),
  r1 = c(
    Study1_Autonomy_Cor,
    Study2_SWLS_Cor, Study2_Autonomy_Cor, Study2_Autonomy_Cor,
    Study3_SWLS_Cor_BERT, Study3_Autonomy_Cor_BERT,
    Study3_Autonomy_Cor_BERT, Study3_SWLS_Cor_BERT,
    Study3_Autonomy_Cor_BERT, Study3_SWLS_Cor_BERT,
    Study3_SWLS_Cor_GPT_35, Study3_Autonomy_Cor_GPT_35,
    Study3_Autonomy_Cor_GPT_35, Study3_Autonomy_Cor_GPT_4
  ),
  r2 = c(
    CorKjell2022,
    CorKjell2022, CorKjell2022, Study2_SWLS_Cor,
    CorKjell2022, Study3_SWLS_Cor_BERT,
    Study3_Autonomy_Cor_GPT_4, Study3_SWLS_Cor_GPT_4,
    Study3_Autonomy_Cor_GPT_35, Study3_SWLS_Cor_GPT_35,
    Study3_SWLS_Cor_GPT_4, Study3_Autonomy_Cor_GPT_4,
    Study3_SWLS_Cor_GPT_35, Study3_SWLS_Cor_GPT_4
  ),
  r23 = c(
    NA,
    NA, NA, NA,
    NA, NA,
    Study3_Autonomy_BERT_GPT_4_corr, Study3_SWLS_BERT_GPT_4_corr,
    Study3_Autonomy_BERT_GPT_35_corr, Study3_SWLS_BERT_GPT_35_corr,
    Study3_SWLS_GPT_35_GPT_4_corr, Study3_Autonomy_GPT_35_GPT_4_corr,
    NA, NA
  ),
  Statistic = c(
    as.numeric(Study1_Autonomy_vs_Lit$z_stat)[1],
    as.numeric(Study2_SWLS_vs_Lit$z_stat)[1],
    as.numeric(Study2_Autonomy_vs_Lit$z_stat)[1],
    as.numeric(study2_autonomy_vs_swls$z)[1],
    as.numeric(Study3_SWLS_BERT_vs_Lit$z_stat)[1],
    as.numeric(study3_bert_autonomy_vs_swls$z)[1],
    as.numeric(study3_autonomy_bert_vs_gpt4$t)[1],
    as.numeric(study3_swls_bert_vs_gpt4$t)[1],
    as.numeric(study3_autonomy_bert_vs_gpt35$t)[1],
    as.numeric(study3_swls_bert_vs_gpt35$t)[1],
    as.numeric(study3_swls_gpt35_vs_gpt4$t)[1],
    as.numeric(study3_autonomy_gpt35_vs_gpt4$t)[1],
    as.numeric(study3_gpt35_autonomy_vs_swls$z)[1],
    as.numeric(study3_gpt4_autonomy_vs_swls$z)[1]
  ),
  p_value = c(
    as.numeric(Study1_Autonomy_vs_Lit$p_value)[1],
    as.numeric(Study2_SWLS_vs_Lit$p_value)[1],
    as.numeric(Study2_Autonomy_vs_Lit$p_value)[1],
    as.numeric(study2_autonomy_vs_swls$p)[1],
    as.numeric(Study3_SWLS_BERT_vs_Lit$p_value)[1],
    as.numeric(study3_bert_autonomy_vs_swls$p)[1],
    as.numeric(study3_autonomy_bert_vs_gpt4$p)[1],
    as.numeric(study3_swls_bert_vs_gpt4$p)[1],
    as.numeric(study3_autonomy_bert_vs_gpt35$p)[1],
    as.numeric(study3_swls_bert_vs_gpt35$p)[1],
    as.numeric(study3_swls_gpt35_vs_gpt4$p)[1],
    as.numeric(study3_autonomy_gpt35_vs_gpt4$p)[1],
    as.numeric(study3_gpt35_autonomy_vs_swls$p)[1],
    as.numeric(study3_gpt4_autonomy_vs_swls$p)[1]
  ),
  CI_lower = c(
    ci_study1_auto_lit$lower,
    ci_study2_swls_lit$lower,
    ci_study2_auto_lit$lower,
    ci_study2_auto_swls$lower,
    ci_study3_swls_lit$lower,
    ci_study3_auto_swls$lower,
    ci_study3_auto_bert_gpt4$lower,
    ci_study3_swls_bert_gpt4$lower,
    ci_study3_auto_bert_gpt35$lower,
    ci_study3_swls_bert_gpt35$lower,
    ci_study3_swls_gpt35_gpt4$lower,
    ci_study3_auto_gpt35_gpt4$lower,
    ci_study3_gpt35_auto_swls$lower,
    ci_study3_gpt4_auto_swls$lower
  ),
  CI_upper = c(
    ci_study1_auto_lit$upper,
    ci_study2_swls_lit$upper,
    ci_study2_auto_lit$upper,
    ci_study2_auto_swls$upper,
    ci_study3_swls_lit$upper,
    ci_study3_auto_swls$upper,
    ci_study3_auto_bert_gpt4$upper,
    ci_study3_swls_bert_gpt4$upper,
    ci_study3_auto_bert_gpt35$upper,
    ci_study3_swls_bert_gpt35$upper,
    ci_study3_swls_gpt35_gpt4$upper,
    ci_study3_auto_gpt35_gpt4$upper,
    ci_study3_gpt35_auto_swls$upper,
    ci_study3_gpt4_auto_swls$upper
  ),
  stringsAsFactors = FALSE
) %>%
  mutate(
    # Round statistic and p_value to 3 decimals
    Statistic = round(Statistic, 3),
    p_value = round(p_value, 3),
    sig = case_when(
      p_value < 0.001 ~ "***",
      p_value < 0.01 ~ "**",
      p_value < 0.05 ~ "*",
      TRUE ~ ""
    ),
    CI_95 = sprintf("[%.3f, %.3f]", CI_lower, CI_upper)
  ) %>%
  select(Study, Comparison, Test_Type, Test_Description, r1, r2, r23, Statistic, p_value, sig, CI_95)

cat("\n========================================\n")
cat("SUMMARY TABLE WITH TEST TYPES & DESCRIPTIONS\n")
cat("========================================\n\n")
print(comparison_summary, row.names = FALSE)