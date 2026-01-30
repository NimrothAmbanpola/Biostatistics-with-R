###############################################################
# Master in Biochemistry and Biotechnology – Semester I 
# Topic : Correlation and Regression -8
# Course: BCBT 54813 - Biostatistics
# Author: Nimroth Ambanpola
##############################################################


#Correlation and Regression for Prediction
##########################################
#Correlation measures the strength and direction of a linear relationship between variables 
#Regression builds a predictive model (an equation like y = mx + b) to forecast values, quantifying how much one variable changes with another, using correlation as a foundation.

#1. Correlation analysis
             Pearson’s correlation coefficient (r)
			     Measures linear association between two numeric, interval-scale variables
				 Appropriate for continuous data
			 Spearman’s rank correlation coefficient (rho)
			     Non-parametric measure of association
				 Appropriate when variables are ordinal or interval assumptions are uncertain

#2. Regression analysis: from association to prediction
             Used to predict outcomes based on one or more variables
			     Simple linear regression: one predictor, one outcome
				 Multiple linear regression: multiple predictors, one outcome
				 Binary logistic regression: binary outcomes (e.g., yes/no)
				 Odds ratio: interprets effect size and direction in logistic regression

################################################################################################				 
#Description of the Data
########################
#Data are inspired by a company-sponsored wellness program
#A real wellness dataset would typically include many more variables (e.g., cholesterol measures, hormones, lifestyle behaviors, family medical history)

#Dataset size
             Total number of subjects: 3,945


#Variables included
         10 object variables in total
             One variable is a unique subject identification code (EmployeeID)
		     Nine variables represent health-related measures, such as:
			     Gender
				 Age(Years)
				 RaceEthnicity
				 Total Cholesterol (mg/dL)
				 Systolic Blood Pressure (SBP; mmHg)
				 Diastolic Blood Pressure (DBP; mmHg)
				 Body Mass Index (BMI, calculated)
				 BMIStatus
				 Obesity
				 

#Missing data
             Some object variables contain missing values, though not all

#Import Data in Comma-Separated Values (.csv) File

EmployeeBiometric.df <-
    read.table(file="EmpWellAge21to79.csv",
	header=TRUE, dec=".", sep=",")

class(EmployeeBiometric.df) # Identify object-type
nrow(EmployeeBiometric.df) # List the number of rows
ncol(EmployeeBiometric.df) # List the number of columns
dim(EmployeeBiometric.df) # Dimensions of the data frame
names(EmployeeBiometric.df) # Identify names
colnames(EmployeeBiometric.df) # Show column names
head(EmployeeBiometric.df) # Show the head
tail(EmployeeBiometric.df) # Show the tail


#Checking for Duplicate Records
table(duplicated(EmployeeBiometric.df$EmployeeID))  # Check for duplicates

#Output
FALSE
3945

#duplicated() checks whether any EmployeeID appears more than once. FALSE = 3945 means all records are unique
#If duplicates existed, counts for both FALSE and TRUE would appear

# Verifying Data Structure Before Recoding
str(EmployeeBiometric.df)      # Structure before recoding
summary(EmployeeBiometric.df)  # Summary before recoding


#str() shows:
             Whole numbers as int (integer)
			 Decimal values as num (numeric)

#summary() provides:
             Minimum, maximum, median, mean
			 Missing values (if any)

#Confirms the dataset was imported correctly

#################################################################################################
#Data Recoding
##############
#Why Recoding Is Necessary
             Some variables were imported as integers but represent categories
             Other variables must be numeric to support mathematical operations
             Recoding ensures variables behave correctly in:
                 Correlation
                 Regression
                 Statistical modeling

#Recoding Identification and Categorical Variables
##################################################

| Variable                 | Original Format  | Desired Format                                                  |
| ------------------------ | ---------------- | --------------------------------------------------------------- |
| **EmployeeID**           | Integer          | Factor (nominal)                                                |
| **Gender**               | Integer (1, 2)   | Factor (nominal: Female, Male)                                  |
| **AgeYears**             | Integer          | Numeric                                                         |
| **RaceEthnicity**        | Integer (1–5)    | Factor (nominal: Asian, Black, Hispanic, Other, White)          |
| **TotalCholesterolmgdL** | Integer          | Numeric                                                         |
| **SBPmmHg**              | Integer          | Numeric                                                         |
| **DBPmmHg**              | Integer          | Numeric                                                         |
| **BMIMetric**            | Numeric          | Numeric                                                         |
| **BMIStatus**            | Integer (1–4)    | Factor (ordinal: Underweight, Normal Weight, Overweight, Obese) |
| **Obesity**              | Integer (binary) | Factor (ordinal: Not Obese, Obese)                              |


#1. Employee ID → Factor (Nominal)

EmployeeBiometric.df$EmployeeID <-
  as.factor(EmployeeBiometric.df$EmployeeID)


#EmployeeID is an identifier, not a numeric quantity
#Converted to factor to prevent accidental mathematical use


#2. Gender → Factor with Labels

EmployeeBiometric.df$Gender <-
  factor(EmployeeBiometric.df$Gender,
         labels = c("Female", "Male"))

levels(EmployeeBiometric.df$Gender)


#Output
[1] "Female" "Male"


#Converts numeric codes (1, 2) into meaningful labels
#factor() is used (not as.factor()) to control labeling explicitly

#3. Age → Numeric

EmployeeBiometric.df$AgeYears <-
  as.numeric(EmployeeBiometric.df$AgeYears)


#Ensures age can be used in calculations and regression models

#4. Race/Ethnicity → Factor with Labels

EmployeeBiometric.df$RaceEthnicity <-
  factor(EmployeeBiometric.df$RaceEthnicity,
         labels = c("Asian", "Black", "Hispanic", "Other", "White"))

levels(EmployeeBiometric.df$RaceEthnicity)


#Output

[1] "Asian" "Black" "Hispanic" "Other" "White"


#Converts coded integers into categorical group labels
#Nominal variable with no inherent order

#5-8. Recoding Clinical Measurements

EmployeeBiometric.df$TotalCholesterolmgdL <-
  as.numeric(EmployeeBiometric.df$TotalCholesterolmgdL)

EmployeeBiometric.df$SBPmmHg <-
  as.numeric(EmployeeBiometric.df$SBPmmHg)

EmployeeBiometric.df$DBPmmHg <-
  as.numeric(EmployeeBiometric.df$DBPmmHg)

EmployeeBiometric.df$BMIMetric <-
  as.numeric(EmployeeBiometric.df$BMIMetric)


#Converts integer-stored clinical values to numeric
#Required for correlation and regression analyses
#BMIMetric already numeric but explicitly converted for consistency

#9. BMI Status → Ordinal Factor

EmployeeBiometric.df$BMIStatus <-
  factor(EmployeeBiometric.df$BMIStatus,
         labels = c("Underweight", "Normal Weight",
                    "Overweight", "Obese"))

levels(EmployeeBiometric.df$BMIStatus)


#Output

[1] "Underweight" "Normal Weight" "Overweight" "Obese"


#Ordered categorical variable derived from BMI values
#Used for group comparisons and categorical modeling

#10. Obesity → Binary Factor
EmployeeBiometric.df$Obesity <-
  factor(EmployeeBiometric.df$Obesity,
         labels = c("Not Obese", "Obese"))

levels(EmployeeBiometric.df$Obesity)


#Output

[1] "Not Obese" "Obese"


#Binary outcome variable
#Commonly used in logistic regression


#Post-Recoding Verification and Quality Assurance
nrow(EmployeeBiometric.df) # List the number of rows
ncol(EmployeeBiometric.df) # List the number of columns
dim(EmployeeBiometric.df) # Dimensions of the data frame
names(EmployeeBiometric.df) # Identify names
colnames(EmployeeBiometric.df) # Show column names
head(EmployeeBiometric.df) # Show the head
tail(EmployeeBiometric.df) # Show the tail
str(EmployeeBiometric.df) # Structure after recoding
summary(EmployeeBiometric.df) # Summary after recoding

#################################################################################################
#Conduct a Visual Data Check Using Graphics
###########################################

#After recoding and verifying the dataset, a visual inspection is an essential quality-assurance step. 
#Graphical displays help detect unexpected patterns, imbalance, skewness, outliers, and missing data before formal statistical analysis.

#Factor (Categorical) Object Variables
######################################

#Factor-type variables in this dataset include:
             Gender
			 RaceEthnicity
			 BMIStatus
			 Obesity



library(epiDisplay)        # Load the epiDisplay package
sessionInfo()              # Confirm attached packages

#Gender
par(ask = TRUE)
par(mfrow = c(2, 2))       # 2 × 2 grid for four plots

epiDisplay::tab1(EmployeeBiometric.df$Gender,
                 main = "Frequency of Gender",
                 ylab = "Frequency",
                 graph = TRUE,
                 missing = TRUE,
                 bar.values = c("frequency"),
                 horiz = TRUE,
                 cex = 0.85,
                 cex.names = 0.85,
                 cex.lab = 0.85,
                 cex.axis = 0.85,
                 col = c("black", "red"))

#Race / Ethnicity
epiDisplay::tab1(EmployeeBiometric.df$RaceEthnicity,
                 main = "Frequency of Race Ethnicity",
                 ylab = "Frequency",
                 graph = TRUE,
                 missing = TRUE,
                 bar.values = c("frequency"),
                 horiz = TRUE,
                 cex = 0.85,
                 cex.names = 0.85,
                 cex.lab = 0.85,
                 cex.axis = 0.85,
                 col = c("black", "red", "blue", "green", "cyan"))

