# Install necessary libraries if not already installed

install.packages("ggplot2")
install.packages("cluster")

# Load libraries
library(ggplot2)
library(cluster)



# Load the dataset
housing_data <- read.csv("californiahousing.csv")

# View the first few rows of the dataset
head(housing_data)


# Select relevant features
housing_data <- housing_data[, c("longitude", "latitude", "housing_median_age", "total_rooms", "total_bedrooms", "population", "households", "median_income", "median_house_value")]

# Handle missing values
housing_data$total_bedrooms[is.na(housing_data$total_bedrooms)] <- median(housing_data$total_bedrooms, na.rm = TRUE)

# Normalize the data
housing_data_scaled <- scale(housing_data)


# Set seed for reproducibility
set.seed(42)

# Calculate total within-cluster sum of squares for different values of k
wcss <- vector()
for (k in 1:15) {
  kmeans_result <- kmeans(housing_data_scaled, centers = k, nstart = 25)
  wcss[k] <- kmeans_result$tot.withinss
}

# Plot the elbow method
plot(1:15, wcss, type = "b", pch = 19, frame = FALSE, 
     xlab = "Number of clusters K", ylab = "Total within-clusters sum of squares")
title("Elbow Method for Determining Optimal Number of Clusters")


# Perform k-means clustering with optimal number of clusters
optimal_k <- 4
kmeans_result <- kmeans(housing_data_scaled, centers = optimal_k, nstart = 25)

# Print the results
print(kmeans_result)

# Add cluster assignments to the original data
housing_data$cluster <- kmeans_result$cluster

# View the first few rows with cluster assignments
head(housing_data)


# Visualize the clusters
ggplot2::ggplot(housing_data, aes(x = median_income, y = median_house_value, color = as.factor(cluster))) +
  geom_point(alpha = 0.5) +
  scale_color_discrete(name = "Cluster") +
  labs(title = "K-Means Clustering of California Housing Data", x = "Income", y = "House Value") +
  theme_minimal()


# Visualize the clusters
ggplot2::ggplot(housing_data, aes(x = longitude, y = latitude, color = as.factor(cluster))) +
  geom_point(alpha = 0.5) +
  scale_color_discrete(name = "Cluster") +
  labs(title = "K-Means Clustering of California Housing Data", x = "longitude", y = "latitude") +
  theme_minimal()



