library(elasticnet)
library(caret)
library(tidyverse)
library(sf)
library(dplyr)
setwd("/Users/user/Desktop/DATA SCIENCE & ANALYTICS/BIG DATA AND CONSUMER ANALYTICS/Assignment")
# Load the house data
load("assign_data.RData")

assign_data %>% mutate(ID = 1:n()) %>%
  select( -Price) %>%
  st_drop_geometry() %>%
  pivot_longer(-ID) %>%
  ggplot(aes(x = value)) + geom_histogram(col = "red", fill = "salmon") +
  facet_wrap(~name, scales = "free")

# Transform 'assign_data' from an 'sf' object to a dataframe and drop geometry
model_data <- assign_data %>% st_drop_geometry() %>% as.data.frame()
model_data

# Apply log transformation to target variable 'Price' and any positively skewed predictor variables
model_data$Price <- log(model_data$Price + 1)
# Assuming 'gs_area' and 'unmplyd' might be positively skewed based on domain knowledge:
model_data$gs_area <- log(model_data$gs_area + 1)
model_data$unmplyd <- log(model_data$unmplyd + 1)
model_data$u25 <- log(model_data$u25 + 1)
model_data$o65 <- log(model_data$o65 + 1)

# Split the data into training and testing sets
set.seed(99)  # For reproducibility
trainIndex <- createDataPartition(model_data$Price, p = .8, list = FALSE)
trainData <- model_data[trainIndex, ]
testData <- model_data[-trainIndex, ]

summary(model_data)
summary(trainData)
summary(testData)

# Set up tuning grid for Elastic Net parameters
caretGrid <- expand.grid(
  alpha = seq(0, 1, length = 10),  # Sequencing alpha from 0 (Ridge) to 1 (Lasso)
  lambda = 10^seq(-4, -1, length = 10)  # Exploring a range of lambda values
)

# Define the training control
trainControl <- trainControl(method = "cv", number = 10, search = "random")

# Run the model over the grid, scaling the data using the preProc argument
set.seed(99)  # For reproducibility
enModel <- train(
  Price ~ ., 
  data = trainData, 
  method = "glmnet",
  tuneGrid = caretGrid,
  trControl = trainControl,
  metric = "RMSE",
  preProc = c("center", "scale")
)

# Review the model's performance
print(enModel)

# Best parameter combination
best_params <- enModel$bestTune
print(best_params)

# Predict on test data using the best model
pred <- predict(enModel, newdata = testData)

# Calculate and print performance metrics on the test data
performance <- postResample(pred = pred, obs = testData$Price)
print(performance)

# Extract and print variable importance
importance <- varImp(enModel, scale = FALSE)
print(importance)
plot(importance)


# Plot predicted vs. observed prices for test data
comparison_df <- data.frame(Predicted = pred, Observed = testData$Price)
ggplot(comparison_df, aes(x = Observed, y = Predicted)) +
  geom_point(size = 1, alpha = 0.5) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Predicted Vs Observed Prices Plot", x = "Observed Prices", y = "Predicted Prices")

## Assuming 'importance' is the result of varImp(enModel, scale = FALSE)
importance_scores <- importance$importance  # Extract the importance scores
importance_df <- as.data.frame(importance_scores)  # Convert to dataframe
importance_df$Variable <- rownames(importance_df)  # Add a column for variable names

# Plot using ggplot2
library(ggplot2)
ggplot(importance_df, aes(x = reorder(Variable, Overall), y = Overall)) +
  geom_bar(stat = "identity", fill = "brown") +
  theme_minimal() +
  labs(title = "Variable Importance", x = "Variable", y = "Importance") +
  coord_flip()  # Flip axes to make variable names readable

# Plot predicted vs. observed prices for test data
comparison_df <- data.frame(Predicted = pred, Observed = testData$Price)

ggplot(comparison_df, aes(x = Observed, y = Predicted)) +
  geom_point(size = 1, alpha = 0.5) + # Plot actual predicted vs observed values
  geom_abline(intercept = 0, slope = 1, color = "blue", linetype = "dashed", size = 1.2) + # Perfect fit line, slightly emphasized
  geom_smooth(method = "lm", se = FALSE, color = "red", size = 1.2) + # Actual fit line, slightly emphasized
  labs(title = "Predicted Vs Observed Prices Plot", x = "Observed Prices", y = "Predicted Prices") +
  theme_minimal()

library(ggplot2)

library(ggplot2)

library(ggplot2)

library(ggplot2)

library(ggplot2)

# Create a dataframe for plotting
comparison_df <- data.frame(Predicted = pred, Observed = testData$Price)

# Plot using ggplot2
ggplot(comparison_df, aes(x = Observed, y = Predicted)) +
  geom_point(alpha = 0.5) +  # Scatter plot of observed vs. predicted values
  geom_smooth(method = "loess", color = "red", se = FALSE) +  # LOESS smooth line without confidence interval
  geom_smooth(method = "lm", color = "steelblue", se = FALSE) +  # Linear model trend line
  labs(title = "Predicted Vs Observed Prices Plot", x = "Observed Prices", y = "Predicted Prices") +
  theme_minimal()








