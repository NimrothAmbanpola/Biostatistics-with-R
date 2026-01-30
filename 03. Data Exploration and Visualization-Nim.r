###############################################################
# Master in Biochemistry and Biotechnology – Semester I 
# Topic : Data Exploration -3
# Course: BCBT 54813 - Biostatistics
# Author: Nimroth Ambanpola
##############################################################

CPIIISecLbsGen.df <- read.table (file =
"CPIIISectionLbsGender.csv",
header = TRUE, sep = ",") # Import the .csv file.

class(CPIIISecLbsGen.df)
str(CPIIISecLbsGen.df) # Identify structure
nrow(CPIIISecLbsGen.df) # List the number of rows
ncol(CPIIISecLbsGen.df) # List the number of columns
dim(CPIIISecLbsGen.df) # Dimensions of the data frame
names(CPIIISecLbsGen.df) # Identify names
colnames(CPIIISecLbsGen.df) # Show column names
rownames(CPIIISecLbsGen.df) # Show row names
head(CPIIISecLbsGen.df) # Show the head
tail(CPIIISecLbsGen.df) # Show the tail
CPIIISecLbsGen.df # Show the entire dataframe
summary(CPIIISecLbsGen.df) # Summary statistics

duplicated(CPIIISecLbsGen.df$StudentID) # Duplicates
# DataFrame$ObjectName notation
#FALSE → the first occurrence of a value
#TRUE → a repeated (duplicate) occurrence


#Visual Data Check
##################
#Although numeric descriptive statistics (mean, median, standard deviation) are essential, they do not provide a complete understanding of how data are distributed.
#To fully understand the structure, variability, and potential anomalies in a dataset, it is necessary to visualize the data using graphics.

#Graphics complement numerical summaries by allowing us to:
#Detect skewness and outliers
#Identify unusual patterns
#Assess distributional assumptions
#Perform visual quality assurance (QA)

#Common Graphics for Exploratory Data Analysis
#In introductory data exploration, the most commonly used graphical functions in R are:
hist() – Histogram
plot() – Basic scatter/sequence plot
plot(density()) – Density plot
stripchart() – One-dimensional scatter
boxplot() – Box-and-whisker plot
qqnorm() – Normal Q–Q plot


#Controlling the Display of Graphics
par(ask=TRUE)#Pause after each plot and wait for the user before drawing the next one
par(mfrow=c(2,3)) # 6 figures into a 2 row by 3 column grid

#When multiple plots are generated in R one after another, R normally:
                Draws all figures automatically
                Replaces one plot with the next very quickly
                Gives the user no time to inspect each figure

				
hist(CPIIISecLbsGen.df$Lbs, main="Weight (Lbs): Histogram")#Histogram: Shows frequency distribution, Reveals skewness and overall shape

plot(CPIIISecLbsGen.df$Lbs, main="Weight (Lbs): Plot")#Basic Plot: Displays values in observation order

plot(density(CPIIISecLbsGen.df$Lbs, na.rm=TRUE), # na.rm=TRUE
main="Weight (Lbs): Density Plot") # missing data

boxplot(CPIIISecLbsGen.df$Lbs,
main="Weight (Lbs): Box Plot")#Box Plot: Summarizes median, quartiles, and range. Highlights potential outliers

stripchart(CPIIISecLbsGen.df$Lbs,
main="Weight (Lbs): Stripchart") # Stripchart: Displays individual data points. Reveals clustering and data density

qqnorm(CPIIISecLbsGen.df$Lbs, main="Weight (Lbs): Q-Q Plot")#Assesses whether data follow a normal distribution


#Visualizing factor-type variables in R
#######################################

#Why table() + barplot()?
| Function    | Role                                    |
| ----------- | --------------------------------------- |
| `table()`   | Converts categorical values into counts |
| `barplot()` | Visualizes those counts                 |

barplot(table(CPIIISecLbsGen.df$Section),#Accesses the categorical variable Section (e.g., AM / PM)
        main = "Section: Barplot Frequency Distribution",#Plot title
        col = c("black", "red"),#Colors for the bars
        ylim = c(0, 40))#Sets y-axis scale for better visual comparison

barplot(table(CPIIISecLbsGen.df$Gender),
        main = "Gender: Barplot Frequency Distribution",
        col = c("black", "red"),
        ylim = c(0, 40))


#ggplot2
########

#This is used to create advanced, layered graphics in R.
#Because ggplot2 relies on several external packages, these packages must be installed and loaded before use.

#Installing and Loading ggplot2
install.packages("ggplot2", dependencies = TRUE)
library(ggplot2)


#install.packages("ggplot2") :
#Downloads and installs the ggplot2 package from CRAN
#dependencies = TRUE ensures that all required supporting packages are also installed

#library(ggplot2) :
#Loads the package into the current R session
#Makes ggplot(), geom_*(), and facet_*() functions available

help(package = ggplot2) #Displays documentation and an overview of the package