#BMI Status
epiDisplay::tab1(EmployeeBiometric.df$BMIStatus,
                 main = "Frequency of BMI Status",
                 ylab = "Frequency",
                 graph = TRUE,
                 missing = TRUE,
                 bar.values = c("frequency"),
                 horiz = TRUE,
                 cex = 0.85,
                 cex.names = 0.85,
                 cex.lab = 0.85,
                 cex.axis = 0.85,
                 col = c("black", "red", "blue", "green", "cyan"))


#Obesity (Binary Outcome)
epiDisplay::tab1(EmployeeBiometric.df$Obesity,
                 main = "Frequency of Obesity",
                 ylab = "Frequency",
                 graph = TRUE,
                 missing = TRUE,
                 bar.values = c("frequency"),
                 horiz = TRUE,
                 cex = 0.85,
                 cex.names = 0.85,
                 cex.lab = 0.85,
                 cex.axis = 0.85,
                 col = c("black", "red", "blue"))


#Numeric variables examined:
             AgeYears
			 TotalCholesterolmgdL
			 SBPmmHg
			 DBPmmHg
			 BMIMetric

#Each variable is visualized using four complementary plots:
             Histogram
			 Density curve
			 Beanplot
			 Normal Q–Q plot



# Load Beanplot Package
install.packages("beanplot", dependencies = TRUE)
library(beanplot)
help(package = beanplot)
sessionInfo()

#Age (Years)
par(ask = TRUE)
par(mfrow = c(2, 2))

hist(EmployeeBiometric.df$AgeYears,
     main = "Age",
     col = "red",
     breaks = 100)

plot(density(EmployeeBiometric.df$AgeYears, na.rm = TRUE),
     main = "Age",
     col = "red")

beanplot::beanplot(EmployeeBiometric.df$AgeYears,
                   main = "Age",
                   col = "red",
                   what = c(1, 1, 1, 0),
                   overallline = "mean",
                   boxwex = 0.75,
                   horizontal = FALSE)

qqnorm(EmployeeBiometric.df$AgeYears,
       main = "Age",
       col = "red")



#Total Cholesterol (mg/dL)
par(ask = TRUE)
par(mfrow = c(2, 2))

hist(EmployeeBiometric.df$TotalCholesterolmgdL,
     main = "Total Cholesterol (mg/dL)",
     col = "red",
     breaks = 100)

plot(density(EmployeeBiometric.df$TotalCholesterolmgdL, na.rm = TRUE),
     main = "Total Cholesterol (mg/dL)",
     col = "red")

beanplot::beanplot(EmployeeBiometric.df$TotalCholesterolmgdL,
                   main = "Total Cholesterol (mg/dL)",
                   col = "red",
                   what = c(1, 1, 1, 0),
                   overallline = "mean",
                   boxwex = 0.75,
                   horizontal = FALSE)

qqnorm(EmployeeBiometric.df$TotalCholesterolmgdL,
       main = "Total Cholesterol (mg/dL)",
       col = "red")


#Systolic Blood Pressure (SBP)
par(ask = TRUE)
par(mfrow = c(2, 2))  # 4 figures into a 2 row by 2 column grid

hist(EmployeeBiometric.df$SBPmmHg,
     main = "Systolic Blood Pressure (mmHg)",
     col = "red",
     breaks = 100)

plot(density(EmployeeBiometric.df$SBPmmHg, na.rm = TRUE),
     main = "Systolic Blood Pressure (mmHg)",
     col = "red")

beanplot::beanplot(EmployeeBiometric.df$SBPmmHg,
                   main = "Systolic Blood Pressure (mmHg)",
                   col = "red",
                   what = c(1, 1, 1, 0),
                   overallline = "mean",
                   boxwex = 0.75,
                   horizontal = FALSE)

qqnorm(EmployeeBiometric.df$SBPmmHg,
       main = "Systolic Blood Pressure (mmHg)",
       col = "red")


#Diastolic Blood Pressure (DBP)
par(ask = TRUE)
par(mfrow = c(2, 2))  # 4 figures into a 2 row by 2 column grid

hist(EmployeeBiometric.df$DBPmmHg,
     main = "Diastolic Blood Pressure (mmHg)",
     col = "red",
     breaks = 100)

plot(density(EmployeeBiometric.df$DBPmmHg, na.rm = TRUE),
     main = "Diastolic Blood Pressure (mmHg)",
     col = "red")

beanplot::beanplot(EmployeeBiometric.df$DBPmmHg,
                   main = "Diastolic Blood Pressure (mmHg)",
                   col = "red",
                   what = c(1, 1, 1, 0),
                   overallline = "mean",
                   boxwex = 0.75,
                   horizontal = FALSE)

qqnorm(EmployeeBiometric.df$DBPmmHg,
       main = "Diastolic Blood Pressure 1st Reading (mmHg)",
       col = "red")



#Body Mass Index (BMI Metric)
par(ask = TRUE)
par(mfrow = c(2, 2))  # 4 figures into a 2 row by 2 column grid

hist(EmployeeBiometric.df$BMIMetric,
     main = "Body Mass Index: BMI Metric = kg/m^2",
     col = "red",
     breaks = 100)

plot(density(EmployeeBiometric.df$BMIMetric, na.rm = TRUE),
     main = "Body Mass Index: BMI Metric = kg/m^2",
     col = "red")

beanplot::beanplot(EmployeeBiometric.df$BMIMetric,
                   main = "Body Mass Index: BMI Metric = kg/m^2",
                   col = "red",
                   what = c(1, 1, 1, 0),
                   overallline = "mean",
                   boxwex = 0.75,
                   horizontal = FALSE)

qqnorm(EmployeeBiometric.df$BMIMetric,
       main = "Body Mass Index: BMI Metric = kg/m^2",
       col = "red")

#################################################################################################
#Descriptive Statistics for Initial Analysis of the Data

#To complement these visuals, descriptive statistics are used to summarize the data numerically and prepare for analyses of association and prediction.

#Summary of Factor-Type Object Variables
summary(EmployeeBiometric.df[, c(2, 4, 9, 10)])
# Column 2  ... Gender
# Column 4  ... RaceEthnicity
# Column 9  ... BMIStatus
# Column 10 ... Obesity


#Summary of Numeric Object Variables
summary(EmployeeBiometric.df[, c(3, 5, 6, 7, 8)])
# Column 3 ... AgeYears
# Column 5 ... TotalCholesterolmgdL
# Column 6 ... SBPmmHg
# Column 7 ... DBPmmHg
# Column 8 ... BMIMetric



#Frequency Distributions of Factor-Type Object Variables

#To obtain clean, copy-ready frequency tables, the epiDisplay::tab1() function is reused with graphical output disabled.

epiDisplay::tab1(EmployeeBiometric.df$Gender, graph = FALSE)

epiDisplay::tab1(EmployeeBiometric.df$RaceEthnicity, graph = FALSE)

epiDisplay::tab1(EmployeeBiometric.df$BMIStatus, graph = FALSE)

epiDisplay::tab1(EmployeeBiometric.df$Obesity, graph = FALSE)

#################################################################################################
#Quality Assurance, Data Distribution, and Tests for Normality
##############################################################

#The Shapiro test is first applied to numeric variables overall, without stratifying by factor variables.

#Age (Years)
shapiro.test(EmployeeBiometric.df$AgeYears)

#Output
Shapiro-Wilk normality test
p-value < 0.0000000000000002

#Interpretation:

p-value < 0.05
Evidence that AgeYears is not normally distributed

#Total Cholesterol (mg/dL)
shapiro.test(EmployeeBiometric.df$TotalCholesterolmgdL)


#Output
Shapiro-Wilk normality test
p-value < 0.0000000000000002


#Interpretation:
Strong evidence against normality
Distribution deviates substantially from normal

#Systolic Blood Pressure (SBPmmHg)
shapiro.test(EmployeeBiometric.df$SBPmmHg)


#Output
Shapiro-Wilk normality test
p-value < 0.0000000000000002


#Interpretation:
SBPmmHg does not follow a normal distribution

#Diastolic Blood Pressure (DBPmmHg)
shapiro.test(EmployeeBiometric.df$DBPmmHg)


#Output
Shapiro-Wilk normality test
p-value = 0.0000000321


#Interpretation:
p-value < 0.05
Evidence against normality

#Body Mass Index (BMIMetric)
shapiro.test(EmployeeBiometric.df$BMIMetric)

#Output
Shapiro-Wilk normality test
p-value < 0.0000000000000002


#Interpretation:
BMI distribution is not normal
Common and expected in wellness data

#Summary and Practical Implications
             None of the five numeric variables exhibit strict normality
			 This outcome is consistent with real-world health data
			 
#################################################################################################
#Visual Confirmation of Normality Using Q–Q Plots
#################################################

#The Shapiro–Wilk tests indicated that normal distribution is not evident for all five numeric object variables, including BMIMetric.
#To visually confirm the degree and nature of deviation from normality, Quantile–Quantile (Q–Q) plots are used.

#Q–Q Plots for Numeric Variables (Overall)
par(ask = TRUE)
par(mfrow = c(2, 3))  # 6 figures into a 2 row by 3 column grid

qqnorm(EmployeeBiometric.df$AgeYears, col = "red",
       main = "Normality of AgeYears - Overall")
qqline(EmployeeBiometric.df$AgeYears, col = "blue")

qqnorm(EmployeeBiometric.df$TotalCholesterolmgdL, col = "red",
       main = "Normality of TotalCholesterolmgdL - Overall")
