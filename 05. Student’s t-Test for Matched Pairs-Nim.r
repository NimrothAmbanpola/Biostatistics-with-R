###############################################################
# Master in Biochemistry and Biotechnology – Semester I 
# Topic : Student’s t-Test for Matched Pairs -5
# Course: BCBT 54813 - Biostatistics
# Author: Nimroth Ambanpola
##############################################################

#Befor we continue the project......
getwd()#To check working directory
sessionInfo()#To confirm the R version and to gain information on the locale and available packages.

#Student’s t-Test for Matched Pairs
###################################

#A classic example of a matched-pairs design is a pretest–posttest experiment, where:
             A subject is measured before a treatment (pretest)
			 A treatment is applied
			 The same subject is measured again after the treatment(posttest)

             Pretest → Treatment → Posttest

#The defining characteristics of a matched-pairs analysis are:
             The same individuals are measured twice
			 Observations are paired at the subject level, not merely grouped into categories

#Because of this structure, careful subject tracking is essential so that pretest and posttest measurements are correctly matched for each individual.


#Example
########
#This lesson examines whether there is a statistically significant difference (p ≤ 0.05) in the weight (kg) of individual biological specimens before and after the introduction of a mineral supplement into their feeding program.

#Experimental Design
####################

#Pretest:
             Each subject was weighed on the same day
			 Measurement recorded as: KgPreSupplement

#Treatment:
             A mineral supplement was added to the feeding program
             The supplement was:
                 * Tasteless
				 * Odorless
                 * Texture-neutral
                 * Assumed not to affect feed palatability
             Treatment conditions were identical for all subjects

#Posttest:
             Each subject was weighed again after a fixed (but unspecified) period
             Measurement recorded as: KgPostSupplement

#No breakout groups were used:
             No grouping by gender, size, breed, or other traits
             No variation in treatment strength or duration

#Thus, each subject forms a matched pair with two measurements:
             Weight before treatment
             Weight after treatment


#Sample Size and Missing Data
#############################
#The dataset contains measurements for 150 subjects, making it a relatively large matched-pairs dataset.

#However, there is one missing posttest observation(Subject 19).

#Missing data are common in real-world biological studies and may arise due to:
             Subject unavailability
			 Death
			 Recording or measurement errors
			 Data loss or data entry mistakes

#Although missing data are undesirable, they must be identified, acknowledged, and handled appropriately during statistical analysis.


#Choice of Statistical Test
###########################
#Given the structure of the data and the experimental design, Student’s t-Test for Matched Pairs is an appropriate inferential method to test whether there is a statistically significant difference (p ≤ 0.05)between:
             KgPreSupplement
			 KgPostSupplement

#################################################################################################
#Import Data in Comma-Separated Values (.csv) File
PrePostWtUnstack.df <- read.table (file =
"WeightPrePostSupplementUnstacked.csv",
header = TRUE,
sep = ",")

str(PrePostWtUnstack.df) # Identify structure
nrow(PrePostWtUnstack.df) # List the number of rows
ncol(PrePostWtUnstack.df) # List the number of columns
dim(PrePostWtUnstack.df) # Dimensions of the dataframe
names(PrePostWtUnstack.df) # Identify names
colnames(PrePostWtUnstack.df) # Show column names
rownames(PrePostWtUnstack.df) # Show row names
head(PrePostWtUnstack.df) # Show the head
tail(PrePostWtUnstack.df) # Show the tail
PrePostWtUnstack.df # Show the entire dataframe
summary(PrePostWtUnstack.df) # Summary statistics
duplicated(PrePostWtUnstack.df) # Check for duplicates

#Variable Types and Recoding
############################
#Before statistical analysis, it is important to ensure that all variables in the dataset are stored in the correct format.
| Variable         | Initial Type | Final Type |
| ---------------- | ------------ | ---------- |
| Subject          | Integer      | Factor     |
| KgPreSupplement  | Numeric      | Numeric    |
| KgPostSupplement | Numeric      | Numeric    |

