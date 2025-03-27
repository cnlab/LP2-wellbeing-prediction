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
-   Errors in R Markdown rendering? Check the error messages in the console and ensure all required R packages are installed.

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