qqline(EmployeeBiometric.df$TotalCholesterolmgdL, col = "blue")

qqnorm(EmployeeBiometric.df$SBPmmHg, col = "red",
       main = "Normality of SBPmmHg - Overall")
qqline(EmployeeBiometric.df$SBPmmHg, col = "blue")

qqnorm(EmployeeBiometric.df$DBPmmHg, col = "red",
       main = "Normality of DBPmmHg - Overall")
qqline(EmployeeBiometric.df$DBPmmHg, col = "blue")

qqnorm(EmployeeBiometric.df$BMIMetric, col = "red",
       main = "Normality of BMIMetric - Overall")
qqline(EmployeeBiometric.df$BMIMetric, col = "blue")



#Summary of Overall Normality Assessment
             Shapiro–Wilk tests → all p-values < 0.05
			 Q–Q plots → clear visual deviations
			 Conclusion:
			     AgeYears
				 TotalCholesterolmgdL
				 SBPmmHg
				 DBPmmHg
				 BMIMetric
			 do not follow normal distributions at the overall level

#Normality Testing by Factor-Type Breakouts
###########################################

#A key question follows:
             If a variable is non-normal overall, could it be approximately normal within specific subgroups?
			 To address this, the RVAideMemoire::byf.shapiro() function is used to apply Shapiro–Wilk tests within factor-level breakouts.


install.packages("RVAideMemoire", dependencies = TRUE) #Load Required Package
library(RVAideMemoire)


#Normality by Gender
RVAideMemoire::byf.shapiro(AgeYears ~ Gender,
                           data = EmployeeBiometric.df)

RVAideMemoire::byf.shapiro(TotalCholesterolmgdL ~ Gender,
                           data = EmployeeBiometric.df)

RVAideMemoire::byf.shapiro(SBPmmHg ~ Gender,
                           data = EmployeeBiometric.df)

RVAideMemoire::byf.shapiro(DBPmmHg ~ Gender,
                           data = EmployeeBiometric.df)

RVAideMemoire::byf.shapiro(BMIMetric ~ Gender,
                           data = EmployeeBiometric.df)


#Conclusion:
             All Gender subgroups show p < 0.05
			 Normality is not evident for either Female or Male participants

#Normality by Race/Ethnicity
RVAideMemoire::byf.shapiro(AgeYears ~ RaceEthnicity,
                           data = EmployeeBiometric.df)

RVAideMemoire::byf.shapiro(TotalCholesterolmgdL ~ RaceEthnicity,
                           data = EmployeeBiometric.df)

RVAideMemoire::byf.shapiro(SBPmmHg ~ RaceEthnicity,
                           data = EmployeeBiometric.df)

RVAideMemoire::byf.shapiro(DBPmmHg ~ RaceEthnicity,
                           data = EmployeeBiometric.df)

RVAideMemoire::byf.shapiro(BMIMetric ~ RaceEthnicity,
                           data = EmployeeBiometric.df)


#Conclusion:
             Most race/ethnicity subgroups show significant deviation from normality
			 Occasional borderline p-values occur, but no group clearly satisfies normality

#Normality by BMI Status
RVAideMemoire::byf.shapiro(AgeYears ~ BMIStatus,
                           data = EmployeeBiometric.df)

RVAideMemoire::byf.shapiro(TotalCholesterolmgdL ~ BMIStatus,
                           data = EmployeeBiometric.df)

RVAideMemoire::byf.shapiro(SBPmmHg ~ BMIStatus,
                           data = EmployeeBiometric.df)

RVAideMemoire::byf.shapiro(DBPmmHg ~ BMIStatus,
                           data = EmployeeBiometric.df)

RVAideMemoire::byf.shapiro(BMIMetric ~ BMIStatus,
                           data = EmployeeBiometric.df)


#Conclusion:
             All BMIStatus groups show p < 0.05
			 Even stratification by BMI does not restore normality

#Normality by Obesity Status
RVAideMemoire::byf.shapiro(AgeYears ~ Obesity,
                           data = EmployeeBiometric.df)

RVAideMemoire::byf.shapiro(TotalCholesterolmgdL ~ Obesity,
                           data = EmployeeBiometric.df)

RVAideMemoire::byf.shapiro(SBPmmHg ~ Obesity,
                           data = EmployeeBiometric.df)

RVAideMemoire::byf.shapiro(DBPmmHg ~ Obesity,
                           data = EmployeeBiometric.df)

RVAideMemoire::byf.shapiro(BMIMetric ~ Obesity,
                           data = EmployeeBiometric.df)


#Conclusion:
             Both Obese and Not Obese groups show non-normal distributions
             Confirms robustness of earlier findings

#Final Normality Conclusion
             Non-normality persists:
                 Overall
				 Within Gender
				 Within Race/Ethnicity
				 Within BMIStatus
				 Within Obesity
			 This is expected in large, real-world wellness datasets
			 Normality tests are highly sensitive with large sample sizes
			 
#################################################################################################
#Additional Visual Confirmation of Non-Normality Using ggplot2
##############################################################

#Based on the very small p-values obtained from the Shapiro–Wilk tests—both overall and within factor-level breakouts—there is strong evidence that normality is absent for all numeric object variables.

To further confirm these findings, Q–Q plots by subgroup are generated using ggplot2. Compared with base R Q–Q plots, this approach allows:
             Clear side-by-side comparison across factor levels



install.packages("ggplot2", dependencies = TRUE)
library(ggplot2)  #Load Required Packages


#Q–Q Plots for AgeYears by Factor-Type Breakouts
#By Gender
QQAgeYearsbyGender <-
  ggplot2::ggplot(EmployeeBiometric.df,
                  aes(sample = AgeYears)) +
  stat_qq(color = "red") +
  stat_qq_line(color = "blue", size = 1.75) +
  facet_grid(. ~ Gender) +
  ggtitle("QQ - AgeYears")

#By Race/Ethnicity
QQAgeYearsbyRaceEthnicity <-
  ggplot2::ggplot(EmployeeBiometric.df,
                  aes(sample = AgeYears)) +
  stat_qq(color = "red") +
  stat_qq_line(color = "blue", size = 1.75) +
  facet_grid(. ~ RaceEthnicity) +
  ggtitle("QQ - AgeYears")

#By BMI Status
QQAgeYearsbyBMIStatus <-
  ggplot2::ggplot(EmployeeBiometric.df,
                  aes(sample = AgeYears)) +
  stat_qq(color = "red") +
  stat_qq_line(color = "blue", size = 1.75) +
  facet_grid(. ~ BMIStatus) +
  ggtitle("QQ - AgeYears")

#By Obesity Status
QQAgeYearsbyObesity <-
  ggplot2::ggplot(EmployeeBiometric.df,
                  aes(sample = AgeYears)) +
  stat_qq(color = "red") +
  stat_qq_line(color = "blue", size = 1.75) +
  facet_grid(. ~ Obesity) +
  ggtitle("QQ - AgeYears")

#Arrange Plots for Comparison
par(ask = TRUE)
gridExtra::grid.arrange(
  QQAgeYearsbyGender,
  QQAgeYearsbyRaceEthnicity,
  QQAgeYearsbyBMIStatus,
  QQAgeYearsbyObesity,
  ncol = 2
)




#Q–Q Plots for Total Cholesterol (mg/dL) by Factor Breakouts

QQTotalCholesterolmgdLbyGender <-
  ggplot2::ggplot(EmployeeBiometric.df,
                  aes(sample = TotalCholesterolmgdL)) +
  stat_qq(color = "red") +
  stat_qq_line(color = "blue", size = 1.75) +
  facet_grid(. ~ Gender) +
  ggtitle("QQ - TotalCholesterolmgdL")


(The same structure is applied for RaceEthnicity, BMIStatus, and Obesity, and later repeated for SBPmmHg, DBPmmHg, and BMIMetric.)

#Key Conclusions from ggplot2 Q–Q Plots
             Non-normality is evident:
			     Overall
				 By Gender
				 By Race/Ethnicity
				 By BMIStatus
				 By Obesity
			 Visual patterns are consistent with:
			     Shapiro–Wilk p-values
				 Earlier base R Q–Q plots
			 Large sample size amplifies sensitivity to deviation

#################################################################################################
#ggplot2 Q–Q Plots by Factor Breakouts
######################################

#The Shapiro–Wilk normality tests and earlier Q–Q plots provided strong evidence that normality is absent overall for all numeric object variables.
#To further confirm this finding, ggplot2-based Q–Q plots are used to examine normality within factor-level breakouts.


#Total Cholesterol (mg/dL) by Factor Breakouts

QQTotalCholesterolmgdLbyRaceEthnicity <-
ggplot2::ggplot(EmployeeBiometric.df,
aes(sample = TotalCholesterolmgdL)) +
stat_qq(color = "red") +
stat_qq_line(color = "blue", size = 1.75) +
facet_grid(. ~ RaceEthnicity) +
ggtitle("QQ - TotalCholesterolmgdL")

QQTotalCholesterolmgdLbyBMIStatus <-
ggplot2::ggplot(EmployeeBiometric.df,
aes(sample = TotalCholesterolmgdL)) +
stat_qq(color = "red") +
stat_qq_line(color = "blue", size = 1.75) +
facet_grid(. ~ BMIStatus) +
ggtitle("QQ - TotalCholesterolmgdL")

QQTotalCholesterolmgdLbyObesity <-
ggplot2::ggplot(EmployeeBiometric.df,
aes(sample = TotalCholesterolmgdL)) +
stat_qq(color = "red") +
stat_qq_line(color = "blue", size = 1.75) +
facet_grid(. ~ Obesity) +
ggtitle("QQ - TotalCholesterolmgdL")

