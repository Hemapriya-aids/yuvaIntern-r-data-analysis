data <- read.csv("Titanic-Dataset.csv", stringsAsFactors = FALSE)

data <- data[!duplicated(data), ]

data$Sex <- as.factor(data$Sex)

if ("Embarked" %in% names(data)) {
  data$Embarked <- as.factor(data$Embarked)
}

if ("Age" %in% names(data)) {
  data$Age[is.na(data$Age)] <- median(data$Age, na.rm = TRUE)
}

if ("Fare" %in% names(data)) {
  data$Fare[is.na(data$Fare)] <- median(data$Fare, na.rm = TRUE)
}

if ("Embarked" %in% names(data)) {
  mode_embarked <- names(sort(table(data$Embarked), decreasing = TRUE))[1]
  data$Embarked[is.na(data$Embarked)] <- mode_embarked
}

if ("Cabin" %in% names(data)) {
  data$Cabin[is.na(data$Cabin)] <- "Unknown"
}

if ("Ticket" %in% names(data)) {
  data$Ticket[is.na(data$Ticket)] <- "Unknown"
}

if ("Name" %in% names(data)) {
  data$Name[is.na(data$Name)] <- "Unknown"
}

cap_outliers <- function(x) {
  q1 <- quantile(x, 0.25, na.rm = TRUE)
  q3 <- quantile(x, 0.75, na.rm = TRUE)
  iqr <- q3 - q1
  lower <- q1 - 1.5 * iqr
  upper <- q3 + 1.5 * iqr
  x[x < lower] <- lower
  x[x > upper] <- upper
  x
}

data$Age <- cap_outliers(data$Age)
data$Fare <- cap_outliers(data$Fare)

write.csv(data, "Titanic_Task2_Cleaned.csv", row.names = FALSE)

dir.create("outputs", showWarnings = FALSE)

png("outputs/age_distribution.png", width = 900, height = 600)
hist(data$Age, breaks = 20, main = "Age Distribution of Titanic Passengers", xlab = "Age", ylab = "Number of Passengers", col = "lightblue", border = "white")
dev.off()

png("outputs/fare_distribution.png", width = 900, height = 600)
hist(data$Fare, breaks = 25, main = "Fare Distribution of Titanic Passengers", xlab = "Fare", ylab = "Number of Passengers", col = "lightgreen", border = "white")
dev.off()

png("outputs/survival_distribution.png", width = 900, height = 600)
barplot(table(data$Survived), names.arg = c("Did Not Survive", "Survived"), main = "Survival Distribution", xlab = "Survival Status", ylab = "Number of Passengers", col = "lightblue")
dev.off()

png("outputs/survival_by_gender.png", width = 900, height = 600)
barplot(table(data$Sex, data$Survived), beside = TRUE, main = "Survival by Gender", xlab = "Gender", ylab = "Number of Passengers", legend.text = c("Did Not Survive", "Survived"))
dev.off()

png("outputs/survival_by_class.png", width = 900, height = 600)
barplot(table(data$Pclass, data$Survived), beside = TRUE, main = "Survival by Passenger Class", xlab = "Passenger Class", ylab = "Number of Passengers", legend.text = c("Did Not Survive", "Survived"))
dev.off()

png("outputs/age_by_gender.png", width = 900, height = 600)
boxplot(Age ~ Sex, data = data, main = "Age Distribution by Gender", xlab = "Gender", ylab = "Age")
dev.off()

png("outputs/fare_by_class.png", width = 900, height = 600)
boxplot(Fare ~ Pclass, data = data, main = "Fare Distribution by Passenger Class", xlab = "Passenger Class", ylab = "Fare")
dev.off()

png("outputs/age_vs_fare.png", width = 900, height = 600)
plot(data$Age, data$Fare, main = "Age vs Fare", xlab = "Age", ylab = "Fare", pch = 19)
dev.off()

png("outputs/age_vs_survival.png", width = 900, height = 600)
boxplot(Age ~ Survived, data = data, names = c("Did Not Survive", "Survived"), main = "Age Distribution by Survival Status", xlab = "Survival Status", ylab = "Age")
dev.off()

if (!requireNamespace("corrplot", quietly = TRUE)) {
  install.packages("corrplot")
}
library(corrplot)

png("outputs/correlation_heatmap.png", width = 900, height = 700)
numeric_data <- data[, c("Survived", "Pclass", "Age", "SibSp", "Parch", "Fare")]
correlation_matrix <- cor(numeric_data, use = "complete.obs")
corrplot(correlation_matrix, method = "color", addCoef.col = "black", tl.col = "black", number.cex = 0.8, title = "Correlation Heatmap", mar = c(0, 0, 2, 0))
dev.off()

png("outputs/survival_pie_chart.png", width = 900, height = 600)
pie(table(data$Survived), labels = c("Did Not Survive", "Survived"), main = "Titanic Survival Distribution")
dev.off()

cat("Week 2 data visualization completed successfully.\n")
