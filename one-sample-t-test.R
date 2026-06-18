##############  ONE Sample T Test

# Load required library
library(readxl)

# Read the data from Excel file
data <- read_excel("one_sample_ttest_data.xlsx")

# Extract the column of interest (assuming the column name is "Age")
sample_data <- data$Age

# Perform one-sample t-test
result <- t.test(sample_data, mu = 50)  # Null hypothesis: mean age is equal to 50

# Print the result
print(result)