PrePostWtUnstack.df$Subject <- as.factor(PrePostWtUnstack.df$Subject)
PrePostWtUnstack.df$KgPreSupplement <- as.numeric(PrePostWtUnstack.df$KgPreSupplement)
PrePostWtUnstack.df$KgPostSupplement <- as.numeric(PrePostWtUnstack.df$KgPostSupplement)

#The Subject variable is converted from integer to factor rather than being used as row names, to clearly represent subject identifiers.

#The KgPreSupplement and KgPostSupplement variables are confirmed as numeric to ensure compatibility with Student’s t-Test.

attach(PrePostWtUnstack.df) # Attach the data, for later use
str(PrePostWtUnstack.df) # Identify structure
nrow(PrePostWtUnstack.df) # List the number of rows
ncol(PrePostWtUnstack.df) # List the number of columns
dim(PrePostWtUnstack.df) # Dimensions of the dataframe
names(PrePostWtUnstack.df) # Identify names
colnames(PrePostWtUnstack.df) # Show column names
rownames(PrePostWtUnstack.df) # Show row names
head(PrePostWtUnstack.df) # Show the head
tail(PrePostWtUnstack.df) # Show the tail
PrePostWtUnstack.df # Show the entire dataframe
summary(PrePostWtUnstack.df) # Summary statistics

#################################################################################################
#Essential Steps After Importing Data into R (Before Conducting Statistical Tests)
##################################################################################

#Step 1: Confirm the Data Were Imported Correctly
#Purpose: Ensure the dataset exists and is readable.

ls()                         # List objects in the workspace
class(PrePostWtUnstack.df)   # Confirm object type

✔ Dataset appears in the workspace
✔ Object type is correct (data.frame)

#Step 2: Inspect the Structure of the Dataset
#Purpose: Verify variable types and dimensions.

str(PrePostWtUnstack.df)     # Structure of the dataset
dim(PrePostWtUnstack.df)     # Rows × columns
nrow(PrePostWtUnstack.df)    # Number of subjects
ncol(PrePostWtUnstack.df)    # Number of variables

✔ Numeric variables are numeric
✔ Grouping variables are factors
✔ Expected number of observations present

#Step 3: Check Variable Names and Labels
#Purpose: Ensure variables are correctly named and identifiable.

names(PrePostWtUnstack.df)
colnames(PrePostWtUnstack.df)

✔ Names are meaningful
✔ No duplicated or confusing labels

#Step 4: Verify Data Types (Factor vs Numeric)
#Purpose: Statistical tests depend on correct data types.

class(PrePostWtUnstack.df$Subject)
class(PrePostWtUnstack.df$KgPreSupplement)
class(PrePostWtUnstack.df$KgPostSupplement)

#Typical expectations:
             Grouping variables → factor
             Measured variables → numeric

#Step 5: Check for Duplicate Observations (If Applicable)
#Purpose: Avoid double-counting subjects.

duplicated(PrePostWtUnstack.df$Subject)

✔ No unexpected duplicates
✔ Especially important for matched-pairs designs

#Step 6: Check for Missing Data
#Purpose: Missing data affect test validity and sample size.

table(is.na(PrePostWtUnstack.df))
table(complete.cases(PrePostWtUnstack.df))

✔ Identify which variables contain missing values
✔ Decide how missing data will be handled

#Step 7: Handle Missing Data Appropriately
#Purpose: Ensure consistent sample size across analyses.

#For Student’s t-Test for Matched Pairs:
             Subjects with missing pretest or posttest values must be excluded

PrePostWt_complete.df <-
  PrePostWtUnstack.df[complete.cases(PrePostWtUnstack.df), ]

✔ Only complete subject pairs retained for analysis

#Step 8: Generate Descriptive Statistics
#Purpose: Understand the data before testing.

summary(PrePostWt_complete.df)

mean(PrePostWt_complete.df$KgPreSupplement)
sd(PrePostWt_complete.df$KgPreSupplement)

mean(PrePostWt_complete.df$KgPostSupplement)
sd(PrePostWt_complete.df$KgPostSupplement)

✔ Central tendency and variability understood
✔ No implausible values detected

