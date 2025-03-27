all: Study1 Study2 Study3

# Study 1 Analyses
Study1: Study1-main Study1-pre-item Study1-post-subscale

Study1-main:
	Rscript -e "rmarkdown::render('Study1/Study1-subscale-prediction.Rmd')"
	
Study1-SI: Study1-post-subscale Study1-pre-itemS tudy1-post-item

Study1-post-subscale: 
	Rscript -e "rmarkdown::render('Study1/Study1-Post-subscale.Rmd')" # post subscale predictions [needs to be updated ATM]

Study1-pre-item:
	Rscript -e "rmarkdown::render('Study1/Study1-item-level-prediction.Rmd')"

Study1-post-item:
	Rscript -e "rmarkdown::render('Study1/Study1-post-item-level-prediction.Rmd')"


# Study 2 Analyses
Study2: Study2-main Study2-SI

Study2-main:
	Rscript -e "rmarkdown::render('Study2/Study2-Wellbeing-Prediction-Subscale.Rmd')"
	
Study2-SI: Study2-compare-methods Study2-bootstrapping

Study2-compare-methods:
	Rscript -e "rmarkdown::render('Study2/Study2_comparing-methods.Rmd')"
	
Study2-bootstrapping: 
	Rscript -e "rmarkdown::render('Study2/Study2-bootstrapping.Rmd')"
	
Study3: Study3-main

Study3-main: 
	Rscript -e "rmarkdown::render('Study3/Study3-WBP.Rmd')"
	

