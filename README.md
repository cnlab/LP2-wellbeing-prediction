# Predicting Psychological and Subjective Well-being through Language-based Assessment.

This repository contains code for the analyses reported in the following manuscript: **Predicting Psychological and Subjective Well-being through Language-based Assessment.**

## Analysis reproduction

### Basic reproduction

To reproduce the analyses in the manuscript, execute the the analysis scripts in the given Study [i] folder. Given that raw data text is required to generate the word embeddings, folks outside the research team will only be able to reproduce the main analyses. Alternatively, you can download the compiled ML models from the [OSF](https://osf.io/phguw/?view_only=f87fcacdf75e4eb29aaa9792c98623b7) site and run them locally.

### Makefile reproduction (prefered)

This Makefile automates the process of running R Markdown analyses for three studies (Study1, Study2, and Study3). It allows users to execute all analyses or specific study components efficiently using `make` commands. helping to preserve reproducibility

### Requirements

-   Before using this Makefile, ensure you have:
-   R installed on your system.
-   The rmarkdown package installed (install.packages("rmarkdown")).
-   A working directory set to the location of the Makefile.
-   Ensure that you have downloaded the following folders from [OSF](https://osf.io/phguw/?view_only=f87fcacdf75e4eb29aaa9792c98623b7) and have them in the directory `/Desktop/LP2-wellbeing-prediction`

    -   `/models`
    -   `/supp`
    -   `/embeddings`

### Basic Usage

To run all studies:

-   `make all`: This executes all analyses across Study1, Study2, and Study3.
-   To run specific studies: `make Study1` `make Study2` `make Study3`
-   To run specific analyses within a study: `make Study1-Post-subscale` `make Study1-item-level-prediction` `make Study1-subscale-prediction` `make Study2-Wellbeing-Prediction-Subscale` `make Study2_comparing-methods` `make Study3-WBP`

### Notes

-   Ensure that your working directory is set correctly when executing make commands.
-   If an Rmd file is modified, rerun the corresponding make command to update the results.

### Troubleshooting

-   Command not found? Ensure you have make installed (sudo apt install make on Linux, or use Xcode Command Line Tools on macOS).
-   Makefile not found? Ensure you are in the correct directory.
-   Errors in R code? Check the error messages in the console and ensure all required R packages are installed.
-   Error: pandoc version 1.12.3 or higher is required and was not? Install pandoc with `brew install pandoc` in your terminal. 

## Directory structure

-   `Study1` = R code for the analyses reported in Study1
-   `Study2` = R code for the analyses reported in Study2
-   `Study2` = R code for the analyses reported in Study2
-   `data` = csv files containing the data for all studies

```         
├── data
│   ├── GPT
│   │   ├── WBP-Autonomy-Text-GPT-gpt-3.5-turbo-1106-0-scores.csv
│   │   ├── WBP-Autonomy-Text-GPT-gpt-4-0-scores.csv
│   │   ├── WBP-SWLS-Text-GPT-gpt-3.5-turbo-1106-0-scores.csv
│   │   └── WBP-SWLS-Text-GPT-gpt-4-0-scores.csv
│   ├── WBP_Study1_Cleaned.csv
│   ├── WBP_Study2_Behavioral_Cleaned.csv
│   ├── WBP_Study2_items.csv
│   ├── WBP_Study2_Text_cleaned.csv
│   ├── WBP_Study3_Behavioral_Cleaned_items.csv
│   └── WBP_Study3_Behavioral_Cleaned.csv
├── LP2-within.Rproj
├── Makefile
├── models
│   ├── Study1
│   │   ├── acceptance
│   │   │   ├── accept_acceptance_sub.RDS
│   │   │   ├── accept_autonomy_sub.RDS
│   │   │   ├── accept_growth_sub.RDS
│   │   │   ├── accept_mastery_sub.RDS
│   │   │   ├── accept_purpose_sub.RDS
│   │   │   ├── accept_PWB_sub.RDS
│   │   │   ├── accept_relationships_sub.RDS
│   │   │   ├── accept_SWLS_sub.RDS
│   │   │   └── acceptance_subscale_df.RDS
│   │   ├── affect
│   │   │   ├── affect_acceptance_sub.RDS
│   │   │   ├── affect_autonomy_sub.RDS
│   │   │   ├── affect_growth_sub.RDS
│   │   │   ├── affect_mastery_sub.RDS
│   │   │   ├── affect_purpose_sub.RDS
│   │   │   ├── affect_PWB_sub.RDS
│   │   │   ├── affect_relationships_sub.RDS
│   │   │   ├── affect_results.RDS
│   │   │   └── affect_SWLS_sub.RDS
│   │   ├── all_subscales.RDS
│   │   ├── autonomy
│   │   │   ├── autonomy_acceptance_sub.RDS
│   │   │   ├── autonomy_autonomy_sub.RDS
│   │   │   ├── autonomy_growth_sub.RDS
│   │   │   ├── autonomy_mastery_sub.RDS
│   │   │   ├── autonomy_purpose_sub.RDS
│   │   │   ├── autonomy_PWB_sub.RDS
│   │   │   ├── autonomy_relationships_sub.RDS
│   │   │   ├── autonomy_subscale_df.RDS
│   │   │   └── autonomy_SWLS_sub.RDS
│   │   ├── growth
│   │   │   ├── growth_acceptance_sub.RDS
│   │   │   ├── growth_autonomy_sub.RDS
│   │   │   ├── growth_growth_sub.RDS
│   │   │   ├── growth_mastery_sub.RDS
│   │   │   ├── growth_purpose_sub.RDS
│   │   │   ├── growth_PWB_sub.RDS
│   │   │   ├── growth_relationships_sub.RDS
│   │   │   ├── growth_results.RDS
│   │   │   └── growth_SWLS_sub.RDS
│   │   ├── growthgrowth_results.RDS
│   │   ├── purpose
│   │   │   ├── purpose_acceptance_sub.RDS
│   │   │   ├── purpose_autonomy_sub.RDS
│   │   │   ├── purpose_growth_sub.RDS
│   │   │   ├── purpose_mastery_sub.RDS
│   │   │   ├── purpose_purpose_sub.RDS
│   │   │   ├── purpose_PWB_sub.RDS
│   │   │   ├── purpose_relationships_sub.RDS
│   │   │   ├── purpose_results.RDS
│   │   │   ├── purpose_SWLS_sub.RDS
│   │   │   └── relations_results.RDS
│   │   └── relations
│   │       ├── relations_acceptance_sub.RDS
│   │       ├── relations_autonomy_sub.RDS
│   │       ├── relations_growth_sub.RDS
│   │       ├── relations_mastery_sub.RDS
│   │       ├── relations_purpose_sub.RDS
│   │       ├── relations_PWB_sub.RDS
│   │       ├── relations_relationships_sub.RDS
│   │       ├── relations_results.RDS
│   │       └── relations_SWLS_sub.RDS
│   ├── Study2
│   │   ├── Audio_Only_autonomy_subscale.RDS
│   │   ├── Audio_Only_SWLS_subscale.RDS
│   │   ├── Autonomy_subscale_results.RDS
│   │   ├── autonomy_subscale.RDS
│   │   ├── study2_all_effects.RDS
│   │   ├── SWLS_subscale_results.RDS
│   │   ├── SWLS_subscale.RDS
│   │   ├── Text_Only_autonomy_subscale.RDS
│   │   └── Text_Only_SWLS_subscale.RDS
│   └── Study3
│       ├── autonomy
│       │   ├── autonomy_acceptance.rds
│       │   ├── autonomy_autonomy.RDS
│       │   ├── autonomy_mastery.rds
│       │   ├── autonomy_personal_growth.rds
│       │   ├── autonomy_purpose.rds
│       │   ├── autonomy_pwb.rds
│       │   ├── autonomy_relations.rds
│       │   ├── autonomy_subscale_df.RDS
│       │   └── autonomy_swls.rds
│       ├── Autonomy_subscale_results
│       ├── Autonomy_subscale_results.RDS
│       ├── autonomy_subscale.RDS
│       ├── study3_all_effects.RDS
│       ├── SWL
│       │   ├── SWL_subscale_df.RDS
│       │   ├── swls_acceptance.rds
│       │   ├── swls_autonomy.rds
│       │   ├── swls_mastery.rds
│       │   ├── swls_personal_growth.rds
│       │   ├── swls_purpose.rds
│       │   ├── swls_pwb.rds
│       │   ├── swls_relations.rds
│       │   └── swls_swls.rds
│       ├── SWLS_subscale_results.RDS
│       └── SWLS_subscale.RDS
├── README.md
├── Study1
│   ├── LP2 Subscale-level Visualization.Rmd
│   ├── LP2-embeddings-bert-large-uncased.R
│   ├── Study1-item-level-prediction.Rmd
│   ├── Study1-post-item-level-prediction.Rmd
│   ├── Study1-Post-subscale.Rmd
│   ├── Study1-subscale-prediction.Rmd
│   ├── subscale-prediction-code-post
│   │   ├── Accept-subscale-prediction.R
│   │   ├── Autonomy-Cross-Subscale.R
│   │   ├── Cleaning-Phonic-Data.R
│   │   ├── Growth-Cross-Subscale.R
│   │   ├── Pos-Affect-Cross-Subscale.R
│   │   ├── post-subscale-prediction.Rmd
│   │   ├── Purpose_Subscale_Prediction.R
│   │   └── Relations-cross-subscale.R
│   └── TESTING_Study1_Post_Embeddings.R
├── Study2
│   ├── Cleaning
│   │   └── LP2-Wellbeing-Prediction-Cleaning.Rmd
│   ├── comparing-methods.Rmd
│   ├── Study2_comparing-methods.Rmd
│   ├── Study2-bootstrapping.Rmd
│   ├── Study2-Wellbeing-Prediction-Subscale.Rmd
│   └── text-wb-harmassessment.Rmd
├── Study3
│   ├── Cleaning
│   │   └── Study-3-WBP-Cleaning.Rmd
│   ├── Study-3-WBP-Cleaning.Rmd
│   ├── Study3-WBP.Rmd
│   └── WBP-Study-3-Embeddings.R
└── Supplemental-Info
    ├── deploy-models
    │   └── deploy-models.R
    ├── Embedding-viz
    │   ├── LIWC_Study2_3_combined_words.csv
    │   ├── Study2_3_combined_words.csv
    │   ├── study2_autonomy_autonomy_in_embedding_space.csv
    │   ├── study2_SWLS_SWLS_in_embedding_space.csv
    │   ├── study3_autonomy_autonomy_in_embedding_space.csv
    │   ├── study3_SWLS_SWLS_high_low_in_embedding_space.csv
    │   └── Word-viz.Rmd
    ├── GPT-Comparison
    │   ├── GPT-Comparison.Rmd
    │   └── WBP-GPT-Pipeline.ipynb
    ├── Study-1
    │   └── Study-1-LIWC-Vars.Rmd
    └── subscale-prediction-code
        ├── Accept-subscale-prediction.R
        ├── Autonomy-Cross-Subscale.R
        ├── Cleaning-Phonic-Data.R
        ├── Growth-Cross-Subscale.R
        ├── Pos-Affect-Cross-Subscale.R
        ├── Purpose_Subscale_Prediction.R
        ├── Relations-cross-subscale.R
        └── subscale-prediction.Rmd
```