#Step 9: Visualize the Data (Exploratory Plots)
#Purpose: Detect skewness, outliers, and distribution shape.

#Common plots: Histogram, Density plot, Boxplot, Q–Q plot

hist(PrePostWt_complete.df$KgPreSupplement)
hist(PrePostWt_complete.df$KgPostSupplement)

boxplot(PrePostWt_complete.df$KgPreSupplement,
        PrePostWt_complete.df$KgPostSupplement,
        names = c("Pretest", "Posttest"))

qqnorm(PrePostWt_complete.df$KgPostSupplement -
       PrePostWt_complete.df$KgPreSupplement)
qqline(PrePostWt_complete.df$KgPostSupplement -
       PrePostWt_complete.df$KgPreSupplement)


✔ Identify non-normality
✔ Detect extreme outliers

#Step 10: Check Sample Size and Group Balance
#Purpose: Choose an appropriate statistical test.

nrow(PrePostWt_complete.df)

✔ Sample size is large (≈150 subjects)
✔ Supports use of Student’s t-Test


#Step 11: Assess Normality (Overall and by Group)
#Purpose: Decide between parametric and non-parametric tests.

Diff <- PrePostWt_complete.df$KgPostSupplement -
        PrePostWt_complete.df$KgPreSupplement

shapiro.test(Diff)

✔ Normality assessed on within-subject differences, not raw scores

#Step 12: Confirm Study Design
#Purpose: Ensure correct test selection.

#Key design features:
             One group of subjects
			 Same subjects measured twice
			 Pretest–posttest structure

✔ Design is matched pairs
✔ Independent-samples tests are not appropriate

#Step 13: State Hypotheses Clearly
#Purpose: Purpose: Avoid post-hoc interpretation errors.

H₀: There is no difference between pretest and posttest weights

H₁: A difference exists between pretest and posttest weights

#Significance level:
             α = 0.05 (defined before testing)

#Step 14: Choose and Conduct the Statistical Test

#Based on:
             Data type
			 Normality
			 Sample size
			 Group balance
			 Study design
			 
#Final test selection:Student’s t-Test for Matched Pairs

t.test(PrePostWt_complete.df$KgPreSupplement,
       PrePostWt_complete.df$KgPostSupplement,
       paired = TRUE)
	   
	   
#################################################################################################
#Student’s t-Test for Matched Pairs
###################################

#Null Hypothesis

#H₀ (Null Hypothesis):
#There is no statistically significant difference (p ≤ 0.05) between the pretest weight (kg) and the posttest weight (kg) of unidentified adult biological specimens at the end of a feeding experiment in which a tasteless and odorless mineral supplement was introduced into the feeding program.

#In other words, any observed difference between pretest and posttest weights is assumed to be due to random variation unless sufficient statistical evidence suggests otherwise.


#Unstacked (Wide) Data and Stacked (Long) Data
###############################################
#There are two common ways to organize data for a Student’s t-Test analysis in R:
             Unstacked data (wide format)
			 Stacked data (long format)

#Understanding the difference between these formats is important because the structure of the data determines how the t-test is specified in R.


#Unstacked Data (Wide Format)
#############################
#Unstacked data store each measurement condition in a separate column.
#In this example, the dataset is unstacked because:
             Pretest weights and posttest weights are stored in two different columns
             Each row represents one subject

| Subject | KgPreSupplement | KgPostSupplement |
| ------- | --------------- | ---------------- |
| 1       | 62.4            | 63.1             |
| 2       | 58.9            | 59.5             |
| 3       | 61.0            | 61.8             |


#Characteristics:
             One row per subject
             One column per measurement time
			 Common for pretest–posttest designs
			 
#In R, Student’s t-Test with unstacked data is conducted by listing the two columns separated by a comma.

#General form:
t.test(Column1, Column2)

Example:
t.test(PrePostWt_complete.df$KgPreSupplement,
       PrePostWt_complete.df$KgPostSupplement,
       paired = TRUE)

Important notes:
- Unstacked data use a comma ( , ), not a tilde ( ~ )
- Additional arguments may be included, such as:
  * paired = TRUE or paired = FALSE
  * na.rm = TRUE to handle missing data


