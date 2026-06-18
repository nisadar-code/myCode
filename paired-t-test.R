############### Two sample Paired T Test

# Load required library
library(readxl)

# Read the data from Excel file
data <- read_excel("paired_ttest_pressure_data.xlsx")

# Extract the columns of interest
sbp_before <- data$SBPBefore
sbp_after <- data$SBPAfter

# Perform paired t-test
result <- t.test(sbp_before, sbp_after, paired = TRUE)

# Print the result
print(result)