par(ask = TRUE)
gridExtra::grid.arrange(
QQTotalCholesterolmgdLbyGender,
QQTotalCholesterolmgdLbyRaceEthnicity,
QQTotalCholesterolmgdLbyBMIStatus,
QQTotalCholesterolmgdLbyObesity,
ncol = 2)



#Systolic Blood Pressure (SBPmmHg) by Factor Breakouts

QQSBPmmHgbyGender <-
ggplot2::ggplot(EmployeeBiometric.df,
aes(sample = SBPmmHg)) +
stat_qq(color = "red") +
stat_qq_line(color = "blue", size = 1.75) +
facet_grid(. ~ Gender) +
ggtitle("QQ - SBPmmHg")

QQSBPmmHgbyRaceEthnicity <-
ggplot2::ggplot(EmployeeBiometric.df,
aes(sample = SBPmmHg)) +
stat_qq(color = "red") +
stat_qq_line(color = "blue", size = 1.75) +
facet_grid(. ~ RaceEthnicity) +
ggtitle("QQ - SBPmmHg")

QQSBPmmHgbyBMIStatus <-
ggplot2::ggplot(EmployeeBiometric.df,
aes(sample = SBPmmHg)) +
stat_qq(color = "red") +
stat_qq_line(color = "blue", size = 1.75) +
facet_grid(. ~ BMIStatus) +
ggtitle("QQ - SBPmmHg")

QQSBPmmHgbyObesity <-
ggplot2::ggplot(EmployeeBiometric.df,
aes(sample = SBPmmHg)) +
stat_qq(color = "red") +
stat_qq_line(color = "blue", size = 1.75) +
facet_grid(. ~ Obesity) +
ggtitle("QQ - SBPmmHg")

par(ask = TRUE)
gridExtra::grid.arrange(
QQSBPmmHgbyGender,
QQSBPmmHgbyRaceEthnicity,
QQSBPmmHgbyBMIStatus,
QQSBPmmHgbyObesity,
ncol = 2)



#Diastolic Blood Pressure (DBPmmHg) by Factor Breakouts

QQDBPmmHgbyGender <-
ggplot2::ggplot(EmployeeBiometric.df,
aes(sample = DBPmmHg)) +
stat_qq(color = "red") +
stat_qq_line(color = "blue", size = 1.75) +
facet_grid(. ~ Gender) +
ggtitle("QQ - DBPmmHg")

QQDBPmmHgbyRaceEthnicity <-
ggplot2::ggplot(EmployeeBiometric.df,
aes(sample = DBPmmHg)) +
stat_qq(color = "red") +
stat_qq_line(color = "blue", size = 1.75) +
facet_grid(. ~ RaceEthnicity) +
ggtitle("QQ - DBPmmHg")

QQDBPmmHgbyBMIStatus <-
ggplot2::ggplot(EmployeeBiometric.df,
aes(sample = DBPmmHg)) +
stat_qq(color = "red") +
stat_qq_line(color = "blue", size = 1.75) +
facet_grid(. ~ BMIStatus) +
ggtitle("QQ - DBPmmHg")

QQDBPmmHgbyObesity <-
ggplot2::ggplot(EmployeeBiometric.df,
aes(sample = DBPmmHg)) +
stat_qq(color = "red") +
stat_qq_line(color = "blue", size = 1.75) +
facet_grid(. ~ Obesity) +
ggtitle("QQ - DBPmmHg")

par(ask = TRUE)
gridExtra::grid.arrange(
QQDBPmmHgbyGender,
QQDBPmmHgbyRaceEthnicity,
QQDBPmmHgbyBMIStatus,
QQDBPmmHgbyObesity,
ncol = 2)

#Body Mass Index (BMIMetric) by Factor Breakouts

QQBMIMetricbyGender <-
ggplot2::ggplot(EmployeeBiometric.df,
aes(sample = BMIMetric)) +
stat_qq(color = "red") +
stat_qq_line(color = "blue", size = 1.75) +
facet_grid(. ~ Gender) +
ggtitle("QQ - BMIMetric")

QQBMIMetricbyRaceEthnicity <-
ggplot2::ggplot(EmployeeBiometric.df,
aes(sample = BMIMetric)) +
stat_qq(color = "red") +
stat_qq_line(color = "blue", size = 1.75) +
facet_grid(. ~ RaceEthnicity) +
ggtitle("QQ - BMIMetric")

QQBMIMetricbyBMIMetric <-
ggplot2::ggplot(EmployeeBiometric.df,
aes(sample = BMIMetric)) +
stat_qq(color = "red") +
stat_qq_line(color = "blue", size = 1.75) +
facet_grid(. ~ BMIStatus) +
ggtitle("QQ - BMIMetric")

QQBMIMetricbyObesity <-
ggplot2::ggplot(EmployeeBiometric.df,
aes(sample = BMIMetric)) +
stat_qq(color = "red") +
stat_qq_line(color = "blue", size = 1.75) +
facet_grid(. ~ Obesity) +
ggtitle("QQ - BMIMetric")

par(ask = TRUE)
gridExtra::grid.arrange(
QQBMIMetricbyGender,
QQBMIMetricbyRaceEthnicity,
QQBMIMetricbyBMIMetric,
QQBMIMetricbyObesity,
ncol = 2)

#Summary of Normality Assessment
             Shapiro tests and Q–Q plots provide consistent evidence of non-normality
			 Deviations are most prominent in the tails
			 Non-normality persists:
			     Overall
				 By Gender
				 By Race/Ethnicity
				 By BMIStatus
				 By Obesity
			 These findings are typical for large wellness datasets
			 
################################################################################################
#Visualizing Obesity by BMI Metric (Handling Missing Data)
#########################################################

#To gain a different perspective on the data, a ggplot2-based visualization is used to examine the relationship between:
             Obesity (factor-type object variable)
			 BMIMetric (numeric-type object variable)

#Special attention is given to how missing data (NA values) may influence interpretation.

#Step 1: Create a Second Dataframe
#A new dataframe is created so that rows with missing BMI values can be removed without altering the original dataset.

EmployeeBiometric2.df <- EmployeeBiometric.df

#Step 2: Confirm Row Counts Before Adjustment
nrow(EmployeeBiometric.df)

#Output
[1] 3945

nrow(EmployeeBiometric2.df)

#Output
[1] 3945


#Explanation (brief):
             Both dataframes initially contain the same number of observations

#Step 3: Remove Rows with Missing BMIMetric Values
EmployeeBiometric2.df <-
  EmployeeBiometric2.df[!is.na(EmployeeBiometric2.df$BMIMetric),]

#Step 4: Confirm Row Counts After Adjustment
nrow(EmployeeBiometric2.df)

#Output
[1] 3925

#Explanation:
             20 observations with missing BMI values were removed
			 The adjusted dataframe now contains only complete BMI data

#Step 5: Q–Q Plots of BMIMetric by Obesity (Including Missing Data)

