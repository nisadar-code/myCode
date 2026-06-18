############## Independent Two sample T Test
# Load required libraries
library(readxl) # you don't need to run this line each time. once is enough

# Read the data from Excel file
data <- read_excel("independent-ttest-golfscores.xlsx")

# Extract the columns of interest
scores <- data$Score
gender <- data$Gender

# Split the scores by gender
scores_male <- scores[gender == "m"]
scores_female <- scores[gender == "f"]

# Print out the lengths of both groups
print(length(scores_male))
print(length(scores_female))

# Check if both groups have enough observations
if (length(scores_male) < 2 || length(scores_female) < 2) {
  print("Error: Not enough observations in one or both groups.")
} else {
  # Perform the F test for equality of variances
  result_ftest <- var.test(scores ~ gender, data = data)
  print(result_ftest)
  
  # Check for equality of variances
  if (result_ftest$p.value <= 0.05) {
    # If p-value is less than or equal to 0.05, variances are not equal
    cat("Variances are not equal based on F test.\n")
    # Perform Welch's t-test
    result_ttest <- t.test(scores_male, scores_female, var.equal = FALSE)
  } else {
    # If p-value is greater than 0.05, variances are assumed equal
    cat("Variances are equal based on F test.\n")
    # Perform independent two-sample t-test
    result_ttest <- t.test(scores_male, scores_female) # switch the order of both the scores i.e. t.test(scores_female, scores_male) and see the effect on t-score
  }
  
  # Print the result of the t-test
  print(result_ttest)
}