#Stacked Data (Long Format)
##########################
#Stacked data place all measured values into a single column, with another column indicating when or under which condition each measurement was taken.

#The same data in stacked format would look like this:

| Subject | TimePoint | WeightKg |
| ------- | --------- | -------- |
| 1       | Pretest   | 62.4     |
| 1       | Posttest  | 63.1     |
| 2       | Pretest   | 58.9     |
| 2       | Posttest  | 59.5     |
| 3       | Pretest   | 61.0     |
| 3       | Posttest  | 61.8     |


#Characteristics:
             Multiple rows per subject
			 One column for measurements
			 One column identifying condition (Pretest/Posttest)
			 Common in biological sciences and data visualization
			 Uses tilde (~) syntax in many R functions

#Stacked (long) format is very common in biological and ecological research and is often preferred for data storage and visualization.


#Using R with Stacked Data

#When data are in stacked format, Student’s t-Test in R is specified using a tilde ( ~ ) to separate the measured variable from the grouping variable.

#General form:
t.test(Measured.Variable ~ Grouping.Variable)

#Example:
t.test(WeightKg ~ TimePoint)

#Important notes:
             Stacked data use a tilde ( ~ ), not a comma ( , )
			 Additional arguments can be added, such as:
                 * na.rm = TRUE for missing data
				 * paired = TRUE when the data represent matched pairs


#Relationship Between Stacked and Unstacked Data

#Stacked and unstacked datasets contain the same information, but arranged differently.
             Unstacked → Stacked: Data are stacked into a single measurement column
             Stacked → Unstacked: Data are unstacked back into separate columns

#R provides two functions to move between these formats:
             stack() converts unstacked data into stacked format
             unstack() converts stacked data into unstacked format


#Important Syntax Rule for Unstacked Data
########################################

#When using unstacked (wide) data, the two measured variables represent their own groups. Therefore:
             A comma ( , ) must be used in t.test()
             A tilde ( ~ ) must NOT be used

#Common Syntax Error (Demonstration)
# Incorrect use of ~ with unstacked data
t.test(
  PrePostWtUnstack.df$KgPreSupplement ~
  PrePostWtUnstack.df$KgPostSupplement,
  paired = TRUE,
  na.rm = TRUE
)


#Error message produced by R:

Error in t.test.formula(...):
grouping factor must have exactly 2 levels

#This error occurs because the tilde syntax expects a grouping variable, which does not exist in unstacked data.

#################################################################################################
#The t.test() function from the stats package (which is loaded by default when R is installed) is used to conduct Student’s t-Test for Matched Pairs. 
#Because the data are in unstacked format, the two measured variables are provided as separate arguments and are separated by a comma, not by a tilde.

Default Paired t-Test
t.test(
  PrePostWtUnstack.df$KgPreSupplement,   # Pretest weights
  PrePostWtUnstack.df$KgPostSupplement,  # Posttest weights
  paired = TRUE,                         # Matched pairs
  na.rm = TRUE                           # Handle missing data
)


#Key points:
             paired = TRUE specifies a matched-pairs design.
             na.rm = TRUE removes incomplete pretest–posttest pairs.

#A comma is used to separate the two measured variables because the data are unstacked.

Output (excerpt):
             Paired t-test

t = -7.547
df = 148
p-value = 0.00000000000421

#################################################################################################
#Effect of Variance Assumptions
###############################

#For paired t-tests, the variance assumption does not affect the result because the test is performed on within-subject differences. 
#Nevertheless, the test can be run with explicit variance assumptions for demonstration purposes.

#Assuming Equal Variances
t.test(
  PrePostWtUnstack.df$KgPreSupplement,
  PrePostWtUnstack.df$KgPostSupplement,
  alternative = "two.sided",
  paired = TRUE,
  na.rm = TRUE,
  var.equal = TRUE
)

#Assuming Unequal Variances
t.test(
  PrePostWtUnstack.df$KgPreSupplement,
  PrePostWtUnstack.df$KgPostSupplement,
  alternative = "two.sided",
  paired = TRUE,
  na.rm = TRUE,
  var.equal = FALSE
)