#Installing and Loading Supporting Packages
install.packages("ggthemes", dependencies = TRUE) #Provides additional themes for ggplot2 graphics
library(ggthemes)
help(package = ggthemes

install.packages("ggmosaic", dependencies = TRUE)#Adds support for mosaic plots
library(ggmosaic)
help(package = ggmosaic)

install.packages("gridExtra", dependencies = TRUE)#Allows multiple ggplot objects to be arranged on one page
library(gridExtra)

install.packages("grid", dependencies = TRUE)#Forms the foundation of ggplot2’s rendering system
library(grid)
help(package = grid)

install.packages("scales", dependencies = TRUE)#Controls axis scaling and formatting
library(scales)
help(package = scales)


#Faceted Density Plots and Boxplots Using ggplot2
#################################################
#Create four ggplot2 figures to explore how the numeric variable Weight (Lbs) is distributed across two categorical variables:
            Section (e.g., AM vs PM)
            Gender (Female vs Male)

#Two types of plots are used:
            Density plots → compare distribution shapes
            Boxplots → compare medians, spread, and outliers

#Together, these plots provide strong visual quality assurance (QA) and exploratory insight.

#PART A: Density Plots (Distribution Shape)
# 1. Density by Section

DensityFacetSectionLbs <-
ggplot2::ggplot(CPIIISecLbsGen.df, aes(x = Lbs)) +
      #Defines the dataset.
	  #Maps the numeric variable Lbs to the x-axis
	  #Creates an empty ggplot object to which layers are added
  geom_density(col = "red", lwd = 2) +
      #Draws a smooth density curve (distribution shape).
	  #col = "red" → sets line color. 
	  #lwd = 2 → increases line thickness for clarity
  facet_grid(. ~ Section) +
      #Splits the plot by the factor variable Section
	  #Each section (e.g., AM, PM) gets its own panel
	  #All panels share the same x- and y-scales
  ggtitle("Section by Weight (Lbs): Facet - ggplot\n") +
      #Adds a descriptive title
	  #\n inserts extra spacing for improved readability
  labs(x = "\nWeight (Lbs)", y = "Density\n") +
      #Provides clear axis labels
	  #Line breaks (\n) improve spacing and presentation
  scale_x_continuous(labels = scales::comma,#formats large numbers with commas
                     limits = c(0, 200),#restricts x-axis range
                     breaks = seq(0, 200, by = 25)) +#places tick marks every 25 units
  theme_bw()#Applies a black-and-white theme

#Why the Plot Is Assigned to an Object
DensityFacetSectionLbs <-
#The plot is stored as an object, not immediately displayed
#Allows: Reuse,Combination with other plots, Flexible layout control

#Because the plot is stored as an object, it will not appear automatically.
gridExtra::grid.arrange(DensityFacetSectionLbs)#To display plot


# Clean code
DensityFacetSectionLbs <-
  ggplot2::ggplot(CPIIISecLbsGen.df,
                  aes(x = Lbs)) +
  geom_density(col = "red", lwd = 2) +
  facet_grid(. ~ Section) +
  ggtitle("Section by Weight (Lbs): Facet - ggplot\n") +
  labs(x = "\nWeight (Lbs)", y = "Density\n") +
  scale_x_continuous(labels = scales::comma,
                     limits = c(0, 200),
                     breaks = seq(0, 200, by = 25)) +
  theme_bw()



# 2. Density by Gender 
DensityFacetGenderLbs <-
ggplot2::ggplot(CPIIISecLbsGen.df, aes(x = Lbs)) +
  geom_density(col = "red", lwd = 2) +
  facet_grid(. ~ Gender) +
  ggtitle("Gender by Weight (Lbs): Facet - ggplot\n") +
  labs(x = "\nWeight (Lbs)", y = "Density\n") +
  scale_x_continuous(labels = scales::comma,
                     limits = c(0, 200),
                     breaks = seq(0, 200, by = 25)) +
  theme_bw()



#PART B: Boxplots (Central Tendency & Spread)
# 3. Boxplot by Section

BoxplotSectionLbs <-
ggplot(CPIIISecLbsGen.df,
       aes(x = Section, y = Lbs, fill = Section)) +
  geom_boxplot() +
  ggtitle("Section by Weight (Lbs): Boxplot\n") +
  labs(x = "\nSection", y = "Weight (Lbs)\n") +
  scale_y_continuous(labels = scales::comma,
                     limits = c(100, 200),
                     breaks = seq(100, 200, by = 25)) +
  theme_bw()

#Explanation
aes(x = Section, y = Lbs)#Compares weights across sections.
geom_boxplot()#Shows median, quartiles, range, and outliers.
fill = Section #Colors boxes by section for clarity.
scale_y_continuous(...) #Focuses on a realistic weight range (100–200 lbs).

#4. Boxplot by Gender
BoxplotGenderLbs <-
ggplot(CPIIISecLbsGen.df,
       aes(x = Gender, y = Lbs, fill = Gender)) +
  geom_boxplot() +
  ggtitle("Gender by Weight (Lbs): Boxplot\n") +
  labs(x = "\nGender", y = "Weight (Lbs)\n") +
  scale_y_continuous(labels = scales::comma,
                     limits = c(100, 200),
                     breaks = seq(100, 200, by = 25)) +
  theme_bw()

#To display plots
gridExtra::grid.arrange(
DensityFacetSectionLbs,
DensityFacetGenderLbs,
BoxplotSectionLbs,
BoxplotGenderLbs, ncol=2)

########################################################################################

#Descriptive Statistics for Initial Analysis of the Data
########################################################
#Befor we continue the project......
getwd()#To check working directory
ls()#To list all files in the current directory
sessionInfo()#To confirm the R version and to gain information on the locale and available packages.

#Load required libraries
library(readxl) #Import a .xlsx Spreadsheet File into R
library(data.table) #Import a .csv File of Comma-Separated Values from an Online Source into R
library(ggplot2)#To create advanced, layered graphics in R.

CPIIISecLbsGen.df <- read.table (file =
"data/CPIIISectionLbsGender.csv",
header = TRUE, sep = ",") # Import the .csv file.

#Quality Assurance and Missing Data Checks for a Numeric Variable
#################################################################

#Early identification of missing values is essential because:
            Many statistical functions behave differently when NA values are present
            Decisions about handling missing data affect validity and interpretation
            QA practices prevent silent errors later in analysis

##Step 1: Count the Number of Observations			
length(CPIIISecLbsGen.df$Lbs)# Length or N of a vector. Includes both valid values and missing values (NA)


##Step 2: Identify Missing Values Explicitly
table(is.na(CPIIISecLbsGen.df$Lbs))#Shows how many observations are missing

#is.na() checks each value:
                          TRUE → value is missing (NA)
                          FALSE → value is present
#table() counts how many TRUE and FALSE values occur


##Step 3: Identify Complete (Non-Missing) Values
table(complete.cases(CPIIISecLbsGen.df$Lbs))

#complete.cases() returns:
                          TRUE → value is not missing
                          FALSE → value is missing

#table() summarizes counts


##Step 4: Descriptive Statistics and Measures of Central Tendency
#After identifying missing values and confirming data structure, the next step in quality assurance (QA) is to compute descriptive statistics.

#Descriptive Statistics with Missing Data
summary(CPIIISecLbsGen.df$Lbs)

#Although many functions exist, the summary() output is often the first checkpoint. Additional functions provide more detailed insight

#All functions below include:  na.rm = TRUE

#This argument:
              Removes missing values (NA) before computation
              Prevents errors or incorrect results



#Measures of Central Tendency
#Mean (Arithmetic Average)
mean(CPIIISecLbsGen.df$Lbs, na.rm = TRUE)

#Median (Midpoint)
median(CPIIISecLbsGen.df$Lbs, na.rm = TRUE)




#Measures of Variability
#Standard Deviation
sd(CPIIISecLbsGen.df$Lbs, na.rm = TRUE)

#Variance
var(CPIIISecLbsGen.df$Lbs, na.rm = TRUE)



#Range and Extreme Values
#Range
range(CPIIISecLbsGen.df$Lbs, na.rm = TRUE)# Range, minimum and maximum

#Minimum and Location
min(CPIIISecLbsGen.df$Lbs, na.rm = TRUE)

which.min(CPIIISecLbsGen.df$Lbs)#Location (e.g., index) of the first occurrence of the minimum value

#Maximum and Location
max(CPIIISecLbsGen.df$Lbs, na.rm = TRUE)

which.max(CPIIISecLbsGen.df$Lbs)# Location (e.g., index) of the first occurrence of the maximum value



#Quantiles (Distribution Breakdown)
quantile(CPIIISecLbsGen.df$Lbs, na.rm = TRUE)# Quantiles, or values at: 0%, 25%, 50% 75%, and 100%

#Total Sum of Values
sum(CPIIISecLbsGen.df$Lbs, na.rm = TRUE)# Arithmetic sum of all values in a vector



#Boxplot-Based Summaries
########################
#After computing standard descriptive statistics (mean, median, SD, quantiles), we now use boxplot-based summaries.

boxplot.stats(CPIIISecLbsGen.df$Lbs)
#boxplot.stats() computes the numerical components used to draw a boxplot, without actually plotting it.

-----------------------------------------------------------------------------------------------
Term                         Meaning (Statistics)                       Value      Interpretation
-----------------------------------------------------------------------------------------------
Lower Whisker                Smallest value within                     99.0       Lowest typical
                             1.5 × IQR below Q1                                   student weight
                             (minimum non-outlier)                                 (not an outlier)

Lower Hinge (Q1)             First quartile (25th percentile)           121.0      25% of students
                                                                                   weigh ≤ 121 lbs

Median (Q2)                  Second quartile (50th percentile)          127.0      Half of students
                                                                                   weigh below and
                                                                                   half above 127 lbs

Upper Hinge (Q3)             Third quartile (75th percentile)           139.5      75% of students
                                                                                   weigh ≤ 139.5 lbs

Upper Whisker                Largest value within                       165.0      Highest typical
                             1.5 × IQR above Q3                                   student weight
                             (maximum non-outlier)                                 before outliers

N                            Number of non-missing observations          60         Sample size used
                                                                                   in the analysis

Outliers                     Values outside                             168,       Unusually high
                             Q1 − 1.5×IQR or                             169, 192  weights compared
                             Q3 + 1.5×IQR                                           to most students

Median Confidence Interval   Approximate 95% confidence interval         123.226 –  Range where the
                             for the population median                  130.774   true median likely
                                                                                   lies
-----------------------------------------------------------------------------------------------


#Tukey’s Five-Number Summary
#Tukey’s five-number summary consists of:Minimum, Lower hinge (Q1), Median, Upper hinge (Q3), Maximum
#Unlike boxplot.stats(), this includes the true maximum, even if it is an outlier.
fivenum(CPIIISecLbsGen.df$Lbs, na.rm = TRUE)

#Interquartile Range (IQR)
IQR(CPIIISecLbsGen.df$Lbs, na.rm = TRUE)
#Interquartile range of a vector (e.g., a measure of dispersion that is equal to the difference between the upper quartile and the lower quartile.



#Group-wise Frequency Distributions Using table()
#################################################
#Up to this point, descriptive statistics (mean, median, SD, IQR, etc.) were computed at a single, overall level for the numeric variable.
#These summaries describe the entire dataset combined, but they do not reveal how weight varies across important subgroups.
#eg:
   Section (AM vs PM)
   Gender (Female vs Male)

#To understand representation, balance, and group-specific patterns, we next construct frequency distributions and contingency tables.

#Weight by Section: Value-by-Value Contingency Table
table(CPIIISecLbsGen.df$Lbs, CPIIISecLbsGen.df$Section)

#Creates a two-way table (crosstab):
             Rows → individual weight values (Lbs)
             Columns → Section (AM, PM)
#Each cell contains the count of students with that exact weight in each section

#Weight by Gender: Value-by-Value Contingency Table
table(CPIIISecLbsGen.df$Lbs, CPIIISecLbsGen.df$Gender)


#Gender by Section: Overall Representation (With Missing-Value Check)
table(CPIIISecLbsGen.df$Gender,
      CPIIISecLbsGen.df$Section,
      useNA = c("always"))

#Produces a compact contingency table of:
                                      Rows → Gender
                                      Columns → Section
#Each cell shows the total number of students in each Gender–Section combination
#useNA = "always" forces NA categories to appear if present

#Section by Gender: Overall Representation (With Missing-Value Check)
table(CPIIISecLbsGen.df$Section,
      CPIIISecLbsGen.df$Gender,
      useNA = c("always"))
#Rows represent Section. Columns represent Gender. Each cell contains the number of students in that group




##Converts counts into proportions
#Proportion tables help to:
                   Understand relative group sizes
                   Detect imbalances that may bias analysis
                   Decide whether stratified or adjusted analysis is needed


#Proportions of Section × Gender
prop.table(table(CPIIISecLbsGen.df$Section,
                 CPIIISecLbsGen.df$Gender,
                 useNA = c("always")))

#Each value represents the fraction of the total sample
#All cells together sum to 1 (100%)

#Proportions with Reversed Row/Column Orientation
prop.table(table(CPIIISecLbsGen.df$Gender,
                 CPIIISecLbsGen.df$Section,
                 useNA = c("always")))
#Rows = Gender, Columns = Section
#Orientation is changed for interpretation convenience


#Alternative Functions for Contingency Tables
#############################################

#Using xtabs()
xtabs(~ Section + Gender, data = CPIIISecLbsGen.df)
#Explanation :
             Formula interface: ~ row_variable + column_variable
             Uses the dataset directly
             Produces the same counts as table()
             Often preferred for clarity in modeling contexts

#Using ftable() for Flat Tables
ftable(xtabs(~ Section + Gender, data = CPIIISecLbsGen.df))
#Explanation:
             ftable() formats the contingency table for clean printing
             Useful for reports and multi-way tables



#Group-wise Descriptive Statistics Using RcmdrMisc::numSummary()
################################################################
#Frequency tables (table(), prop.table()) describe how many observations fall into each category, but they do not summarize the numeric variable within those categories.

#The function RcmdrMisc::numSummary() is used because it:
              Combines multiple statistics into one clean table
              Handles missing values automatically
              Supports group-wise breakouts with a simple argument
			  
#Installing and Loading the Package
install.packages("RcmdrMisc", dependencies = TRUE)
library(RcmdrMisc)
help(package = RcmdrMisc)
sessionInfo()

#Overall Descriptive Statistics (No Grouping)
RcmdrMisc::numSummary(CPIIISecLbsGen.df$Lbs)

#Group-wise Statistics by Section (AM vs PM)
RcmdrMisc::numSummary(CPIIISecLbsGen.df[, c("Lbs")],
                      groups = CPIIISecLbsGen.df$Section)

#Group-wise Statistics by Gender
RcmdrMisc::numSummary(CPIIISecLbsGen.df[, c("Lbs")],
                      groups = CPIIISecLbsGen.df$Gender)
					  



########################################################################################

#Quality Assurance, Data Distribution, and Tests for Normality
##############################################################

#Quality assurance (QA) is not a single step.
#It is a continuous process throughout the entire research workflow.
#QA begins with the first research idea.
#QA ends only after the final report is proofread.

#QA includes:
             Checking data quality
             Examining data distribution
             Evaluating assumptions such as normality

#Role of Graphics and Descriptive Statistics
############################################
#Graphs provide a visual understanding of data behavior.
#Descriptive statistics provide numerical summaries of data structure.



#Why Test for Normality?
########################
#Many statistical tests assume that data follow a normal distribution.
#Examples include:
                 t-tests
                 ANOVA
                 Linear regression

#If this assumption is violated, results may be misleading.
#Therefore, normality must be assessed before inferential analysis.

#Normality Tests Available in R
###############################
#R supports several statistical tests for normality. Each test evaluates distribution shape from a slightly different perspective.

#Common normality tests include:                  

------------------------------------------------------------------------------------------------------------
Test Name                         Purpose / What It Tests                  Typical R Function / Package
------------------------------------------------------------------------------------------------------------
Shapiro–Wilk Test                 Tests whether data follow a normal       shapiro.test()
                                  distribution; very powerful for
                                  small to moderate samples

Shapiro–Francia Test              Variant of Shapiro–Wilk, better suited   nortest::sf.test()
                                  for larger sample sizes

Anderson–Darling Test             Tests normality with extra sensitivity   nortest::ad.test()
                                  in the tails of the distribution

Cramér–von Mises Test             Tests overall agreement between the      nortest::cvm.test()
                                  empirical and normal distributions

Lilliefors Test                   Modified Kolmogorov–Smirnov test         nortest::lillie.test()
(Kolmogorov–Smirnov)              when mean and variance are unknown

Pearson Chi-square Test           Compares observed vs expected            nortest::pearson.test()
                                  frequencies under normality

Jarque–Bera Test                  Tests skewness and kurtosis jointly      tseries::jarque.bera.test()
                                  for departure from normality

Kolmogorov–Smirnov Test           Compares empirical distribution to       ks.test()
(Standard KS Test)                a specified normal distribution          (parameters must be known)
------------------------------------------------------------------------------------------------------------
#Note:
    Different tests emphasize different aspects of normality (center, spread, tails).
    No single test should be used in isolation.
    Graphical methods (histograms, Q–Q plots, density plots) must accompany formal tests.

#In this lesson, the Shapiro Test for Normality is demonstrated.


#The Shapiro Test for Normality
###############################

shapiro.test()


#This function belongs to the stats package. The stats package is included by default when R is installed.

#Important Difference in the Null Hypothesis
############################################

#Most statistical tests use a negative null hypothesis.
#For example: There is no statistically significant difference between groups.

#The Shapiro test is different.
#Its null hypothesis is stated in the affirmative:The data follow a normal distribution.

#This difference is critical for correct interpretation.


#Interpreting the p-value (Shapiro Test)
#######################################
#The p-value determines whether the normality assumption is reasonable.

#Case 1: Small p-value
       If p ≤ 0.05 (or ≤ 0.01)
       Evidence against normality
       Decision: Reject the null hypothesis
       Conclusion: Data do not follow a normal distribution

#Case 2: Large p-value
       If p > 0.05
       No evidence against normality
       Decision: Fail to reject the null hypothesis
       Conclusion: Data appear approximately normal



#Example Dataset: Consider the following numeric data (e.g., weights in kg)
x = {48, 50, 52, 49, 51}

#Case 1: Standard Hypothesis Test (e.g., t-test)
#Suppose we test whether the mean weight differs from 50 kg.

#Null Hypothesis (H₀)
H₀: μ = 50
#“There is no difference between the population mean and 50.”
📌 Null hypothesis is stated negatively (no difference).

#Alternative Hypothesis (H₁)
H₁: μ ≠ 50

#Decision Rule
         If p ≤ 0.05 → Reject H₀ → Difference exists
         If p > 0.05 → Fail to reject H₀ → No evidence of difference



#Case 2: Shapiro Test for Normality
#Now we test whether the same data follow a normal distribution.

#Null Hypothesis (H₀)
H₀: x follows a normal distribution
📌 Null hypothesis is stated affirmatively (normality holds)

#Alternative Hypothesis (H₁)
H₁: x does not follow a normal distribution

#Decision Rule
         If p ≤ 0.05 → Reject H₀ → Data are not normal
         If p > 0.05 → Fail to reject H₀ → Data appear normal






####Normality Is Rarely Perfect
#Perfect normality is uncommon in real data. Most datasets show some deviation.

#Data may deviate from normality due to:
         Measurement error
         Natural biological variability
         Small sample sizes
         Skewed populations
         Presence of outliers

####The key question is: Is the data normal enough for the intended analysis?

#Factors That Guide the Judgment
################################
#1. Sample Size: Sample size strongly affects normality assessment.

#Small samples
         Normality tests have low power
         Visual inspection is more important

#Large samples
         Even tiny deviations produce small p-values
         Statistical significance may not imply practical importance

📌 Large datasets often fail normality tests even when distributions look acceptable.

#2. Graphical Evidence
#Visual tools are essential.
#Key plots include:
                 Histogram
                 Density plot
                 Q–Q plot
                 Boxplot
#If these plots show:
                Symmetry
                No extreme outliers
                Reasonable bell shape
#Then mild deviations are usually acceptable.

#3. Robustness of Planned Tests
#Many statistical tests are robust to non-normality.

#Examples:
        t-tests tolerate moderate skewness
        ANOVA performs well with balanced designs
        Regression relies more on residual normality than raw data normality

📌 Robust tests continue to work well even when assumptions are not perfectly met.

#Parametric vs Nonparametric Decisions
#######################################

If data are reasonably normal:
                  Parametric tests may be used

If data strongly deviate from normality:
                  Nonparametric methods should be considered

#The Shapiro test helps inform this decision. It does not decide alone.

####Key Takeaway: Quality assurance is continuous, normality is assessed cautiously, and statistical decisions must be supported by both visual and numerical evidence.


#Why Test Statistics Increase With Sample Size
##############################################
#In statistics, an estimate is a value calculated from sample data. It is used to approximate an unknown population quantity.

#The population quantity is called a parameter.The estimate is our best guess of that parameter using data.

| Population Parameter   | Symbol | Sample Estimate        |
| ---------------------- | ------ | ---------------------- |
| Population mean        | μ      | Sample mean (x̄)       |
| Population variance    | σ²     | Sample variance (s²)   |
| Population proportion  | p      | Sample proportion (p̂) |
| Population correlation | ρ      | Sample correlation (r) |
| Population skewness    | γ₁     | Sample skewness (g₁)   |

#What Is “Observed Deviation”?
How far the data deviate from perfect normality.

#Examples of deviation:
             Slight skewness
             Slightly heavier tail
             Small bump in histogram

#Choose 0.05 as observed deviation. “The data are 5% away from perfect normality.”

#What Does a Test Statistic Measure?
#A test statistic answers the question:
        Is the observed deviation larger than what could occur by random chance?
		
Test Statistic = Deviation / Random noise

#If:
   Deviation is small relative to noise → not significant
   Deviation is large relative to noise → significant

#Where Does Random Noise Come From?
          Random noise comes from sampling variability.

Random noise ≈ 1 / √n
This means:
          Small samples → large noise
          Large samples → small noise

Test Statistic ≈ (Observed Deviation) / (1 / √n)		  
Test Statistic ≈ (Observed deviation) × √n		
  
---------------------------------------------------------------------------------------------------------
Sample Size Case        Observed Deviation   n        √n       Test Statistic        p-value   Conclusion
---------------------------------------------------------------------------------------------------------
Small Sample             0.05                25       5        0.05 × 5  = 0.25     Large     Deviation is
                                                                                               not statistically
                                                                                               significant;
                                                                                               normality is not
                                                                                               rejected

Large Sample             0.05                10,000   100      0.05 × 100 = 5        Very     Deviation is
                                                                                    small      statistically 
																				               significant;
                                                                                               normality is
                                                                                               rejected
---------------------------------------------------------------------------------------------------------


#Applying the Shapiro Test for Normality
#Before performing any group-wise comparisons, it is important to assess whether the numeric variable CPIIISecLbsGen.df$Lbs (weight) follows a normal distribution overall.

shapiro.test(CPIIISecLbsGen.df$Lbs)
plot(density(CPIIISecLbsGen.df$Lbs, na.rm=TRUE)

#Decision Rule:
              If p ≤ 0.05 → Reject the null hypothesis
              If p > 0.05 → Fail to reject the null hypothesis

#Test Statistic (W)
W = 0.91692    #W = 0.91692 suggests noticeable deviation from normality

#W measures how close the data are to normality
#Values of W close to 1 indicate stronger normality
#Smaller values indicate greater deviation from normality


#p-value
#The p-value measures evidence against the null hypothesis
p-value = 0.0005778

0.0005778 < 0.05

#Decision:
         Reject the null hypothesis
         The data do not follow a normal distribution
		 

#Normality Testing by Group Using RVAideMemoire
###############################################

#The overall Shapiro–Wilk test showed that weights (Lbs) are not normally distributed when all students are combined.

#The next question is more refined: Does normality hold within specific groups, even if it fails overall?

#We examine normality by breakout groups defined by:
            Section (AM vs PM)
            Gender (Female vs Male)
#This is a group-level quality assurance (QA) step.


install.packages("RVAideMemoire", dependencies = TRUE)
library(RVAideMemoire)
help(package = RVAideMemoire)
sessionInfo()


#Normality Test Overall (Using mshapiro.test())

RVAideMemoire::mshapiro.test(CPIIISecLbsGen.df$Lbs)

#This result matches the earlier shapiro.test() output
#Confirms that overall weight distribution is not normal
#mshapiro.test() is a multivariate-friendly extension, but here behaves similarly


#Normality Test by Section (AM vs PM)

RVAideMemoire::byf.shapiro(Lbs ~ Section,
                           data = CPIIISecLbsGen.df)


ggplot2::ggplot(CPIIISecLbsGen.df,
			  aes(x = Lbs)) +
geom_density(col = "red", lwd = 2) +
facet_grid(. ~ Section) +
ggtitle("Section by Weight (Lbs): Facet - ggplot\n") +
labs(x = "\nWeight (Lbs)", y = "Density\n") +
scale_x_continuous(labels = scales::comma,
				 limits = c(0, 200),
				 breaks = seq(0, 200, by = 25)) +
theme_bw()


        W       p-value
AM   0.9560   0.244497
PM   0.9024   0.009616 **

#Interpretation by Group
#AM Section:
           p-value = 0.244497
           Greater than 0.05
           Fail to reject normality
           AM weights appear approximately normal

#PM Section:
           p-value = 0.009616
           Less than 0.05
           Reject normality
           PM weights deviate from normality
		   


##This explains how overall non-normality can arise from only one subgroup.


#Normality Test by Gender (Female vs Male)

RVAideMemoire::byf.shapiro(Lbs ~ Gender,
                           data = CPIIISecLbsGen.df)
						   
						   
ggplot2::ggplot(CPIIISecLbsGen.df, aes(x = Lbs)) +
geom_density(col = "red", lwd = 2) +
facet_grid(. ~ Gender) +
ggtitle("Gender by Weight (Lbs): Facet - ggplot\n") +
labs(x = "\nWeight (Lbs)", y = "Density\n") +
scale_x_continuous(labels = scales::comma,
				 limits = c(0, 200),
				 breaks = seq(0, 200, by = 25)) +
theme_bw()						   
			
            W p-value
Female 0.9865  0.9367
Male   0.9823  0.9261

#Female Students:
                p-value = 0.9367
                Greater than 0.05
                Fail to reject the null hypothesis of normality
                Weight distribution for Female students appears approximately normal

#Male Students:
               p-value = 0.9261
               Greater than 0.05
               Fail to reject the null hypothesis of normality
               Weight distribution for Male students appears approximately normal
			
##Key Insight from These Results
#A dataset may be non-normal overall, while some subgroups are approximately normal and others are not.

#This has practical consequences:
          Parametric tests may be acceptable for some group comparisons
          Nonparametric alternatives may be required for others
		  
		  
		  

#########################################################################################
#Visual Assessment of Normality Using Q–Q Plots (ggplot2)
#########################################################

#What a Q–Q Plot Shows

#A Q–Q plot compares:
            Observed sample quantiles (red points)
            Against theoretical normal quantiles (blue reference line)

#Interpretation rules:
            Points close to the line → approximate normality
            Systematic curvature or tail deviation → non-normality
            Large departures at extremes → skewness or outliers

#The terms Quantile–Quantile, Q–Q, and QQ all refer to the same plot type.


#Q–Q Plot of Weight (Overall Weight Distribution)

QQLbs <- #Stores the Q–Q plot as an R object
ggplot2::ggplot(CPIIISecLbsGen.df,#Calls the ggplot() function from ggplot2
aes(sample = Lbs)) + #aes() defines how variables map to the plot (Use the Lbs variable to compute sample quantiles)
stat_qq(color = "red") + #Draws red points representing observed data
stat_qq_line(color = "blue", size = 1.75) + #Adds the theoretical normal reference Blue line
ggtitle("
Weight (Lbs) QQ-Plot and QQ-Line,\nOverall\n") + #Adds a multi-line title. \n inserts line breaks
labs(x = "\nTheoretical", y = "Weight (Lbs)\n") + #Label the Axes
theme_bw() #Applies a black-and-white theme. Removes background shading

#Clear code oveerall Weight (Lbs)
QQLbs <-
ggplot2::ggplot(CPIIISecLbsGen.df,
aes(sample = Lbs)) +
stat_qq(color = "red") +
stat_qq_line(color = "blue", size = 1.75) +
ggtitle("
Weight (Lbs) QQ-Plot and QQ-Line,\nOverall\n") +
labs(x = "\nTheoretical", y = "Weight (Lbs)\n") +
theme_bw()

#Because the plot is stored as an object, it will not appear automatically.
gridExtra::grid.arrange(QQLbs)#To display plot

#Interpretation:
             The points deviate from the reference line, especially in the upper tail
             This visual pattern supports the Shapiro test result
             The deviation suggests heavier-than-expected upper values


# Weight (Lbs) by Section (two breakouts)
QQFacetLbsSection <-
ggplot2::ggplot(CPIIISecLbsGen.df,
aes(sample=Lbs)) +
stat_qq(color="red") +
stat_qq_line(color="blue", size=1.75) +
facet_grid(. ~ Section) + #Split the plot into separate panels (subplots) for each level of Section, arranged horizontally.
ggtitle("
Weight (Lbs) QQ-Plot and QQ-Line,\nby Course Section\n") +
labs(x = "\nTheoretical", y = "Weight (Lbs)\n") +
theme_bw()


#Interpretation by Section
#AM Section:
             Points mostly follow the reference line
             Minor random scatter is present
             Visual evidence supports, normality is plausible for AM students

#PM Section:
             Clear deviation from the line, especially above ~150 lbs
             Upper-tail points move far from the reference line
             This indicates, skewness and/or outliers in PM weights, and Non-normality driven by heavier students

# Weight (Lbs) by Gender (two breakouts)
QQFacetLbsGender <-
ggplot2::ggplot(CPIIISecLbsGen.df,
aes(sample=Lbs)) +
stat_qq(color="red") +
stat_qq_line(color="blue", linewidth=1.75) +
facet_grid(. ~ Gender) + #Split the plot into separate panels by Gender
ggtitle("
Weight (Lbs) QQ-Plot and QQ-Line,\nby Gender\n") +
labs(x = "\nTheoretical", y = "Weight (Lbs)\n") +
theme_bw()

#Interpretation by Gender
#Both Female and Male Q–Q plots show:
             Points closely aligned with the reference line
             No strong tail deviations
             Visual results reinforce Shapiro test outcomes
             Normality holds within both Gender groups

#To display 3 plots
gridExtra::grid.arrange(
QQLbs,
QQFacetLbsSection,
QQFacetLbsGender, ncol=3)

########################################################################################

#Inferential tests are meaningful only after:
             Data quality is verified
             Distribution patterns are understood
             Assumptions are evaluated

#Without these preliminary steps, results may be misleading.


##Examples of Parametric Statistical Tests

#Parametric tests typically assume:
             Approximate normality
             Interval or ratio data

#Common parametric tests include:
             Student’s t-test for independent samples
             Student’s t-test for matched pairs
             One-way Analysis of Variance (ANOVA)
             Two-way Analysis of Variance (ANOVA)
             Pearson’s correlation coefficient (r)

##Examples of Nonparametric Statistical Tests

#Nonparametric tests are often used when:
             Normality assumptions are violated
             Data are ordinal or ranked

#Common nonparametric tests include:
             Mann–Whitney U test
             Wilcoxon matched-pairs signed-ranks test
             Kruskal–Wallis H test (one-way ANOVA by ranks)
             Friedman two-way ANOVA by ranks
             Spearman’s rank correlation coefficient (rho)
			 
########################################################################################

#Specialized External Package : asbio (A Collection of Statistical Tools for Biologists)
########################################################################################

install.packages("asbio")#downloads the package (one-time action)
library(asbio)#loads the package into the current R session
help(package = asbio)
sessionInfo()

#Example: Computing the Mode Using asbio
asbio::Mode(CPIIISecLbsGen.df$Lbs)


#Specialized External Package : epiDisplay (Epidemiological Data Display Package)
#################################################################################

#The epiDisplay package is a versatile external R package designed to support:
             Frequency distributions
             Descriptive statistics
             Measures of central tendency

#A key advantage of epiDisplay is that many of its functions:
             Produce graphical output
             Print detailed numerical summaries to the console at the same time

#This dual output supports quality assurance (QA) and clear reporting.

install.packages("epiDisplay")
library(epiDisplay)
help(package = epiDisplay)
sessionInfo()


par(ask=TRUE) #pauses between figures until the user presses Enter
par(mfrow=c(1,2)) # 2 figures into a 1 row by 2 column grid


#Frequency Distribution of a Single Factor Variable (tab1())

epiDisplay::tab1(CPIIISecLbsGen.df$Section,
main="Frequency Distribution of Section",
col=c("red", "blue"), font.lab=2, font.axis=2)

epiDisplay::tab1(CPIIISecLbsGen.df$Gender,
main="Frequency Distribution of Gender",
col=c("red", "blue"), font.lab=2, font.axis=2)

# What tab1() Does:
             Computes: Frequencies, Percentages
             Prints results as text in the console
             Generates a bar chart automatically	


#Frequency Distribution of Two Factor Variables (tabpct())			 

par(ask=TRUE)
par(mfrow=c(1,2)) # 2 figures into a 1 row by 2 column grid


epiDisplay::tabpct(CPIIISecLbsGen.df$Section,
                   CPIIISecLbsGen.df$Gender,
                   graph=TRUE, decimal=1,
                   main="Frequency Distribution of Section by Gender",
                   xlab="Section", ylab="Gender",
                   cex.axis=1, percent="both",
                   las=1, col=c("red","blue"))


#Reversed Perspective (Gender by Section)
epiDisplay::tabpct(CPIIISecLbsGen.df$Gender,
                   CPIIISecLbsGen.df$Section,
                   graph=TRUE, decimal=1,
                   main="Frequency Distribution of Gender by Section",
                   xlab="Gender", ylab="Section",
                   cex.axis=1, percent="both",
                   las=1, col=c("red","blue"))

#What tabpct() Does
#Creates a contingency table of two categorical variables
#Computes:
             Row percentages
             Column percentages

#Displays:
             Stacked bar chart
             Detailed numeric output in the console


#Using epiDisplay::summ() for Descriptive Statistics and Dotplots
#################################################################
#The epiDisplay::summ() function produces sorted dotplots and descriptive statistics for numeric variables, allowing both overall and group-wise examination of data distribution.

par(mfrow=c(1,3)) # 3 figures into a 1 row by 3 column grid

epiDisplay::summ(CPIIISecLbsGen.df$Lbs,
by = NULL,                  #no grouping (overall analysis)
graph = TRUE,               #creates a dotplot
box = TRUE,                 #overlays a boxplot
pch = 20,                   #solid dot symbols
ylab = "auto",              #automatic y-axis labeling
main = "Sorted Dotplot of Weight (Lbs), Overall",
cex.X.axis = 1.25,
cex.Y.axis = 1.25,
font.lab = 2,
dot.col = "auto")


#Summary and Dotplot by Section

epiDisplay::summ(CPIIISecLbsGen.df$Lbs,
by = CPIIISecLbsGen.df$Section,
graph = TRUE,
pch = 20, ylab = "auto",
main = "Sorted Dotplot of Weight (Lbs) by Section",
cex.X.axis = 1.25,
cex.Y.axis = 1.25,
font.lab = 2,
dot.col = "auto")

#Summary and Dotplot by Gender

epiDisplay::summ(CPIIISecLbsGen.df$Lbs,
by = CPIIISecLbsGen.df$Gender,
graph = TRUE,
pch = 20, ylab = "auto",
main = "Sorted Dotplot of Weight (Lbs) by Gender",
cex.X.axis = 1.25,
cex.Y.axis = 1.25,
font.lab = 2,
dot.col = "auto")


#Sorted dotplot:
             Displays raw data values in sorted order
             Emphasizes clustering, spread, and outliers

#Q–Q plot:
             Compares data quantiles to theoretical normal quantiles
             Used specifically for assessing normality
			 


#Specialized External Package : s20x Package for Descriptive Statistics
#######################################################################

#The s20x package provides detailed and well-formatted summaries of:
             Descriptive statistics
             Measures of central tendency
             Measures of dispersion

install.packages("s20x", dependencies=TRUE)
library(s20x)
help(package = s20x)
sessionInfo()

#Overall Descriptive Statistics for Weight (Lbs)
s20x::summaryStats(CPIIISecLbsGen.df$Lbs, na.rm=TRUE)

#Why na.rm=TRUE Is Used:
             The variable Lbs contains one missing value
             na.rm=TRUE ensures calculations ignore missing data
             Prevents errors and biased summaries
			 
#Descriptive Statistics by Gender
s20x::summaryStats(Lbs ~ Gender, CPIIISecLbsGen.df, na.rm=TRUE)


#Descriptive Statistics by Section
s20x::summaryStats(Lbs ~ Section, CPIIISecLbsGen.df, na.rm=TRUE)

#Frequency Distribution by Gender and Weight
s20x::rowdistr( #Converts the crosstab into:Row-wise proportions; Bar charts
  crosstabs(~ Gender + Lbs, data = CPIIISecLbsGen.df),#Creates a cross-tabulation
  plot = TRUE,#Produces a bar chart
  suppressText = FALSE,#Prints numerical frequency and percentage tables to the console
  comp = "basic"#Uses a simple, uncluttered comparison style
)

#Clean code:
s20x::rowdistr(
  crosstabs(~ Gender + Lbs, data = CPIIISecLbsGen.df),
  plot = TRUE,
  suppressText = FALSE,
  comp = "basic"
)

#Frequency Distribution by Section and Weight
s20x::rowdistr(
  crosstabs(~ Section + Lbs, data = CPIIISecLbsGen.df),
  plot = TRUE,
  suppressText = FALSE,
  comp = "basic"
)

################################################################################################

#Specialized External Package : arsenal Package for large-scale statistical summaries
#####################################################################################

#The arsenal::tableby() function is designed to produce highly structured summary tables.
#It combines:
             Descriptive statistics
             Group-wise breakouts
             Clear, publication-style formatting
			 
install.packages("arsenal", dependencies=TRUE)
library(arsenal)
help(package = arsenal)
sessionInfo()

#Why tableby() Is Useful
#Unlike earlier functions that summarize:
             One factor at a time
             Or require multiple tables

#tableby() allows:
             Two or more factor-type variables to be summarized simultaneously
             All group comparisons to appear in one table

#This improves:
             Readability
             Efficiency
             Consistency

#Creating a Combined Descriptive Table
summary(
  arsenal::tableby(list(Section, Gender) ~ Lbs,
                   data = CPIIISecLbsGen.df),
  text = TRUE,
  total = TRUE
)

list(Section, Gender) ~ Lbs
#Specifies breakout variables on the left:
             Section (AM, PM)
             Gender (Female, Male)

#Specifies the numeric variable on the right:
             Lbs (weight)
			 
################################################################################################

#Specialized External Package : pivottabler Package for Descriptive Summary Tables
##################################################################################
#A pivot table is a powerful data summarization tool in spreadsheets that lets you quickly group, count, average, or sum large datasets, revealing trends and patterns by "pivoting" (rearranging) rows and columns without formulas. 


#The pivottabler package is used to create pivot-style summary tables in R.
#It is especially useful for:
             Presenting descriptive statistics in a compact table
             Organizing results by rows and columns
             Exporting results in different formats (text, HTML, LaTeX)
			 
install.packages("pivottabler", dependencies = TRUE)
library(pivottabler)
help(package = pivottabler)
sessionInfo()

#Creating a Pivot Table (Mean and SD of Weight)
pivottabler::qpvt(
  CPIIISecLbsGen.df, #The data frame used for the summary
  "Gender",          #Defines the row variable
  "Section",         #Defines the column variable
  c("Mean Lbs" = "mean(Lbs, na.rm=TRUE)", #Computes mean of weight. na.rm=TRUE excludes missing values
    "SD Lbs"   = "sd(Lbs, na.rm=TRUE)"),  #Computes standard deviation of weight
  formats = list("%.0f", #no decimal places for means
  "%.1f")                #one decimal place for SD
)

#Clean code
pivottabler::qpvt(
  CPIIISecLbsGen.df,
  "Gender",
  "Section",
  c("Mean Lbs" = "mean(Lbs, na.rm=TRUE)",
    "SD Lbs"   = "sd(Lbs, na.rm=TRUE)"),
  formats = list("%.0f", "%.1f")
)

#Creating a Pivot Table (Median of Weight)
pivottabler::qpvt(
  CPIIISecLbsGen.df,
  "Section",
  "Gender",
  c("Median Lbs" = "median(Lbs, na.rm=TRUE)"),
  formats = list("%.0f", "%.1f")
)

#Output Formats Supported by pivottabler
#The same summaries can be exported in different formats:
             qpvt() → plain text (console, Notepad)
             qhpvt() → HTML (web pages, reports)
             qlpvt() → LaTeX (academic manuscripts)
			 


