# YUVAIntern Data Analysis Internship – Week 2

## Task 2: Data Visualization and Insight Communication Using R

This project performs data preparation, visualization, correlation analysis, and insight communication using the Titanic dataset.

## Tools and Technologies
- R
- RStudio
- Base R graphics
- corrplot
- CSV dataset

No tidyverse, ggplot2, caret, or other unnecessary packages are required.

## Files
- `week2_data_visualization.R` – complete R script.
- `Titanic-Dataset.csv` – original Titanic dataset used for the project.
- `Titanic_Task2_Cleaned.csv` – cleaned dataset after duplicate removal, missing-value handling, categorical conversion, and outlier treatment.
- `Week2_Report.docx` – professional internship report.
- `outputs/` – generated visualization PNG files.

## How to Run
1. Install R and RStudio.
2. Open `week2_data_visualization.R` in RStudio.
3. Set the working directory to the `WEEK2` folder.
4. Run the complete script.
5. The script creates/updates `Titanic_Task2_Cleaned.csv` and all charts in the `outputs` folder.
6. The correlation heatmap uses the `corrplot` package.

## Data Preparation
The analysis includes:
- Duplicate removal
- Missing-value handling
- Categorical conversion
- IQR-based outlier capping for Age and Fare
- Export of the cleaned dataset

## Visualizations
1. Age Distribution
2. Fare Distribution
3. Survival Distribution
4. Survival by Gender
5. Survival by Passenger Class
6. Age by Gender
7. Fare by Passenger Class
8. Age vs Fare
9. Age vs Survival
10. Correlation Heatmap
11. Survival Pie Chart

## Actual Dataset Summary
- Rows after cleaning: 891
- Original rows: 891
- Duplicate rows removed: 0
- Missing Age values handled: 177
- Missing Fare values handled: 0
- Missing Embarked values handled: 2
- Survivors: 342
- Non-survivors: 549
- Overall survival rate: 38.38%

## Submission
The complete project is packaged as `YUVAINTERN_WEEK2.zip`.
