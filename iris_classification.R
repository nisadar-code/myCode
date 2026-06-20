Sys.setenv(http_proxy="http://vdi-proxy.its.sfu.ca:8080")
Sys.setenv(https_proxy="http://vdi-proxy.its.sfu.ca:8080")

install.packages("party")

library(party)

#set seed by specifying arbitrary numbers as 1234 to reproduce the same results next time you do this part.

set.seed(1234)

View(iris) #view dataset

# now classify your dataset into training and testing data: 70% for training  and 30% for testing

ind <- sample(2, nrow(iris), replace = TRUE, prob = c(0.70, 0.30))
train.data <- iris[ind==1,] #where row is marked by 1
test.data <- iris[ind==2,] #where row is marked by 2

# let's create a model for dependent variable "Species" and independent variables
myf <- Species ~ Sepal.Length+Sepal.Width+Petal.Length+Petal.Width

# now create a classification tree for this model
iris_ctree <- ctree(myf, data=train.data)

#let's check how accurate it is 
table(predict(iris_ctree), train.data$Species) # Output: rows = actual, columns = predicted

#visualize it
plot(iris_ctree)

#use this tree on rest of 30% of validation data to see how well it is
testpred <- predict(iris_ctree, newdata=test.data)

table(testpred, test.data$Species)