#In both cases, the t-value, degrees of freedom, and p-value remain unchanged, confirming that the variance assumption is not relevant for matched-pairs designs.

#################################################################################################
#Complementary Statistical Test: Yuen’s Trimmed Mean Test for Paired Data
#########################################################################

#Although the t.test() function is a standard and powerful method for conducting Student’s t-Test for Matched Pairs, it is often good statistical practice to analyze the same dataset using a complementary test. 
#Doing so serves as a redundant data check and helps assess whether the conclusions are sensitive to assumptions about data distribution or the presence of extreme values.

#One useful complementary method is Yuen’s trimmed mean test for paired samples, implemented in R through the PairedData package. 
#This test is particularly helpful when there is concern about outliers or departures from normality, as it reduces the influence of extreme values by trimming a fixed proportion of the smallest and largest observations.

#R Setup for Yuen’s Paired Test
###############################

install.packages("PairedData", dependencies = TRUE)
library(PairedData)           # Load the PairedData package
help(package = PairedData)    # View package documentation
sessionInfo()                 # Confirm attached packages

#Conducting Yuen’s Trimmed Mean Test for Paired Samples
#######################################################
#The Yuen test is then applied to the same pretest and posttest weight variables used in the paired t-test.

PairedData::yuen.t.test(
  PrePostWtUnstack.df$KgPreSupplement,
  PrePostWtUnstack.df$KgPostSupplement,
  tr = 0.1,                    # Trim 10% from each tail
  alternative = "two.sided",
  na.rm = TRUE,
  paired = TRUE
)


#Explanation of key arguments:
             paired = TRUE specifies a matched-pairs design.
             tr = 0.1 trims 10% of the lowest and highest values, reducing the influence of extreme observations.
             na.rm = TRUE ensures incomplete pairs are excluded.

#Output (Excerpt)
             Paired Yuen test, trim = 0.1
             t = -6.911
             df = 120
             p-value = 0.000000000249


#Interpretation and Comparison with Student’s t-Test
####################################################

#The p-value obtained from Yuen’s paired test is not numerically identical to the p-value obtained from the standard paired t-test. 
#This difference is expected because the Yuen test is based on trimmed means rather than raw means.

#However, despite trimming extreme values:
             The p-value remains extremely small
             The result is well below the significance level (α = 0.05)
             The null hypothesis is rejected, just as with the paired t-test

#Thus, both methods lead to the same inferential conclusion, strengthening confidence in the result.

#Why Use Yuen’s Trimmed Mean Test?
##################################
#Yuen’s test offers several advantages:
             Reduces the influence of extreme values (outliers)
             More robust when data deviate from normality
             Useful as a quality assurance check
             Helps confirm that conclusions are not driven by a few extreme observations

#Although the data in this example do not show severe violations of normality, real biological datasets often contain outliers. I
#n such cases, Yuen’s trimmed mean test for paired samples is a reasonable and defensible alternative or complement to Student’s t-Test.

#################################################################################################
#R-Based Tools for Unstacked (Wide) Data
########################################

#Data are very often presented in unstacked (wide) format, particularly when results are shown to a general audience or reported in tables. 
#In contrast, researchers frequently prefer to work with stacked (long) format data because this structure is more flexible for statistical modeling, plotting, and advanced analyses.

#R provides several tools that allow data to be easily transformed between these two formats. 
#In this section, a simple demonstration is used to show how unstacked (wide) data can be converted into stacked (long) data.

#Creating a Sample Dataset in Unstacked (Wide) Format
#####################################################

#For demonstration purposes, a small dataset is first created in unstacked format. This dataset contains five groups (Group1 to Group5) and six measurement variables (A to F).

Addendum1Wide.df <- read.table(text = "
Group A B C D E F
Group1 0.67 0.56 0.54 0.03 -0.97 -1.09
Group2 0.52 0.43 0.51 0.05 -0.86 -0.96
Group3 0.20 0.30 0.19 0.08 0.02 0.09
Group4 -1.30 -1.13 -1.78 -0.05 -0.23 -0.23
Group5 -1.60 -1.30 -1.34 -0.23 -0.45 -0.45",
header = TRUE)


