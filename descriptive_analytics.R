### load datasets

# option 1
dat <- iris
# option 2
data <- read.csv("iris.csv")

data <- dat

### summary stats
install.packages("pastecs")
library(pastecs)

stat.desc(dat)

# group by species
by(dat, dat$Species, stat.desc)

####### Create scatter plot

# Load the required library
install.packages("ggplot2")
library(ggplot2)
data <- dat
ggplot(data, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point() +
  labs(x = "Sepal Length", y = "Sepal Width", color = "Species") +
  theme_minimal() +
  # Set the same axis scaling for all plots
  coord_fixed()


### correlations

install.packages("dplyr")
# Load the required library
library(dplyr)


# Compute Pearson correlation grouped by species
pearson_corr <- data %>%
  group_by(Species) %>%
  summarise(pearson_correlation = cor(Sepal.Length, Sepal.Width, method = "pearson"))

# Compute Spearman correlation grouped by species
spearman_corr <- data %>%
  group_by(Species) %>%
  summarise(spearman_correlation = cor(Sepal.Length, Sepal.Width, method = "spearman"))

# Print the correlations
print(pearson_corr)
print(spearman_corr)
