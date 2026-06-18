#The purpose of this script is to construct linear regression models with two or more explanatory variables. 

########## Explanatory Regression Modelling ################
############################################################

#Create a Kitchen sink model

library(tidyverse) # library to use
Con <- read_csv("ConcreteStrength_numeric.csv") # read the input data file

## You can rename columns by using the following piece of code to make them easier to use in R

Con <- Con %>% dplyr::rename(Strength = "Compressive Strength (28-day)(Mpa)",
                             FlyAsh = "Fly ash",
                             CoarseAgg = "Coarse Aggr.",
                             FineAgg = "Fine Aggr.",
                             AirEntrain = "Air Entrainment")

view(Con) # check the output of renaming columns


#Correlation matrix

cor(Con %>% dplyr::select_if(is.numeric)) %>% round(2)


# create a multiple linear regression model that includes all the explanatory variables  (kitchen sink model)

model.ks <- lm(Strength ~ No + Cement + Slag + Water + CoarseAgg + FlyAsh + SP + FineAgg + AirEntrain, data=Con)

# check your model
summary(model.ks)



########## Predictive Regression Modelling ################
############################################################

###### Model refinement

# Manual stepwise refinement
# We can manually remove explanatory variables one-by-one (starting from the variable with the highest p-value) until we have a model in which all the explanatory variables are significant. In model.ks, we can start by removing fine aggregates 

# Automated stepwise refinement
# By default the step function uses a bi-directional AIC-based heuristic (that is, it removes and adds variables based on values of the Akaike information criterion). Conceptually it is similar to the Mallows Cp selection of SAS. Please note that different algorithms may yield slightly different final models.

# use step function for stepwise model refinement of the kitchen sink model generated above
model.step <- step(model.ks)

# view your model
model.step 

#Let's examine the residuals and overall fit for the refined model:

hist(resid(model.step)) # plot a histogram of the residuals of the refined model

boxplot(resid(model.step), horizontal=TRUE) # plot a boxplot of the residuals of the refined model

# Plot observed vs predicted values of the target 

plot(fitted(model.step), Con$Strength, xlab="predicted value", ylab="observed value")
abline(0, 1)

# Generate the standardized regression coefficients

# The following two lines are required only if you are installing a package through VDI desktop 
#Sys.setenv(http_proxy="http://vdi-proxy.its.sfu.ca:8080")
#Sys.setenv(https_proxy="http://vdi-proxy.its.sfu.ca:8080")

# Another way to install a package if you are not using the VDI desktop
#install.packages("https://cran.r-project.org/web/packages/lm.beta/lm.beta_1.7-2.tar.gz", repos=NULL)

# You may also install a package by using the following
install.packages("lm.beta")


# Load the required library
library(lm.beta)

# generate standardized coefficients of the refined model

model.std <- lm.beta(model.step)

# view the standardized coefficients
model.std  