#Basic checks are then performed to confirm that the dataset was created correctly.

getwd()                  # Identify the working directory
ls()                     # List objects in the workspace
attach(Addendum1Wide.df) # Attach the data frame
Addendum1Wide.df         # Display the dataset
summary(Addendum1Wide.df)
str(Addendum1Wide.df)


#Structure of the dataset:
             5 observations (rows)
			 7 variables (Group + A–F)
			 Group is a factor
			 Variables A–F are numeric

#This confirms that the data are correctly organized in wide format, with one column per measurement variable.

#Transforming Unstacked Data into Stacked (Long) Format
#######################################################

#To convert the dataset from unstacked (wide) format into stacked (long) format, the melt() function from the reshape2 package is used. This function reshapes the data without altering the original values.

install.packages("reshape2", dependencies = TRUE)
library(reshape2)
help(package = reshape2)
sessionInfo()

#Reshaping the Data

Addendum1Long.df <- reshape2::melt(
  Addendum1Wide.df,
  id.vars = "Group"
)


#In this transformation:
             The variable Group is retained as an identifier
             The columns A–F are stacked into a single variable column
             The measured values are placed into a single value column

#The reshaped dataset is then examined.

getwd()
ls()
attach(Addendum1Long.df)
Addendum1Long.df
summary(Addendum1Long.df)
str(Addendum1Long.df)


#Structure of the stacked dataset:
             30 observations
			 3 variables:
			     Group (factor)
				 variable (A–F)
				 value (numeric measurements)

#This confirms that the data are now in long format, where each row represents a single observation.

#Visual Confirmation Using a Simple Plot
########################################

#A simple graphic is created to confirm that the data are correctly organized and usable in R. The plot is intended only for verification purposes.

ggplot2::ggplot(Addendum1Long.df,
  aes(x = Group, y = value, color = variable)) +
  geom_point() +
  geom_line() +
  coord_flip() +
  facet_wrap(~ variable) +
  ggtitle("Long-Format Datapoints by Breakout Groups A to F") +
  theme_classic()


#This plot shows:
             Each measurement variable (A–F) in a separate panel
			 Values grouped correctly by Group
			 Successful reshaping of the data

#Any warning messages can be ignored, as each group contains only one observation per variable in this demonstration dataset.

#################################################################################################
#Stacked Data and Student’s t-Test for Matched Pairs
####################################################

#In the previous section, the dataset PrePostWtUnstack.df was analyzed in unstacked (wide) format, where pretest and posttest weights were stored in separate columns. 
#In this section, the same dataset is transformed into stacked (long) format, and Student’s t-Test for Matched Pairs is applied using syntax appropriate for long-format data.

#Reviewing the Data Before Transformation
#Before reshaping the dataset, it is good practice to review the data to ensure it are correctly structured.

head(PrePostWtUnstack.df, n = 3)
tail(PrePostWtUnstack.df, n = 3)
str(PrePostWtUnstack.df)


#The unstacked dataset contains:
             150 observations (one row per subject)
             Three variables:
                 Subject (factor)
				 KgPreSupplement (numeric)
				 KgPostSupplement (numeric)

#Each subject has up to two measurements: one pretest and one posttest.

#Transforming the Data from Wide to Long Format
###############################################

#To convert the dataset into stacked (long) format, the reshape2::melt() function is applied. The Subject variable is retained as an identifier, while the two weight variables are stacked into a single column.

PrePostWtLONG.df <- reshape2::melt(
  PrePostWtUnstack.df,
  id.vars = "Subject"
)


#This transformation changes the structure of the data but does not change the data values.

#Reviewing the Data After Transformation

#After reshaping, the dataset is examined again.

head(PrePostWtLONG.df, n = 3)
tail(PrePostWtLONG.df, n = 3)
str(PrePostWtLONG.df)


#The stacked dataset now contains:
             300 observations (two rows per subject)
             Three variables:
                 Subject (factor)
				 variable (factor with levels KgPreSupplement and KgPostSupplement)
				 value (numeric weight measurements)

