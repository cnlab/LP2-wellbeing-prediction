# Predicting Psychological and Subjective Well-being through Language-based Assessment.

This repository contains code for the analyses reported in the following manuscript: **Predicting Psychological and Subjective Well-being through Language-based Assessment.**

## Analysis reproduction

To reproduce the analyses in the manuscript, execute the the analysis scripts in the given Study [i] folder. Given that raw data text is required to generate the word embeddings, folks outside the research team will only be able to reproduce the main analyses. Alternatively, you can download the compiled ML models from the [OSF](https://osf.io/phguw/?view_only=f87fcacdf75e4eb29aaa9792c98623b7) site and run them locally.

## Directory structure

-   `Study1` = R code for the analyses reported in Study1
-   `Study2` = R code for the analyses reported in Study2
-   `Study2` = R code for the analyses reported in Study2
-   `data` = csv files containing the data for all studies

```         
├── Study1
│   ├── LP2 Subscale-level Visualization.Rmd
│   ├── LP2-embeddings-bert-large-uncased.R
│   ├── Study1-Post-subscale.Rmd
│   ├── Study1-item-level-prediction.Rmd
│   ├── Study1-post-item-level-prediction.Rmd
│   ├── Study1-subscale-prediction.Rmd
│   ├── TESTING_Study1_Post_Embeddings.R
│   └── subscale-prediction-code-post
│       ├── Accept-subscale-prediction.R
│       ├── Autonomy-Cross-Subscale.R
│       ├── Cleaning-Phonic-Data.R
│       ├── Growth-Cross-Subscale.R
│       ├── Pos-Affect-Cross-Subscale.R
│       ├── Purpose_Subscale_Prediction.R
│       ├── Relations-cross-subscale.R
│       └── post-subscale-prediction.Rmd
├── Study2
│   ├── Cleaning
│   │   └── LP2-Wellbeing-Prediction-Cleaning.Rmd
│   ├── Study2-Wellbeing-Prediction-Subscale.Rmd
│   ├── Study2_comparing-methods.Rmd
│   ├── bootstrapping-markdown.Rmd
│   ├── comparing-methods.Rmd
│   └── text-wb-harmassessment.Rmd
├── Study3
│   ├── Cleaning
│   │   └── Study-3-WBP-Cleaning.Rmd
│   ├── Study-3-WBP-Cleaning.Rmd
│   ├── Study3-WBP.Rmd
│   └── WBP-Study-3-Embeddings.R
├── Supplemental-Info
│   ├── Study-1
│   │   └── Study-1-LIWC-Vars.Rmd
│   └── subscale-prediction-code
│       ├── Accept-subscale-prediction.R
│       ├── Autonomy-Cross-Subscale.R
│       ├── Cleaning-Phonic-Data.R
│       ├── Growth-Cross-Subscale.R
│       ├── Pos-Affect-Cross-Subscale.R
│       ├── Purpose_Subscale_Prediction.R
│       ├── Relations-cross-subscale.R
│       └── subscale-prediction.Rmd
└── data
    ├── WBP_Study1_Cleaned.csv
    ├── WBP_Study2_Behavioral_Cleaned.csv
    ├── WBP_Study2_Text_cleaned.csv
    ├── WBP_Study2_items.csv
    ├── WBP_Study3_Behavioral_Cleaned.csv
    └── WBP_Study3_Behavioral_Cleaned_items.csv
```
