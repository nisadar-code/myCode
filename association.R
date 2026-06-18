# Install necessary packages if not already installed
if(!require(readxl)) install.packages("readxl", dependencies=TRUE)
if(!require(arules)) install.packages("arules", dependencies=TRUE)

# Load the necessary libraries
library(readxl)
library(arules)

# Load the dataset from the Excel file
file_path <- "Groceries_dataset.xlsx"
groceries_data <- read_excel(file_path)

# Inspect the first few rows of the dataset
head(groceries_data)

# Convert the data into transactions format
# We need to create a list of transactions, where each transaction is a set of items
groceries_list <- split(groceries_data$itemDescription, groceries_data$Member_number)

# Convert the list to a transactions object
transactions <- as(groceries_list, "transactions")

# Generate the association rules
# Here we set a minimum confidence of 0.2 (20%)
rules <- apriori(transactions, parameter = list(supp = 0.01, conf = 0.2, target = "rules"))

# Inspect the rules
inspect(rules)

# Sort rules by lift and inspect the top 5 rules
rules_sorted <- sort(rules, by = "lift")
inspect(rules_sorted[1:5])

# Visualize the rules (optional)
if(!require(arulesViz)) install.packages("arulesViz", dependencies=TRUE)
library(arulesViz)

# Plot the rules
plot(rules_sorted, method = "graph", control = list(type = "items"))

# Visualize the top 10 rules sorted by lift
# Change 'max' parameter to limit the number of rules plotted
plot(rules_sorted, method = "graph", control = list(type = "items", max = 10))