#Each subject now appears twice: once for the pretest measurement and once for the posttest measurement.

#Summary Statistics and Missing Data

summary(PrePostWtLONG.df)

#Based on inspection of the summary output and comparison with the unstacked dataset, it is evident that one value is missing in the stacked dataset.

#To identify incomplete cases:

complete.cases(PrePostWtLONG.df)

#This check confirms that Subject 19 is missing a posttest measurement (KgPostSupplement).

#################################################################################################
#Handling Missing Data in Matched-Pairs Designs
###############################################

#In matched-pairs analyses, both measurements must be present for each subject. If one measurement is missing, the subject cannot form a matched pair.

#Therefore:
             It is not sufficient to remove only the missing posttest row
			 The entire subject must be removed, including the existing pretest value

#This ensures that all remaining observations represent valid matched pairs.


#Accommodating Missing Data in Stacked (Long) Format

#When working with matched-pairs data, missing values require special attention. 
#If one measurement is missing for a subject, then no valid match exists for that subject. 
#As a result, both measurements for that subject must be removed, not just the missing value.

#Although the syntax shown here is not the only possible solution, it demonstrates one clear and transparent way to handle missing data in stacked (long) format.

#Identifying the Subject to Be Removed
######################################

#From earlier inspection of the data, it was determined that Subject 19 is missing a posttest measurement. To ensure that matched pairs are preserved, both rows associated with Subject 19 (pretest and posttest) must be removed.

#The subject to be removed is first stored in a separate object.

SubjectListToRemove <- 19
# Subject 19 is the subject with missing data

#Removing the Incomplete Matched Pair
#####################################

#Standard R subsetting syntax is then used to remove all rows corresponding to the identified subject. The logical operator ! (meaning “not”) ensures that all observations except those belonging to Subject 19 are retained.

PrePostWtLONGAdjusted.df <-
  PrePostWtLONG.df[ ! PrePostWtLONG.df$Subject %in%
                    SubjectListToRemove, ]


#This approach removes:
             The missing KgPostSupplement value for Subject 19
			 The corresponding KgPreSupplement value for Subject 19

#As a result, all remaining data form complete matched pairs.

#Verifying the Adjusted Dataset
###############################

#After removing the incomplete pair, the adjusted dataset is examined to confirm that it is correctly structured.

getwd()                               # Identify the working directory
ls()                                  # List objects
attach(PrePostWtLONGAdjusted.df)      # Attach the data
str(PrePostWtLONGAdjusted.df)         # Identify structure
PrePostWtLONGAdjusted.df              # Display the dataset
summary(PrePostWtLONGAdjusted.df)     # Summary statistics


#Inspection of the summary output confirms that:
             There are now 149 subjects
			 Each subject contributes exactly two observations
			 There are 149 matched pairs, not 150

#Conducting Student’s t-Test Using Stacked Data
###############################################

#With the incomplete subject removed, Student’s t-Test for Matched Pairs can now be applied using long-format syntax. 
#Because the data are stacked, the test is specified using the tilde (~) notation, where the measured values are compared across the two levels of the grouping variable.

t.test(
  value ~ variable,                    # Measured value ~ group variable
  data = PrePostWtLONGAdjusted.df,     # Adjusted dataframe
  alternative = "two.sided",           # Two-sided test
  paired = TRUE,                       # Matched pairs
  var.equal = FALSE                    # Variance assumption
)

t.test(
  value ~ variable,                    # Measured value ~ group variable
  data = PrePostWtLONG.df ,            # Adjusted dataframe
  alternative = "two.sided",           # Two-sided test
  var.equal = FALSE                    # Variance assumption
)


#Interpretation of the Result
Paired t-test

t = -7.547
df = 148
p-value = 0.00000000000421


#The p-value obtained from the stacked (long) data analysis is identical to the p-value obtained earlier using the unstacked (wide) data. This confirms that:
             The reshaping of the data does not affect the statistical result
			 Both wide and long formats yield the same inferential conclusion
			 The null hypothesis is rejected at α = 0.05
			 
#################################################################################################