QQFacetObesityBMIMetricNAs <-
ggplot2::ggplot(EmployeeBiometric.df,
aes(sample = BMIMetric)) +
stat_qq(color = "red") +
stat_qq_line(color = "blue", size = 1.75) +
facet_grid(. ~ Obesity) +
ggtitle(
"BMIMetric QQ-Plot and QQ-Line by Obesity:
Account for NAs (Missing Data)\n") +
labs(
x = "\nTheoretical",
y = "Body Mass Index Metric\n") +
theme_bw()



#Step 6: Q–Q Plots of BMIMetric by Obesity (Excluding Missing Data)


QQFacetObesityBMIMetricNoNAs <-
ggplot2::ggplot(EmployeeBiometric2.df,
aes(sample = BMIMetric)) +
stat_qq(color = "red") +
stat_qq_line(color = "blue", size = 1.75) +
facet_grid(. ~ Obesity) +
ggtitle(
"BMIMetric QQ-Plot and QQ-Line by Obesity:
No NAs (Missing Data)\n") +
labs(
x = "\nTheoretical",
y = "Body Mass Index Metric\n") +
theme_bw()


#Side-by-Side Comparison
par(ask = TRUE)
gridExtra::grid.arrange(
QQFacetObesityBMIMetricNAs,
QQFacetObesityBMIMetricNoNAs,
ncol = 2)

#Interpretation
             Both plots show clear deviation from normality
             Non-normality persists:
			     With missing values
				 Without missing values
			 Tail deviations remain evident in both Obesity groups
			 Missing data do not materially change the normality conclusion



#Implications for Association Analysis
#These findings must inform the choice of analytical methods:
             Pearson’s r
			     Parametric
				 Assumes normality
				 Measures linear association
			 Spearman’s rho
			     Nonparametric
				 Based on ranks
				 Robust to non-normality

################################################################################################
#One-by-One Correlation Analysis
################################
#Pearson’s r (Parametric)
#Key facts
             Pearson’s r is computed on the raw numeric values
             It uses a t-test for significance
             It does not involve ranks
			 
cor(EmployeeBiometric.df$SBPmmHg,
    EmployeeBiometric.df$DBPmmHg,
    use = "complete.obs",
    method = "pearson")


#Output
[1] 0.500096

cor.test(EmployeeBiometric.df$SBPmmHg,
         EmployeeBiometric.df$DBPmmHg,
         use = "complete.obs",
         method = "pearson")


#Interpretation:
             Moderate positive association
			 Statistically significant (p < 0.05)

#Spearman’s rho (Nonparametric)
#Key facts
             Spearman’s rho is based on ranks
             Blood pressure data contain many repeated values
                 e.g., SBP = 120, 130, DBP = 80 appear many times
             Repeated values → tied ranks (Warning: Cannot compute exact p-value with ties)
             Exact p-values require no ties

cor(EmployeeBiometric.df$SBPmmHg,
    EmployeeBiometric.df$DBPmmHg,
    use = "complete.obs",
    method = "spearman")


#Output
[1] 0.518411

cor.test(EmployeeBiometric.df$SBPmmHg,
         EmployeeBiometric.df$DBPmmHg,
         use = "complete.obs",
         method = "spearman")


#Interpretation:
             Similar magnitude to Pearson’s r
			 Confirms robustness of the association

#Key Observation
             Pearson’s r ≈ 0.50
			 Spearman’s rho ≈ 0.52
			 High parity between parametric and nonparametric results


#Efficiency Concern
###################

#Computing correlations one-by-one becomes inefficient as the number of numeric variables grows.
#A more scalable approach is to compute correlation matrices.

#Preparing Data for Multiple Correlations
#Review Original Data Structure
str(EmployeeBiometric.df)


#The dataframe contains both:
             Factor-type variables
			 Numeric-type variables
Correlation matrices require numeric data only.


#Create a Numeric-Only Dataframe
#A Numeric-Only Dataframe is a dataframe that contains only numeric (quantitative) variables and no factor, character, or categorical variables.
             Numeric-Only Dataframe = a dataframe where every column is numeric (num or int)
		   
EmployeeBiometric3.df <- EmployeeBiometric.df

EmployeeBiometric3.df <- subset(EmployeeBiometric3.df,
                                select = -c(EmployeeID, Gender,
                                            RaceEthnicity, BMIStatus,
                                            Obesity))

str(EmployeeBiometric3.df)


#Result:
             5 numeric variables remain:
			 AgeYears, TotalCholesterolmgdL, SBPmmHg, DBPmmHg, BMIMetric

#Rename Variables for Clarity
colnames(EmployeeBiometric3.df) <-
  c("Age", "Cholesterol", "SBP", "DBP", "BMI")

attach(EmployeeBiometric3.df)
str(EmployeeBiometric3.df)

#Multiple Correlations: Pearson’s r Matrix
round(cor(EmployeeBiometric3.df,
          use = "complete.obs",
          method = "pearson"), 2)


#Multiple Correlations: Spearman’s rho Matrix
round(cor(EmployeeBiometric3.df,
          use = "complete.obs",
          method = "spearman"), 2)


#Interpretation:
             SBP–DBP association is strongest
			 BMI shows moderate association with blood pressure
			 Age and cholesterol show weak associations
			 Pearson and Spearman results are broadly consistent

################################################################################################
#Correlation with N and p-values: Hmisc::rcorr()
################################################

install.packages("Hmisc", dependencies = TRUE) #Load Package
library(Hmisc)
help(package = Hmisc)
sessionInfo()

#Pearson Correlation with Significance
Hmisc::rcorr(as.matrix(EmployeeBiometric3.df),
             type = "pearson")

#Spearman Correlation with Significance
Hmisc::rcorr(as.matrix(EmployeeBiometric3.df),
             type = "spearman")


#Output includes:
             Correlation coefficient
			 Sample size (N)
			 p-value for each variable pair

################################################################################################
#Visualizing Correlation Trends Among Numeric Variables

#Correlation coefficients (e.g., Pearson’s r and Spearman’s ρ) provide numerical summaries of association.
#However, visual inspection of relationships between variables remains an essential complement to numeric results.

#To begin, consider a brute-force approach: 
             Generating individual scatterplots for selected variable pairs. 
			 While informative, this approach quickly becomes inefficient as the number of variables increases.

#One-by-One Correlation Plots (Brute-Force Approach)
####################################################
#SBP vs Age
WellnessSBPAge <-
ggplot2::ggplot(EmployeeBiometric3.df,
aes(x = SBP, y = Age)) +
geom_point(size = 2, shape = 19) +
geom_smooth(method = lm) +
theme_bw()

#SBP vs Cholesterol
WellnessSBPCholesterol <-
ggplot2::ggplot(EmployeeBiometric3.df,
aes(x = SBP, y = Cholesterol)) +
geom_point(size = 2, shape = 19) +
geom_smooth(method = lm) +
theme_bw()

#SBP vs DBP
WellnessSBPDBP <-
ggplot2::ggplot(EmployeeBiometric3.df,
aes(x = SBP, y = DBP)) +
geom_point(size = 2, shape = 19) +
geom_smooth(method = lm) +
theme_bw()

#SBP vs BMI
WellnessSBPBMI <-
ggplot2::ggplot(EmployeeBiometric3.df,
aes(x = SBP, y = BMI)) +
geom_point(size = 2, shape = 19) +
geom_smooth(method = lm) +
theme_bw()

#Arrange the Plots
par(ask = TRUE)
gridExtra::grid.arrange(
WellnessSBPAge,
WellnessSBPCholesterol,
WellnessSBPDBP,
WellnessSBPBMI,
ncol = 2)

#Interpretation:
             Little to no association:
			     SBP vs Age
				 SBP vs Cholesterol
			 Clear positive association:
			     SBP vs DBP
				 SBP vs BMI

#These visual patterns agree with previously computed correlation coefficients:

# Pearson’s r (SBP):     Age -0.02, Cholesterol -0.01, DBP 0.50, BMI 0.25
# Spearman’s rho (SBP):  Age -0.01, Cholesterol -0.01, DBP 0.52, BMI 0.32

#Limitation of the Brute-Force Approach
             Requires many separate plots
			 Difficult to track results across many variables
			 Inefficient for datasets with multiple numeric variables

#To address this limitation, a single, integrated correlation matrix is preferred.
################################################################################################
#Correlation Matrix with Graphics and Statistics

#The PerformanceAnalytics::chart.Correlation() function combines:
             Scatterplots
             Correlation coefficients
             Histograms
             Statistical significance (asterisks)


install.packages("PerformanceAnalytics", dependencies = TRUE) #Load Required Package
library(PerformanceAnalytics)
help(package = PerformanceAnalytics)
sessionInfo()

#Pearson Correlation Matrix
par(ask = TRUE)
PerformanceAnalytics::chart.Correlation(
EmployeeBiometric3.df,
method = "pearson",
histogram = TRUE,
pch = 19)

#Spearman Correlation Matrix
par(ask = TRUE)
PerformanceAnalytics::chart.Correlation(
EmployeeBiometric3.df,
method = "spearman",
histogram = TRUE,
pch = 19)

#Interpreting Significance Symbols
#Statistical significance is indicated using standard codes:

‘***’  p ≤ 0.001
‘**’   p ≤ 0.01
‘*’    p ≤ 0.05
‘.’    p ≤ 0.1
‘ ’    p > 0.1

#Key Findings
             SBP–DBP, SBP–BMI, and DBP–BMI:
                 Highly significant (***)
		     Age–Cholesterol:
			     Weak but statistically significant (*)
			 Visual scatterplots and trend lines reinforce these conclusions

#Creating Reusable Correlation Objects
#To reduce repeated computation and simplify reporting, store correlation matrices as objects.

#Pearson Correlation Object
WellnessCorPearson <-
cor(EmployeeBiometric3.df,
use = "complete.obs",
method = "pearson")

round(WellnessCorPearson, 4)

#Spearman Correlation Object
WellnessCorSpearman <-
cor(EmployeeBiometric3.df,
use = "complete.obs",
method = "spearman")

round(WellnessCorSpearman, 4)

################################################################################################
#Visualizing Correlation Matrices Using "corrplot"
##################################################

#While numeric correlation matrices and scatterplots are informative, visual summaries are often more effective for communicating results to an audience.
#The corrplot::corrplot() function provides flexible options for displaying correlation matrices using shapes, colors, and numbers.


install.packages("corrplot", dependencies = TRUE) #Load Required Package
library(corrplot)
help(package = corrplot)
sessionInfo()

#Multiple corrplot Displays (Pearson and Spearman)
par(ask = TRUE)
par(mfrow = c(2, 3))  # 6 figures into a 2 row by 3 column grid

#Pearson Correlation Matrix
corrplot::corrplot(WellnessCorPearson,
method = "square", #Squares emphasize strength of correlation
type = "upper",
order = "original",
tl.srt = 30,  #tl.srt controls the angle of variable labels
number.font = 2,
title = "\nPearson")


corrplot::corrplot(WellnessCorPearson,
method = "color", #Color shading reflects magnitude and direction
type = "upper",
order = "original",
tl.srt = 30,
number.font = 2,
title = "\nPearson")



corrplot::corrplot(WellnessCorPearson,
method = "number", #Exact correlation coefficients displayed
type = "upper",
order = "original",
tl.srt = 30,
number.font = 2,
title = "\nPearson")



#Spearman Correlation Matrix
corrplot::corrplot(WellnessCorSpearman,
method = "square",
type = "upper",
order = "original",
tl.srt = 30,
number.font = 2,
title = "\nSpearman")

corrplot::corrplot(WellnessCorSpearman,
method = "color",
type = "upper",
order = "original",
tl.srt = 30,
number.font = 2,
title = "\nSpearman")

corrplot::corrplot(WellnessCorSpearman,
method = "number",
type = "upper",
order = "original",
tl.srt = 30,
number.font = 2,
title = "\nSpearman")


################################################################################################
#Correlation Visualization Using "GGally"
#########################################
#The GGally package extends ggplot2 and produces correlation figures that are widely recognized and publication-friendly.


install.packages("GGally", dependencies = TRUE) #Load Required Package
library(GGally)
help(package = GGally)
sessionInfo()

#ggcorr(): Compact Correlation Heatmaps
ggcorrPearson <-
GGally::ggcorr(EmployeeBiometric3.df,
palette = "RdBu",
label = TRUE,
method = c("complete.obs", "pearson"),
name = "Pearson")

ggcorrSpearman <-
GGally::ggcorr(EmployeeBiometric3.df,
palette = "RdBu",
label = TRUE,
method = c("complete.obs", "spearman"),
name = "Spearman")

par(ask = TRUE)
gridExtra::grid.arrange(
ggcorrPearson,
ggcorrSpearman,
ncol = 2)


#Purpose:
             Color intensity shows strength and direction
			 Labels show correlation coefficients
			 Easy comparison of Pearson vs Spearman results

#ggpairs(): Full Correlation Matrix with Scatterplots

par(ask = TRUE)
GGally::ggpairs(EmployeeBiometric3.df,
columns = 1:ncol(EmployeeBiometric3.df),
title = "Correlation Matrix of Age, Cholesterol, SBP, DBP, and BMI",
upper = list(continuous = wrap("cor", size = 7)))


#Purpose:
             Diagonal: variable distributions
			 Upper triangle: correlation coefficients
			 Lower triangle: scatterplots
			 Provides the most comprehensive overview

#Summary of Correlation Results
###############################
(Age, Cholesterol, SBP, DBP, BMI)

#Across text output and multiple graphical formats, consistent conclusions emerge:
| Variable Pair | Pearson’s r | Spearman’s ρ | Statistical Significance |
| ------------- | ----------- | ------------ | ------------------------ |
| **SBP ↔ DBP** | ≈ 0.49      | ≈ 0.52       | Significant (p ≤ 0.05)   |
| **SBP ↔ BMI** | ≈ 0.24      | ≈ 0.31       | Significant (p ≤ 0.05)   |
| **DBP ↔ BMI** | ≈ 0.24      | ≈ 0.26       | Significant (p ≤ 0.05)   |


#Interpretation:
             Blood pressure components (SBP, DBP) show moderate positive association
			 BMI is positively associated with both SBP and DBP
			 Parametric and nonparametric estimates show strong agreement, supporting robustness of findings
			 
################################################################################################
#Linear Regression Using a Single Predictor Variable
####################################################

#Previous analyses established statistically significant associations between:
             SBP ↔ DBP
             SBP ↔ BMI
             DBP ↔ BMI

#This opens the possibility of prediction, not causation, using simple linear regression.

#Why Use BMI as a Predictor?
############################
     Blood pressure (SBP, DBP)
             Requires a sphygmomanometer
			 Often uncomfortable
			 Requires trained personnel and scheduling

     Body Mass Index (BMI)
	         Requires only weight and height
			 Easily measured at home
			 Low cost and fast

#BMI is calculated as:
             BMI (Metric) = weight (kg)/height (m)^2

#Given its accessibility and its association with blood pressure, BMI is a useful screening-level predictor in wellness settings.

#Predicting Systolic Blood Pressure (SBP) from BMI
#Step 1: Confirm Correlation

cor(EmployeeBiometric.df$BMIMetric,
    EmployeeBiometric.df$SBPmmHg,
    use = "complete.obs",
    method = "pearson")

#Output
[1] 0.247134

#Interpretation:
             Weak-to-moderate positive association
             Sufficient to justify regression

#Step 2: Fit Simple Linear Regression Model
lm(SBPmmHg ~ BMIMetric, data = EmployeeBiometric.df)   

#lm() stands for Linear Model.
#It is the base R function used to fit linear regression models.
#lm() models the relationship between:
             a continuous outcome variable (dependent variable), and
			 one or more numeric predictor variables (independent variables)

#Model form
             SBP = Intercept + (𝛽×BMI)

#From the model output:
             Intercept ≈ 103.754
             Slope (β) ≈ 0.647

#Step 3: Predict SBP for BMI = 25.00
             SBP = 103.754 + (0.647 × 25.00)
             SBP = 119.929

#Step 4: Validate Using Observed Data

#Select individuals with BMI approximately equal to 25.00:

RcmdrMisc::numSummary(
EmployeeBiometric.df$SBPmmHg[
EmployeeBiometric.df$BMIMetric >= 24.95 &
EmployeeBiometric.df$BMIMetric <= 25.05])

summary(
EmployeeBiometric.df$SBPmmHg[
EmployeeBiometric.df$BMIMetric >= 24.95 &
EmployeeBiometric.df$BMIMetric <= 25.05])


#Observed SBP summary
| Statistic | Value   |
| --------- | ------- |
| Mean      | **118** |
| Median    | 115     |
| Range     | 100–152 |
| NA values | 23      |


#Conclusion:
             Predicted SBP ≈ 120
             Observed mean SBP ≈ 118
             Prediction is reasonable and realistic

#Predicting Diastolic Blood Pressure (DBP) from BMI
#Step 1: Confirm Correlation
cor(EmployeeBiometric.df$BMIMetric,
    EmployeeBiometric.df$DBPmmHg,
    use = "complete.obs",
    method = "pearson")

#Output
[1] 0.247427

#Step 2: Fit Linear Regression Model
lm(DBPmmHg ~ BMIMetric, data = EmployeeBiometric.df)

#Coefficients
             Intercept ≈ 56.972
             Slope (β) ≈ 0.446

#Step 3: Predict DBP for BMI = 25.00
             DBP = 56.972 + (0.446 × 25.00)
             DBP = 68.122

#Step 4: Validate Using Observed Data
RcmdrMisc::numSummary(
EmployeeBiometric.df$DBPmmHg[
EmployeeBiometric.df$BMIMetric >= 24.95 &
EmployeeBiometric.df$BMIMetric <= 25.05])

summary(
EmployeeBiometric.df$DBPmmHg[
EmployeeBiometric.df$BMIMetric >= 24.95 &
EmployeeBiometric.df$BMIMetric <= 25.05])


#Observed DBP summary
| Statistic | Value    |
| --------- | -------- |
| Mean      | **67.1** |
| Median    | 67       |
| Range     | 44–88    |
| NA values | 23       |


#Conclusion:
             Predicted DBP ≈ 68
             Observed mean DBP ≈ 67
             Prediction aligns well with real data
			 
################################################################################################
#Linear Regression Using Multiple Predictor Variables
#####################################################
#Moving beyond simple linear regression, multiple linear regression allows prediction of an outcome variable using two or more predictor variables.
#In this section, Systolic Blood Pressure (SBP) and Diastolic Blood Pressure (DBP) are used together to predict Body Mass Index (BMI).

#This approach is useful when:
             Predictors are jointly associated with the outcome
             Each predictor contributes independent information

#Model Specification
#The general multiple linear regression model is:
             𝑌 = 𝛽0 + 𝛽1𝑋1 + 𝛽2𝑋2


#For this example:
             BMIMetric = 𝛽0 + (𝛽1×SBPmmHg) + (𝛽2×DBPmmHg)
	​

#Step 1: Fit the Multiple Linear Regression Model
lm(formula = BMIMetric ~ SBPmmHg + DBPmmHg,
   data = EmployeeBiometric.df)

#Model Output
Coefficients:
(Intercept)  SBPmmHg  DBPmmHg
13.7115     0.0629   0.0916

#Interpretation of Coefficients
     Intercept (13.7115)
         Estimated BMI when SBP and DBP are zero (theoretical reference point)
     SBP coefficient (0.0629)
         Each 1-mmHg increase in SBP is associated with a 0.063 increase in BMI, holding DBP constant
     DBP coefficient (0.0916)
         Each 1-mmHg increase in DBP is associated with a 0.092 increase in BMI, holding SBP constant

#Step 2: Predict BMI for Given Blood Pressure Values

#Given:
             SBP = 124
             DBP = 76

BMIMetric = 13.7115 + (0.0629 × 124) + (0.0916 × 76)
BMIMetric = 13.7115 + 7.7996 + 6.9616
BMIMetric = 28.4727

             Predicted BMI ≈ 28.5

#Step 3: Validate Prediction Using Observed Data

#Select individuals with approximately the same SBP and DBP values:

RcmdrMisc::numSummary(
EmployeeBiometric.df$BMIMetric[
EmployeeBiometric.df$SBPmmHg >= 123.95 &
EmployeeBiometric.df$SBPmmHg <= 124.05 &
EmployeeBiometric.df$DBPmmHg >= 75.95 &
EmployeeBiometric.df$DBPmmHg <= 76.05])

#Observed BMI Summary
| Statistic       | Value         |
| --------------- | ------------- |
| Mean            | **30.30**     |
| Median          | 30.30         |
| Range           | 19.77 – 44.39 |
| Sample size (n) | 15            |
| NA values       | 209           |

#Conclusion
             Predicted BMI ≈ 28.5
			 Observed mean BMI ≈ 30.3
			 Prediction is reasonable and plausible
			 Differences reflect:
			     Biological variability
				 Measurement noise
				 Limited sample size in narrow BP ranges
################################################################################################
#Ordinal Logistic Regression
############################
#Why Ordinal Logistic Regression?

#BMIStatus is an ordinal outcome variable with four ordered categories:
| Code | BMI Range     | Category      |
| ---- | ------------- | ------------- |
| 1    | BMI ≤ 18.599  | Underweight   |
| 2    | 18.600–24.999 | Normal Weight |
| 3    | 25.000–29.999 | Overweight    |
| 4    | BMI ≥ 30.000  | Obese         |


             Categories are ordered
			 Distances between categories are not equal
			 Linear regression is not appropriate
			 Ordinal logistic regression models cumulative probabilities across ordered categories

#Goal of the Analysis
#Using SBP and DBP as predictors, ordinal logistic regression is used to:
             Estimate odds ratios for progression across BMI categories
			 Quantify how blood pressure affects the likelihood of moving to a higher BMI group
			 Produce probability-based interpretations rather than mean predictions

#Descriptive Statistics by BMI Category
#######################################
#SBP and DBP by BMIStatus
RcmdrMisc::numSummary(
EmployeeBiometric.df[,c("SBPmmHg","DBPmmHg")],
groups = EmployeeBiometric.df$BMIStatus)

#Visualizing Trends Across BMI Categories

#To visualize how blood pressure changes across BMIStatus:

install.packages("gplots", dependencies = TRUE)
library(gplots)
help(package = gplots)
sessionInfo()

par(ask = TRUE)
par(mfrow = c(1,2))

gplots::plotmeans(EmployeeBiometric.df$SBPmmHg ~
EmployeeBiometric.df$BMIStatus,
main = "Mean Systolic Blood Pressure by BMI Category",
pch = 22, cex = 10, lwd = 3, col = "red",
ylim = c(105,135),
xlab = "BMI Category",
ylab = "Mean SBP (mmHg)")

##################################################
#####Warning message (example)
zero-length arrow is of indeterminate angle and so skipped

#Why this happens
             plotmeans() draws error bars (confidence intervals) using arrows
             This warning appears when:
                 the lower and upper CI are equal, or
				 there is only one observation in a group, or
				 the variance is zero within a BMI category
             In such cases, the arrow has zero length, so R skips drawing it.

#Is this a problem? ❌ No — this is NOT an error
###################################################

gplots::plotmeans(EmployeeBiometric.df$DBPmmHg ~
EmployeeBiometric.df$BMIStatus,
main = "Mean Diastolic Blood Pressure by BMI Category",
pch = 22, cex = 10, lwd = 3, col = "blue",
ylim = c(60,80),
xlab = "BMI Category",
ylab = "Mean DBP (mmHg)")


#Observation:
             SBP and DBP increase monotonically from Underweight → Obese
             Trends are consistent with prior correlation results

#Handling Missing Data
#Ordinal regression requires complete cases for all variables involved.

EmployeeBiometric4.df <-
EmployeeBiometric.df[complete.cases(EmployeeBiometric.df), ]

attach(EmployeeBiometric4.df)

nrow(EmployeeBiometric.df)

[1] 3945

nrow(EmployeeBiometric4.df)

[1] 2877

#Confirm Removal of Missing Values
round(summary(EmployeeBiometric4.df$SBPmmHg))
round(summary(EmployeeBiometric4.df$DBPmmHg))


#Result:
             No remaining NA values for SBP or DBP.


#Ordinal Logistic Regression Using MASS::polr()
###############################################
#Step 1: Fit the Model
install.packages("MASS", dependencies = TRUE)
library(MASS)
help(package = MASS)
sessionInfo()

BMIBreakouts.plr <-
MASS::polr(BMIStatus ~ SBPmmHg + DBPmmHg,
data = EmployeeBiometric4.df,
Hess = TRUE)

summary(BMIBreakouts.plr)


| Term    | Estimate | Std. Error | t value |
| ------- | -------- | ---------- | ------- |
| SBPmmHg | 0.0178   | 0.00221    | 8.04    |
| DBPmmHg | 0.0236   | 0.00312    | 7.57    |

#Step 2: Extract Coefficients
BMIBreakouts.Coefficients <-
coef(summary(BMIBreakouts.plr))

BMIBreakouts.Coefficients

                               Value  Std. Error   t value
SBPmmHg                   0.01777865 0.002210775  8.041816
DBPmmHg                   0.02360505 0.003117739  7.571210
Underweight|Normal Weight 0.53623817 0.264215530  2.029548
Normal Weight|Overweight  3.36877206 0.260227497 12.945488
Overweight|Obese          4.63108730 0.267233377 17.329749

#Step 3: Compute p-values
BMIBreakouts.p <-
pnorm(abs(BMIBreakouts.Coefficients[,"t value"]),
lower.tail = FALSE * 2)

format(BMIBreakouts.p, scientific = TRUE)

#Step 4: Combine Coefficients and p-values
BMIBreakouts.CoefficientsAndpvalues <-
cbind(BMIBreakouts.Coefficients,
"p value" = BMIBreakouts.p)

format(BMIBreakouts.CoefficientsAndpvalues,
scientific = TRUE)


#Key Result:
             SBP and DBP are highly significant predictors of BMI category

#Step 5: Confidence Intervals
BMIBreakouts.ci <- confint(BMIBreakouts.plr)

BMIBreakouts.ci

#Step 6: Odds Ratios (Proportional Odds)
BMIBreakouts.OddsRatio <-
exp(cbind(OddsRatio = coef(BMIBreakouts.plr)))

BMIBreakouts.OddsRatio
| Predictor | Odds Ratio  |
| --------- | ----------- |
| SBPmmHg   | **1.01794** |
| DBPmmHg   | **1.02389** |

#Interpretation of Odds Ratios
     These are proportional odds ratios, meaning:
         SBP
             Each 1-mmHg increase multiplies the odds of moving to a higher BMI category by 1.018
         DBP
             Each 1-mmHg increase multiplies the odds of moving to a higher BMI category by 1.024

#This applies across all thresholds:
             Underweight → Normal
			 Normal → Overweight
			 Overweight → Obese

#From Odds Ratios to Probabilities (Improving Interpretability)
##############################################################

#An important implication in biostatistics is that small changes in one variable (e.g., weight gain reflected in BMI) may be associated with noticeable changes in other variables, such as Systolic (SBP) and Diastolic Blood Pressure (DBP). 
#Elevated blood pressure is well known to be linked to broader wellness concerns.

#While odds ratios are statistically precise, they are often difficult for non-specialists to interpret. 
#Terms like probability and likelihood are frequently (and incorrectly) used in place of odds. 
#To improve communication—especially for public or applied audiences—predicted probabilities are added and visualized.

#Step 1: Add Predicted Probabilities to the Dataframe

#Using the fitted ordinal logistic regression model (BMIBreakouts.plr), predicted probabilities for each BMI category are added as new variables.

EmployeeBiometric4.df <- cbind(
  EmployeeBiometric4.df,
  predict(BMIBreakouts.plr, EmployeeBiometric4.df, type = "probs")
)

attach(EmployeeBiometric4.df)
str(EmployeeBiometric4.df)


#Result:
#Four new columns are added:
             Underweight
			 Normal Weight
			 Overweight
			 Obese

#Each row now contains probabilities (0–1) for BMI category membership.

#Step 2: Rename Column with Space (Quality Assurance)

#Spaces in variable names can cause problems in R.
#Rename Normal Weight to Normal.

names(EmployeeBiometric4.df)[12] <- "Normal"
attach(EmployeeBiometric4.df)
names(EmployeeBiometric4.df)
match("Normal", names(EmployeeBiometric4.df))


#Confirmation output:
Normal is column 12.

#Step 3: Probability of BMI Categories by Systolic Blood Pressure
par(ask = TRUE)
par(mfrow = c(2,2))

plot(Underweight, SBPmmHg,
     main = "Probability of Underweight by SBP",
     col = "red", xlim = c(0,1),
     xlab = "Probability (0.00 to 1.00)", ylab = "SBP")

plot(Normal, SBPmmHg,
     main = "Probability of Normal Weight by SBP",
     col = "red", xlim = c(0,1),
     xlab = "Probability (0.00 to 1.00)", ylab = "SBP")

plot(Overweight, SBPmmHg,
     main = "Probability of Overweight by SBP",
     col = "red", xlim = c(0,1),
     xlab = "Probability (0.00 to 1.00)", ylab = "SBP")

plot(Obese, SBPmmHg,
     main = "Probability of Obese by SBP",
     col = "red", xlim = c(0,1),
     xlab = "Probability (0.00 to 1.00)", ylab = "SBP")

#Interpretation (SBP)
             Probability of Underweight ↑ as SBP decreases
			 Probability of Normal Weight ↑ as SBP decreases
			 Overweight shows no clear monotonic trend
			 Probability of Obese ↑ as SBP increases

#Step 4: Probability of BMI Categories by Diastolic Blood Pressure
par(ask = TRUE)
par(mfrow = c(2,2))

plot(Underweight, DBPmmHg,
     main = "Probability of Underweight by DBP",
     col = "red", xlim = c(0,1),
     xlab = "Probability (0.00 to 1.00)", ylab = "DBP")

plot(Normal, DBPmmHg,
     main = "Probability of Normal Weight by DBP",
     col = "red", xlim = c(0,1),
     xlab = "Probability (0.00 to 1.00)", ylab = "DBP")

plot(Overweight, DBPmmHg,
     main = "Probability of Overweight by DBP",
     col = "red", xlim = c(0,1),
     xlab = "Probability (0.00 to 1.00)", ylab = "DBP")

plot(Obese, DBPmmHg,
     main = "Probability of Obese by DBP",
     col = "red", xlim = c(0,1),
     xlab = "Probability (0.00 to 1.00)", ylab = "DBP")

#Interpretation (DBP)
             Probability of Underweight ↑ as DBP decreases
			 Probability of Normal Weight ↑ as DBP decreases
			 Overweight again shows no clear trend
			 Probability of Obese ↑ as DBP increases

################################################################################################
#Binary Logistic Regression
###########################
#BMI is calculated from height and weight using:
             Body Mass Index (BMI) = kg / m^2

	​
#When measured correctly:
             BMI is an interval-scale variable
             Demonstrates good reliability and validity in health sciences

#Why Collapse BMI Categories?
     Exact BMI values (e.g., 19.786 vs 25.529) are:
             Difficult for the general public to interpret
     BMI is often collapsed into ordinal categories:
             Underweight
			 Normal Weight
			 Overweight
			 Obese
     This improves interpretability, but reduces precision

#From Ordinal to Binary BMI
     Even ordinal BMI categories raise questions:
             Where does Normal Weight end?
             Who defined the cutpoints?

     To simplify interpretation, BMI is often collapsed into binary categories:
             Not Obese
             Obese
     Binary categories are intuitive (e.g., Pass/Fail, Alive/Dead)

#Purpose of Binary Logistic Regression
     Used when the outcome variable is binary
     In this lesson, binary logistic regression is used to:
             Estimate Odds Ratios
             Estimate Predicted Probabilities
     Predictors:
             Systolic Blood Pressure (SBP)
             Diastolic Blood Pressure (DBP)
     Outcome:
             Obesity (Not Obese vs Obese)

#Descriptive Statistics by Obesity Status
RcmdrMisc::numSummary(
  EmployeeBiometric4.df[, c("SBPmmHg", "DBPmmHg")],
  groups = Obesity
)

#Descriptive Statistics by Obesity Status
#Systolic Blood Pressure (SBP)
| Obesity Status | Mean  | Median |
| -------------- | ----- | ------ |
| Not Obese      | 119.5 | 116    |
| Obese          | 126.6 | 126    |

Diastolic Blood Pressure (DBP)
| Obesity Status | Mean | Median |
| -------------- | ---- | ------ |
| Not Obese      | 67.8 | 68     |
| Obese          | 72.8 | 74     |


#Key observation:
             Both SBP and DBP increase when moving from Not Obese → Obese

#Visualization of Group Differences
###################################

#Use gplots::plotmeans() to confirm trends visually


par(ask = TRUE)
par(mfrow = c(1, 2))

gplots::plotmeans(EmployeeBiometric.df$SBPmmHg ~ EmployeeBiometric.df$Obesity,
  main = "Mean Systolic Blood Pressure by Obesity",
  pch = 22, cex = 10, lwd = 3, col = "red",
  ylim = c(115, 130),
  cex.axis = 0.75,
  xlab = "Obesity",
  ylab = "Mean Systolic Blood Pressure (mmHg)"
)

gplots::plotmeans(EmployeeBiometric.df$DBPmmHg ~ EmployeeBiometric.df$Obesity,
  main = "Mean Diastolic Blood Pressure by Obesity",
  pch = 22, cex = 10, lwd = 3, col = "blue",
  ylim = c(65, 75),
  cex.axis = 0.75,
  xlab = "Obesity",
  ylab = "Mean Diastolic Blood Pressure (mmHg)"
)


#Dataset for Binary Logistic Regression
#######################################
#Regression requires paired X and Y values
#Missing values cause problems
#Solution:
         Use EmployeeBiometric4.df
         Contains complete cases only
#Result:
         No missing data interfere with model estimation


#Binary Logistic Regression (SBP & DBP → Obesity)
#################################################
#Binary logistic regression is used when the outcome variable has two categories:
             Not Obese
             Obese

#In this analysis:
     Predictors:
             Systolic Blood Pressure (SBPmmHg)
			 Diastolic Blood Pressure (DBPmmHg)

     Outcome:
             Obesity status (Not Obese vs Obese)

     Goals:
             Estimate Odds Ratios (ORs) for SBP and DBP
			 Understand how blood pressure relates to obesity status
			 Later visualize predicted probabilities

#Model Used
###########
#The glm() function from the stats package is used
             glm = Generalized Linear Model

#In R, glm() is a function used to fit regression models when:
             The outcome variable is NOT continuous, or
			 The relationship is not well modeled by simple linear regression
			 
#Logistic regression is specified using:
             family = "binomial"


# Step 1 Binary Logistic Regression: Build a Binary Logistic
# Regression Prediction Model
Obesity.glm <- glm(Obesity ~ SBPmmHg + DBPmmHg,
                   data = EmployeeBiometric4.df,
                   family = "binomial")

# Use the glm() function to develop a model for the binary object variable Obesity (1 = Not Obese and 2 = Obese) in view of SBPmmHg and DBPmmHg:
             1 BMI <= 29.999 Not Obese
             2 BMI >= 30.000 Obese

summary(Obesity.glm)


#Key output interpretation
     Both predictors are highly statistically significant (p < 0.001):
             SBPmmHg ***
             DBPmmHg ***
     This indicates a strong association between blood pressure and obesity status

# Step 2 Binary Logistic Regression: Prepare an Odds Ratio
# Table for the Predictor Variables
exp(coef(Obesity.glm))


#Odds Ratio Output
(Intercept)  SBPmmHg   DBPmmHg
0.0187415    1.0138574 1.0217749

#Interpretation of Odds Ratios
             Odds Ratios are proportional odds for continuous predictors

#SBPmmHg
             A 1 mmHg increase in SBP:
                 Multiplies the odds of moving from Not Obese → Obese by 1.0139

#DBPmmHg
             A 1 mmHg increase in DBP:
                 Multiplies the odds of moving from Not Obese → Obese by 1.0218

#Visualization of Binary Logistic Regression Results
####################################################

#Probability of Obesity by Systolic Blood Pressure (SBP)
library(ggplot2)

ObesitybySystolicProbability <-
ggplot2::ggplot(EmployeeBiometric4.df,
aes(SBPmmHg, as.numeric(Obesity)-1)) +
stat_smooth(method="glm", formula=y~x, size=3) +
ggtitle("
Probability of Obesity by Systolic Blood Pressure (mmHg)\n") +
labs(
x = "\nSystolic Blood Pressure (mmHg)",
y = "Probability of Obesity (0.00 to 1.00)\n") +
scale_x_continuous(labels=scales::comma, limits=c(0,250),
breaks=seq(0,250, by=25)) +
scale_y_continuous(limits=c(0,1), expand=c(0,0)) +
theme_bw()


#Important coding note
             as.numeric(Obesity) - 1:
                 Converts factor levels (1 = Not Obese, 2 = Obese)
                 Into binary values 0 and 1, required for probability plotting

#Probability of Obesity by Diastolic Blood Pressure (DBP)

ObesitybyDiastolicProbability <-
ggplot2::ggplot(EmployeeBiometric4.df,
aes(DBPmmHg, as.numeric(Obesity)-1)) +
stat_smooth(method="glm", formula=y~x, size=3) +
ggtitle("
Probability of Obesity by Diastolic Blood Pressure (mmHg)\n") +
labs(
x = "\nDiastolic Blood Pressure (mmHg)",
y = "Probability of Obesity (0.00 to 1.00)\n") +
scale_x_continuous(labels=scales::comma, limits=c(0,250),
breaks=seq(0,250, by=25)) +
scale_y_continuous(limits=c(0,1), expand=c(0,0)) +
theme_bw()

#Side-by-Side Comparison of SBP and DBP
gridExtra::grid.arrange(
ObesitybySystolicProbability,
ObesitybyDiastolicProbability, ncol=2)

################################################################################################
#Core Concepts Revisited
########################

#Correlation analysis (Pearson’s r and Spearman’s ρ) was used to measure the strength and direction of association between variables such as Systolic Blood Pressure (SBP), Diastolic Blood Pressure (DBP), and Body Mass Index (BMI).

#Correlation provides evidence of association, not causation. Even statistically significant relationships do not imply that one variable causes another.

#Regression Models Applied
###########################

#Building on correlation results, several regression approaches were introduced:

#1. Simple Linear Regression
Used to predict a continuous outcome (e.g., SBP or DBP) from a single predictor (e.g., BMI).

#2. Multiple Linear Regression
Extended prediction to include multiple predictors simultaneously (e.g., SBP and DBP used together to estimate BMI).

#3. Ordinal Logistic Regression
Applied when the outcome variable is ordered but not interval-scaled (e.g., BMI categories: Underweight → Normal → Overweight → Obese).

#4. Binary Logistic Regression
Used when outcomes are reduced to two categories (e.g., Not Obese vs. Obese), allowing estimation of odds ratios and predicted probabilities.

#Summary
| Model Type                  | Outcome Variable | Predictor(s) | R Function               |
| --------------------------- | ---------------- | ------------ | ------------------------ |
| Simple Linear Regression    | Continuous       | 1 numeric    | `lm()`                   |
| Multiple Linear Regression  | Continuous       | ≥2 numeric   | `lm()`                   |
| Ordinal Logistic Regression | Ordered factor   | Numeric      | `MASS::polr()`           |
| Binary Logistic Regression  | Binary factor    | Numeric      | `glm(family="binomial")` |

#Interpretation and Communication
#################################

#Odds ratios describe how changes in predictors affect the odds of moving between outcome categories, but they can be difficult for non-technical audiences to interpret.

#Predicted probabilities and graphical summaries provide a more intuitive way to communicate results, especially in public health and applied settings.

#Practical Perspective
######################

#Regression models are most useful when:
             There is a meaningful association between predictors and outcomes.
			 Model assumptions are understood and respected.
			 Results are interpreted in context, not in isolation.

#Easily obtained measures (such as BMI) can sometimes be used as low-cost screening tools to estimate more complex or resource-intensive measures (such as blood pressure), while recognizing their limitations.

################################################################################################


