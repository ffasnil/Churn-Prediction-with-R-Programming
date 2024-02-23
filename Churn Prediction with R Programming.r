# -*- coding: utf-8 -*-

# -- Sheet --

# import library
library("tidyverse")

# # Exploratory Data Analysis (EDA)
# Explore the dataset using the **glimpse** function and create informative visualizations with **ggplot2**


# Read csv file and save in 'churndata' variable
churndata <- read.csv("churn.csv")

# Create a function for showing basic information
df_info <- function(df, sample_size = 5) {
  cat("Data Frame Information:\n")
  cat("Number of Rows: ", nrow(df), "\n")
  cat("Number of Columns: ", ncol(df), "\n\n")
  
  cat("Column Information:\n")
  for (col in names(df)) {
    cat(sprintf("Column: %s | Type: %s | Non-null Count: %d | Sample: %s\n", 
                col, class(df[[col]]), sum(!is.na(df[[col]])), toString(head(df[[col]], sample_size))))
  }
  
  cat("\nSummary Statistics:\n")
  print(summary(df))
  
  cat("\nMissing Values (NA or NULL):\n")
  print(sapply(df, function(x) sum(is.na(x) | x == "")))
}

# Apply df_info function on chur
df_info(churndata)

# Convert variables (character) to factor
churndata$churn <- factor(churndata$churn)
churndata$voicemailplan <- factor(churndata$voicemailplan)
churndata$internationalplan <- factor(churndata$internationalplan)
# Show summary after converting variables
glimpse(churndata)

# explore graph
ggplot(churndata, aes(churn,totalintlcharge)) + geom_jitter(color = "dodgerblue")
ggplot(churndata, aes(churn,totalevecharge)) + geom_jitter(color = "dodgerblue")
ggplot(churndata, aes(churn,totalintlminutes)) + geom_jitter(color = "dodgerblue")
ggplot(churndata, aes(churn,accountlength)) + geom_jitter(color = "dodgerblue")
ggplot(churndata, aes(churn,internationalplan)) + geom_jitter(color = "dodgerblue")
ggplot(churndata, aes(churn,voicemailplan)) + geom_jitter(color = "dodgerblue")

# # Modelling


# ### - Split the dataset into training and testing sets to facilitate model evaluation


n <- nrow(churndata)     # calculate no. rows
id <- sample(1:n, size = n*0.8)     # random sample (size 80%) from 1 to n
train_data <- churndata[id, ]    # select data from id (random sample) for training
test_data <- churndata[-id, ]    # select data excluding a random sample for testing

# Show summary
glimpse(churndata)

# quick survey the train_data
head(train_data)

# quick survey the test_data
head(test_data)

# ### - Fit a Logistic Regression model to the training dataset and evaluate its performance


## train model
logistic_model <- glm(churn ~ ., data = train_data, family = "binomial")
p_train <- predict(logistic_model, type = "response")
train_data$pred <- if_else(p_train >=0.5, "Yes", "No")
train_m <- table(train_data$pred, train_data$churn, dnn = c("predicted", "actual"))
cat("Accuracy of Train Model: ", (train_m[1,1] + train_m[2,2]) / sum(train_m))
cat("\nPrecission of Train Model: ", train_m[2,2] / (train_m[2,1] + train_m[2,2]))
cat("\nRecall of Train Model: ", train_m[2,2]/ (train_m[1,2] + train_m[2,2]))
cat("\nF1 of Train Model: ", 2* (0.58*0.21)/(0.58+0.21))

# ### - Apply the trained logistic regression model to the testing dataset and assess its performance


# test model
p_test <- predict(logistic_model, newdata = test_data, type = "response")
test_data$pred <- if_else(p_test >= 0.5, "Yes", "No")
test_m <- table(test_data$churn, test_data$pred, dnn = c("predicted", "actual"))
cat("Accuracy of Test Model: ", (test_m[1,1] + test_m[2,2]) / sum(test_m))
cat("\nPrecission of Test Model: ", test_m[2,2] / (test_m[2,1] + test_m[2,2]))
cat("\nRecall of Test Model: ", test_m[2,2]/ (test_m[1,2] + test_m[2,2]))
cat("\nF1 of Test Model: ", 2* (0.22*0.55)/(0.22+0.55))

# # K-Means Clustering


real_churn <- churndata$churn        # Create new variable by selecting only churn column (contains 'yes' and 'no')
churn_df <- churndata %>% 
  as_tibble() %>%                    # Create dataframe (tibble)
  select(-churn, -internationalplan, -voicemailplan)      # Select churndata exclude churn column
# Show summary
glimpse(churn_df)

# K-means Clustering
set.seed(42)                                 # Set the seed for the random number generator
km_model <- kmeans(churn_df, centers = 2)    # Create 2 clusters
km_model$size                                # Size of clusters
Clusters <- km_model$cluster
table(Clusters,real_churn)

ggplot(churndata, aes(totalnightcharge,churn, col = churn)) + geom_jitter()
ggplot(churndata, aes(totalevecalls,churn, col = churn)) + geom_jitter()
ggplot(churndata, aes(totaldaycalls,churn, col = churn)) + geom_jitter()
ggplot(churndata, aes(accountlength,churn, col = churn)) + geom_jitter()
ggplot(churndata, aes(totalintlcharge,churn, col = churn)) + geom_jitter()

