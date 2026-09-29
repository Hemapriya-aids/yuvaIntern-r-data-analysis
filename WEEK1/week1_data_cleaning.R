install.packages("tidyverse")
install.packages("caret")
install.packages("corrplot")

library(tidyverse)
library(caret)
library(corrplot)
setwd("C:/Users/HEMA PRIYA/OneDrive/Documents/YUVAINTERN/WEEK1")
list.files()
data <- read.csv("Titanic-Dataset.csv")

head(data)


tail(data)

dim(data)
nrow(data)
ncol(data)

colnames(data)

str(data)

summary(data)

colSums(is.na(data))

colSums(is.na(data)) / nrow(data) * 100

sum(duplicated(data))

data <- data[!duplicated(data), ]

data$Age[is.na(data$Age)] <- median(data$Age, na.rm = TRUE)

mode_value <- names(sort(table(data$Embarked), decreasing = TRUE))[1]

data$Embarked[is.na(data$Embarked)] <- mode_value

data <- data %>%
  select(-PassengerId, -Name, -Ticket, -Cabin)

data$Sex <- as.factor(data$Sex)
data$Embarked <- as.factor(data$Embarked)
data$Pclass <- as.factor(data$Pclass)
data$Survived <- as.factor(data$Survived)

Q1 <- quantile(data$Fare, 0.25)
Q3 <- quantile(data$Fare, 0.75)

IQR_value <- Q3 - Q1

lower <- Q1 - 1.5 * IQR_value
upper <- Q3 + 1.5 * IQR_value

data$Fare[data$Fare < lower] <- lower
data$Fare[data$Fare > upper] <- upper

normalize <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}

data$Age <- normalize(data$Age)
data$SibSp <- normalize(data$SibSp)
data$Parch <- normalize(data$Parch)
data$Fare <- normalize(data$Fare)

dummy <- dummyVars(~ Sex + Embarked + Pclass, data = data)

encoded <- predict(dummy, newdata = data)

encoded <- as.data.frame(encoded)

head(encoded)

mean(data$Age)
median(data$Age)
sd(data$Age)
min(data$Age)
max(data$Age)

mean(data$Fare)
median(data$Fare)
sd(data$Fare)
min(data$Fare)
max(data$Fare)

table(data$Survived)

prop.table(table(data$Survived)) * 100

table(data$Sex, data$Survived)

prop.table(table(data$Sex, data$Survived), margin = 1) * 100

table(data$Pclass, data$Survived)

prop.table(table(data$Pclass, data$Survived), margin = 1) * 100

cor_data <- data %>%
  select(Age, SibSp, Parch, Fare)

cor_matrix <- cor(cor_data)

cor_matrix

corrplot(
  cor_matrix,
  method = "color",
  type = "upper",
  addCoef.col = "black"
)

ggplot(data, aes(x = Age)) +
  geom_histogram(bins = 30) +
  labs(
    title = "Age Distribution",
    x = "Age",
    y = "Frequency"
  ) +
  theme_minimal()

ggplot(data, aes(x = Fare)) +
  geom_histogram(bins = 30) +
  labs(
    title = "Fare Distribution",
    x = "Fare",
    y = "Frequency"
  ) +
  theme_minimal()

ggplot(data, aes(x = Sex, y = Age)) +
  geom_boxplot() +
  labs(
    title = "Age Distribution by Gender",
    x = "Gender",
    y = "Age"
  ) +
  theme_minimal()

ggplot(data, aes(x = Survived)) +
  geom_bar() +
  labs(
    title = "Survival Distribution",
    x = "Survived",
    y = "Count"
  ) +
  theme_minimal()

ggplot(data, aes(x = Sex, fill = Survived)) +
  geom_bar(position = "dodge") +
  labs(
    title = "Survival by Gender",
    x = "Gender",
    y = "Count"
  ) +
  theme_minimal()

ggplot(data, aes(x = Pclass, fill = Survived)) +
  geom_bar(position = "dodge") +
  labs(
    title = "Survival by Passenger Class",
    x = "Passenger Class",
    y = "Count"
  ) +
  theme_minimal()

ggplot(data, aes(x = Age, y = Fare)) +
  geom_point() +
  labs(
    title = "Age vs Fare",
    x = "Age",
    y = "Fare"
  ) +
  theme_minimal()

str(data)

summary(data)

colSums(is.na(data))

dim(data)

head(data)

write.csv(data, "Titanic_Cleaned.csv", row.names = FALSE)