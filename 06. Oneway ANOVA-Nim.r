###############################################################
# Master in Biochemistry and Biotechnology – Semester I 
# Topic : Oneway Analysis of Variance(ANOVA) -6
# Course: BCBT 54813 - Biostatistics
# Author: Nimroth Ambanpola
##############################################################

#Oneway Analysis of Variance (Oneway ANOVA)
##########################################

#Oneway ANOVA is an inferential statistical test used to determine whether there are statistically significant differences between the means of 3 or more groups when the outcome variable is continuous.

#Oneway ANOVA is used when:
             There are 3 or more independent groups
             There is one continuous measured variable

#This test is commonly applied in biological, agricultural, and health sciences research.

| Test                                     | When to Use                                           | Number of Groups | Measurements per Subject | Example                                        |
| ---------------------------------------- | ----------------------------------------------------- | ---------------- | ------------------------ | ---------------------------------------------- |
| Student’s *t*-Test (Independent Samples) | Compare means of **two independent groups**           | 2                | One measurement          | Male vs Female blood pressure                  |
| Student’s *t*-Test (Matched Pairs)       | Compare **two related measurements**                  | 1 (paired)       | Two measurements         | Pretest vs Posttest weight                     |
| Oneway ANOVA                             | Compare means of **three or more independent groups** | ≥ 3              | One measurement          | Sedentary vs Moderate vs Active blood pressure |



#Why Self-Generated Datasets Are Used 
#####################################

#Self-generated datasets are used to support learning, consistency, and reproducibility.
             Is fully reproducible, meaning the same data can be regenerated at any time
             Allows all students and readers to obtain identical results
             Makes it easier to demonstrate statistical methods step by step
             Avoids issues related to missing, confidential, or poorly documented real data

#Nature of the Generated Dataset
#The dataset generated in this lesson represents systolic blood pressure measurements for individuals grouped by lifestyle and exercise behavior.

#Key characteristics of the dataset:
             The data are numerical and continuous
             Values represent systolic blood pressure
             Subjects are divided into three independent groups:
                 Sedentary
				 Moderate
				 Active
             Each group contains an equal number of observations
             The data are generated to follow an approximately normal distribution
             Group means and variability differ to reflect realistic biological differences

#The goal is to test whether mean blood pressure differs across three or more groups.

base::set.seed(8) # Set the seed

| Term         | Meaning                                           |
| ------------ | ------------------------------------------------- |
| `base`       | R’s base package containing basic functions       |
| `::`         | Selects a function from a specific package        |
| `set.seed()` | Fixes the random number generator                 |
| `8`          | Seed value (any integer; ensures reproducibility) |

ExerciseWide.df <- data.frame(
  Sedentary <- round(rnorm(50, mean = 136, sd = 8)), 
  Moderate  <- round(rnorm(50, mean = 134, sd = 6)),
  Active    <- round(rnorm(50, mean = 122, sd = 4))
)

#This code creates a wide-format data frame called ExerciseWide.df.
             rnorm() generates random values from a normal distribution
             50 specifies the number of observations per group
             mean represents the average systolic blood pressure
             sd represents variability within each group
             round() converts the values to whole numbers, which is appropriate for blood pressure measurements. 
			 Sedentary <- rnorm(50, mean = 136, sd = 8) This keeps the data continuous rather than whole numbers.

colnames(ExerciseWide.df) <- c("Sedentary", "Moderate", "Active")
#This line explicitly sets the column names.
#Although the columns already have names, this step ensures clarity and consistency, especially after data manipulation.


#################################################################################################
#Essential Steps After Importing / Generating Data in R
#######################################################
#(Oneway ANOVA – n # Independent Groups)
########################################
#Step 1: Confirm the Data Exist
#Purpose: Ensure the dataset is available and readable.

ls()
class(ExerciseWide.df)

#Step 2: Inspect Dataset 
#Purpose: Verify dimensions and variable types.

str(ExerciseWide.df)
dim(ExerciseWide.df)
nrow(ExerciseWide.df)
ncol(ExerciseWide.df)
head(ExerciseWide.df, 5)
tail(ExerciseWide.df, 5)


#Step 3: Verify Data Types
#Purpose: ANOVA requires numeric outcome values.

class(ExerciseWide.df$Sedentary)
class(ExerciseWide.df$Moderate)
class(ExerciseWide.df$Active)


#Step 4: Check for Missing Data
#Purpose: Missing data affect group comparisons.

table(is.na(ExerciseWide.df))

(#Optional removal)

ExerciseWide_complete.df <- ExerciseWide.df[complete.cases(ExerciseWide.df), ]

#Step 5: Generate Descriptive Statistics
#Purpose: Understand group-level patterns.

summary(ExerciseWide.df)
summary(ExerciseWide_complete.df)

mean(ExerciseWide.df$Sedentary); sd(ExerciseWide.df$Sedentary)
mean(ExerciseWide.df$Moderate); sd(ExerciseWide.df$Moderate)
mean(ExerciseWide.df$Active); sd(ExerciseWide.df$Active)


library(epiDisplay) # Load the epiDisplay package.

par(ask=TRUE) # Pause
par(mfrow=c(1,3)) # 3 figures - 1 row by 3 column grid
epiDisplay::summ(ExerciseWide.df$Sedentary, xlim=c(100,160))
epiDisplay::summ(ExerciseWide.df$Moderate, xlim=c(100,160))
epiDisplay::summ(ExerciseWide.df$Active, xlim=c(100,160))
# Along with the comparative side-by-side figure, review the descriptive statistics printed to the screen.

#################################################################################################
#Step 6: Visualize the Data
#Purpose: Detect outliers and distribution shape.

# Histogram
par(ask=TRUE) # Pause
par(mfrow=c(1,3)) # 3 figures - 1 row by 3 column grid

hist(ExerciseWide.df$Sedentary,
main="Systolic Blood Pressure - Sedentary",
col="red", # Add color
breaks=15, # Increase granularity of histogram
font.lab=2, # Bold labels
xlab="Systolic Blood Pressure", # X label
xlim=c(100,160), # X axis scale
ylim=c(0,8)) # Y axis scale
axis(side=1, font=2) # X axis bold
axis(side=2, font=2) # Y axis bold

hist(ExerciseWide.df$Moderate,
main="Systolic Blood Pressure - Moderate",
col="red", # Add color
breaks=15, # Increase granularity of histogram
font.lab=2, # Bold labels
xlab="Systolic Blood Pressure", # X label
xlim=c(100,160), # X axis scale
ylim=c(0,8)) # Y axis scale
axis(side=1, font=2) # X axis bold
axis(side=2, font=2) # Y axis bold

hist(ExerciseWide.df$Active,
main="Systolic Blood Pressure - Active",
col="red", # Add color
breaks=15, # Increase granularity of histogram
font.lab=2, # Bold labels
xlab="Systolic Blood Pressure", # X label
xlim=c(100,160), # X axis scale
ylim=c(0,8)) # Y axis scale
axis(side=1, font=2) # X axis bold
axis(side=2, font=2) # Y axis bold


# Density Plot
par(ask=TRUE) # Pause
par(mfrow=c(1,3)) # 3 figures - 1 row by 3 column grid

plot(density(ExerciseWide.df$Sedentary),
main="Systolic Blood Pressure - Sedentary",
col="red", # Add color
lwd=3, # Thick line
font.lab=2, # Bold labels
xlab="Density", # X axis label
xlim=c(100,160), # X axis scale
ylim=c(0,0.08)) # Y axis scale
axis(side=1, font=2) # X axis bold
axis(side=2, font=2) # Y axis bold

plot(density(ExerciseWide.df$Moderate),
main="Systolic Blood Pressure - Moderate",
col="red", # Add color
lwd=3, # Thick line
font.lab=2, # Bold labels
xlab="Density", # X axis label
xlim=c(100,160), # X axis scale
ylim=c(0,0.08)) # Y axis scale
axis(side=1, font=2) # X axis bold
axis(side=2, font=2) # Y axis bold

plot(density(ExerciseWide.df$Active),
main="Systolic Blood Pressure - Active",
col="red", # Add color
lwd=3, # Thick line
font.lab=2, # Bold labels
xlab="Density", # X axis label
xlim=c(100,160), # X axis scale
ylim=c(0,0.08)) # Y axis scale
axis(side=1, font=2) # X axis bold
axis(side=2, font=2) # Y axis bold


library(ggplot2) # Load the ggplot2 package.


DensityCurveSedentary <-
ggplot2::ggplot(ExerciseWide.df,
aes(x=Sedentary)) +
geom_density(size=1.5, col=("red")) +
ggtitle(
"Sedentary Lifestyle Density Curve, Overall SBP") +
scale_x_continuous(name="Systolic Blood Pressure)",
limits=c(100,160), breaks=seq(100,160,10)) +
scale_y_continuous(name="Density", limits=c(0.0,0.09),
breaks=seq(0.0,0.09,0.025)) +
theme_classic()

DensityCurveModerate <-
ggplot2::ggplot(ExerciseWide.df,
aes(x=Moderate)) +
geom_density(size=1.5, col=("red")) +
ggtitle(
"Moderate Lifestyle Density Curve, Overall SBP") +
scale_x_continuous(name="Systolic Blood Pressure)",
limits=c(100,160), breaks=seq(100,160,10)) +
scale_y_continuous(name="Density", limits=c(0.0,0.09),
breaks=seq(0.0,0.09,0.025)) +
theme_classic()

DensityCurveActive <-
ggplot2::ggplot(ExerciseWide.df,
aes(x=Active)) +
geom_density(size=1.5, col=("red")) +
ggtitle(
"Active Lifestyle Density Curve, Overall SBP") +
scale_x_continuous(name="Systolic Blood Pressure)",
limits=c(100,160), breaks=seq(100,160,10)) +
scale_y_continuous(name="Density", limits=c(0.0,0.09),
breaks=seq(0.0,0.09,0.025)) +
theme_classic()

par(ask=TRUE)
gridExtra::grid.arrange(
DensityCurveSedentary,
DensityCurveModerate,
DensityCurveActive, ncol=3)


# Boxplot
par(ask=TRUE) # Pause
par(mfrow=c(1,3)) # 3 figures - 1 row by 3 column grid

boxplot(ExerciseWide.df$Sedentary,
main="Systolic Blood Pressure - Sedentary",
xlab="Boxplot", # X axis label
ylab="Systolic Blood Pressure", # Y axis label
cex.axis=1.15, # Axis size
cex.lab=1.15, # Label size
col="red", # Box color
lwd=1, # Line thickness
font.lab=2, # Bold labels
font=2, # Bold font
ylim=c(100,160)) # Y axis scale

boxplot(ExerciseWide.df$Moderate,
main="Systolic Blood Pressure - Moderate",
xlab="Boxplot", # X axis label
ylab="Systolic Blood Pressure", # Y axis label
cex.axis=1.15, # Axis size
cex.lab=1.15, # Label size
col="red", # Box color
lwd=1, # Line thickness
font.lab=2, # Bold labels
font=2, # Bold font
ylim=c(100,160)) # Y axis scale

boxplot(ExerciseWide.df$Active,
main="Systolic Blood Pressure - Active",
xlab="Boxplot", # X axis label
ylab="Systolic Blood Pressure", # Y axis label
cex.axis=1.15, # Axis size
cex.lab=1.15, # Label size
col="red", # Box color
lwd=1, # Line thickness
font.lab=2, # Bold labels
font=2, # Bold font
ylim=c(100,160)) # Y axis scale


# Q-Q Plot
par(ask=TRUE) # Pause
par(mfrow=c(1,3)) # 3 figures - 1 row by 3 column grid

qqnorm(ExerciseWide.df$Sedentary,
main="Systolic Blood Pressure - Sedentary",
col="blue", xlim=c(-4,4), ylim=c(100,160), font.axis=2,
font.lab=2)
qqline(ExerciseWide.df$Sedentary, col="red", lwd=4, lty=2)

qqnorm(ExerciseWide.df$Moderate,
main="Systolic Blood Pressure - Moderate",
col="blue", xlim=c(-4,4), ylim=c(100,160), font.axis=2,
font.lab=2)
qqline(ExerciseWide.df$Moderate, col="red", lwd=4, lty=2)

qqnorm(ExerciseWide.df$Active,
main="Systolic Blood Pressure - Active",
col="blue", xlim=c(-4,4), ylim=c(100,160), font.axis=2,
font.lab=2)
qqline(ExerciseWide.df$Active, col="red", lwd=4, lty=2)


library(ggplot2) # Load the ggplot2 package.

QQSedentary <-
ggplot2::ggplot(ExerciseWide.df,
aes(sample=Sedentary)) +
stat_qq(color="red") +
stat_qq_line(color="blue", size=1.05) +
ggtitle(
"Sedentary Lifestyle QQ-Plot and QQ-Line, Overall SBP") +
labs(x = "\nTheoretical", y = "Systolic Blood Pressure\n") +
ylim(100,160) +
theme_classic()

QQModerate <-
ggplot2::ggplot(ExerciseWide.df,
aes(sample=Moderate)) +
stat_qq(color="red") +
stat_qq_line(color="blue", size=1.05) +
ggtitle(
"Moderate Lifestyle QQ-Plot and QQ-Line, Overall SBP") +
labs(x = "\nTheoretical", y = "Systolic Blood Pressure\n") +
ylim(100,160) +
theme_classic()

QQActive <-
ggplot2::ggplot(ExerciseWide.df,
aes(sample=Active)) +
stat_qq(color="red") +
stat_qq_line(color="blue", size=1.05) +
ggtitle(
"Active Lifestyle QQ-Plot and QQ-Line, Overall SBP") +
labs(x = "\nTheoretical", y = "Systolic Blood Pressure\n") +
ylim(100,160) +
theme_classic()

par(ask=TRUE)
gridExtra::grid.arrange(
QQSedentary,
QQModerate,
QQActive, ncol=3)


# Dotchart
par(ask=TRUE) # Pause
par(mfrow=c(1,3)) # 3 figures - 1 row by 3 column grid

dotchart(ExerciseWide.df$Sedentary,
main="Systolic Blood Pressure - Sedentary",
xlab="Systolic Blood Pressure", # X axis label
cex.axis=1.15, # Axis size
cex.lab=1.15, # Label size
pch=16, # Dot symbol
pt.cex=1.15, # Dot size
col="red", # Dot color
font.lab=2, # Bold labels
font=2, # Bold font
xlim=c(100,160)) # X axis scale

dotchart(ExerciseWide.df$Moderate,
main="Systolic Blood Pressure - Moderate",
xlab="Systolic Blood Pressure", # X axis label
cex.axis=1.15, # Axis size
cex.lab=1.15, # Label size
pch=16, # Dot symbol
pt.cex=1.15, # Dot size
col="red", # Dot color
font.lab=2, # Bold labels
font=2, # Bold font
xlim=c(100,160)) # X axis scale

dotchart(ExerciseWide.df$Active,
main="Systolic Blood Pressure - Active",
xlab="Systolic Blood Pressure", # X axis label
cex.axis=1.15, # Axis size
cex.lab=1.15, # Label size
pch=16, # Dot symbol
pt.cex=1.15, # Dot size
col="red", # Dot color
font.lab=2, # Bold labels
font=2, # Bold font
xlim=c(100,160)) # X axis scale


#### Violin Plot
install.packages("vioplot")
library(vioplot) # Load the vioplot package.
help(package=vioplot) # Show the information page.
sessionInfo() # Confirm all attached packages.


par(ask=TRUE) # Pause
par(mfrow=c(1,3)) # 3 figures - 1 row by 3 column grid

vioplot::vioplot(ExerciseWide.df$Sedentary,
names=c("Systolic Blood Pressure - Sedentary"),
drawRect=TRUE, # Add the box
col="cyan", # Color of violin
ylim=c(100,160), # Y axis scale
horizontal=FALSE, # Horizontal violin plot
lty=2) # Dashed line
title("Systolic Blood Pressure - Sedentary")

vioplot::vioplot(ExerciseWide.df$Moderate,
names=c("Systolic Blood Pressure - Moderate"),
drawRect=TRUE, # Add the box
col="cyan", # Color of violin
ylim=c(100,160), # Y axis scale
horizontal=FALSE, # Horizontal violin plot
lty=2) # Dashed line
title("Systolic Blood Pressure - Moderate")

vioplot::vioplot(ExerciseWide.df$Active,
names=c("Systolic Blood Pressure - Active"),
drawRect=TRUE, # Add the box
col="cyan", # Color of violin
ylim=c(100,160), # Y axis scale
horizontal=FALSE, # Horizontal violin plot
lty=2) # Dashed line
title("Systolic Blood Pressure - Active")


#################################################################################################
#Step 7: Assess Normality (By Group)
#Purpose: Check ANOVA normality assumption. Significance Level: α = 0.05

shapiro.test(ExerciseWide.df$Sedentary)
shapiro.test(ExerciseWide.df$Moderate)
shapiro.test(ExerciseWide.df$Active)

| Lifestyle Group | p-value | Normality Decision  |
| --------------- | ------- | ------------------- |
| Sedentary       | 0.723   | Normality satisfied |
| Moderate        | 0.787   | Normality satisfied |
| Active          | 0.265   | Normality satisfied |

#Simple Interpretation
             All p-values are greater than 0.05
             The null hypothesis of normality is not rejected for any group
             Systolic blood pressure values are approximately normally distributed within each group
             The normality assumption for Oneway ANOVA is met


#################################################################################################
#Data Organization: Wide (unstacked) vs Stacked Format
######################################################
#Up to this point, analyses and graphics have been based on data stored in wide (unstacked) format, using the dataset ExerciseWide.df. 
#In wide format:
             Each group is stored in a separate column
                 One column for Sedentary
				 One column for Moderate
				 One column for Active

#While wide-format data are easy to read, most R functions for statistical modeling and graphics expect data in stacked (long) format.

#In stacked (long) format:
             All measured values are stored in one column
             A separate grouping variable identifies group membership
             Each row represents one observation

#Converting Data from Wide to Long Format
#########################################

install.packages("tidyr", dependencies = TRUE)
library(tidyr)
help(package = tidyr)
sessionInfo()

#tidyr provides tools for reshaping data
#tidyr is a programming library, that is part of the tidyverse collection of packages.

#List all packages in the tidyverse
#>  [1] "broom"         "cli"           "conflicted"    "dbplyr"       
#>  [5] "dplyr"         "dtplyr"        "forcats"       "ggplot2"      
#>  [9] "googledrive"   "googlesheets4" "haven"         "hms"          
#> [13] "httr"          "jsonlite"      "lubridate"     "magrittr"     
#> [17] "modelr"        "pillar"        "purrr"         "ragg"         
#> [21] "readr"         "readxl"        "reprex"        "rlang"        
#> [25] "rstudioapi"    "rvest"         "stringr"       "tibble"       
#> [29] "tidyr"         "xml2"          "tidyverse"    

#Read more: https://tidyverse.org/packages/


#Transforming the Data (Wide → Long)
#General pattern:
LongData <- WideData %>%
  tidyr::gather(GroupVariable, MeasuredValue, Group1:GroupN)

#eg:
ExerciseLong.df <- ExerciseWide.df %>%
  tidyr::gather(Lifestyle, SBP, Sedentary:Active)

| Part               | Meaning                             |
| ------------------ | ----------------------------------- |
| `ExerciseLong.df`  | New dataset in long format          |
| `ExerciseWide.df`  | Original dataset in wide format     |
| `%>%`              | Pipe operator (passes data forward) |
| `gather()`         | Reshapes data from wide to long     |
| `Lifestyle`        | New grouping variable (column name) |
| `SBP`              | New measured-value column           |
| `Sedentary:Active` | Columns to be combined              |
  


#Confirming the Transformation

str(ExerciseLong.df)
length(ExerciseLong.df)
head(ExerciseLong.df, 5)
tail(ExerciseLong.df, 5)
summary(ExerciseLong.df)


#Adding a Subject Identifier
#Adding a subject ID can be useful for tracking observations.

ExerciseLong.df$Subject <- factor(seq(from = 1, to = 150, by = 1))


#Checking Group Balance
table(ExerciseLong.df$Lifestyle)


#Quality Assurance Check
########################
#Overall Distribution of the Measured Variable
par(mfrow = c(1, 1))
par(oma = c(0, 0, 0, 0))
par(mar = c(5, 5, 4, 2))

epiDisplay::tab1(ExerciseLong.df$SBP, graph = TRUE)

| Command                   | What It Controls                         | Why / When to Use                                |
| --------------------------| ---------------------------------------- | ------------------------------------------------ |
| `par(mfrow = c(1, 1))`    | Number of plots per window               | Use to ensure **only one plot** fills the window |
| `par(oma = c(0, 0, 0, 0))`| Outer margins                            | Removes extra outer white space                  |
| `par(mar = c(5, 5, 4, 2))`| Inner margins (bottom, left, top, right) | Expands the plotting area                        |




#Distribution by Group (Lifestyle)
epiDisplay::summ(
  ExerciseLong.df$SBP,
  by = ExerciseLong.df$Lifestyle,
  graph = TRUE
)


#Comparing Groups Visually
epiDisplay::tabpct(
  ExerciseLong.df$SBP,
  ExerciseLong.df$Lifestyle,
  main = "Systolic Blood Pressure by Lifestyle",
  xlab = "Systolic Blood Pressure",
  ylab = "Lifestyle",
  col = c("red", "blue", "black"),
  percent = c("col")
)


# Histogram breakouts using the ggplot2::ggplot() function
#First create the Custom Theme: theme_MacYates()

theme_MacYates <- function(base_size = 12, base_family = "sans") {
  theme(
    plot.title = element_text(face = "bold", size = 14, hjust = 0),
    axis.title.x = element_text(face = "bold", size = 14, hjust = 0.5),
    axis.text.x = element_text(face = "bold", size = 10),
    axis.title.y = element_text(face = "bold", size = 14, vjust = 1, angle = 90),
    axis.text.y = element_text(face = "bold", size = 12, hjust = 1),
    legend.title = element_text(face = "bold", size = 14),
    legend.text = element_text(face = "bold", size = 14),
    axis.ticks.x = element_line(size = 1.2),
    axis.ticks.y = element_line(size = 1.2),
    axis.ticks.length = unit(0.25, "cm"),
    panel.background = element_rect(fill = "whitesmoke")
  )
}


par(ask=TRUE)

ggplot2::ggplot(ExerciseLong.df,
aes(x=SBP, fill=Lifestyle)) +
geom_histogram(position="identity", color="white",
bins = 15) +
facet_grid(. ~ Lifestyle) +
ggtitle("
Systolic Blood Pressure (Histogram) by Lifestyle:
Active, Moderate, and Sedentary") +
labs(
x = "\nSystolic Blood Pressure", y = "Count\n") +
theme_MacYates()


# Density Plot breakouts using the ggplot2::ggplot() function
par(ask=TRUE)

ggplot2::ggplot(ExerciseLong.df,
aes(SBP, color=Lifestyle)) +
geom_density(size=1.25) +
ggtitle("
Systolic Blood Pressure (Density Plot) by Lifestyle:
Active, Moderate, and Sedentary") +
labs(
x = "\nSystolic Blood Pressure", y = "Density\n") +
theme_MacYates()


# Box Plot breakouts using the ggplot2::ggplot() function
par(ask=TRUE)
ggplot2::ggplot(ExerciseLong.df,
aes(x=Lifestyle, y=SBP)) +
geom_boxplot(aes(fill=Lifestyle)) +
ggtitle("
Systolic Blood Pressure (Boxplot) by Lifestyle:
Active, Moderate, and Sedentary") +
labs(
x = "\nLifestyle", y = "Systolic Blood Pressure\n") +
theme_MacYates()


# Q-Q Plot and Q-Q Line breakouts using the ggplot2::ggplot()function
par(ask=TRUE)

ggplot2::ggplot(ExerciseLong.df,
aes(sample=SBP)) +
stat_qq(color="red") +
stat_qq_line(color="black", size=1.75) +
facet_grid(. ~ Lifestyle) +
ggtitle("
Systolic Blood Pressure (QQ-Plot and QQ-Line) by Lifestyle:
Active, Moderate, and Sedentary") +
labs(
x = "\nTheoretical", y = "Systolic Blood Pressure\n") +
theme_MacYates()


# Violin Plot breakouts using the ggplot2::ggplot() function
par(ask=TRUE)
ggplot2::ggplot(ExerciseLong.df,
aes(x = Lifestyle, y = SBP)) +
geom_violin(aes(fill=Lifestyle)) +
ggtitle("
Systolic Blood Pressure (Violin Plot) by Lifestyle:
Active, Moderate, and Sedentary") +
labs(
x = "\nLifestyle", y = "Systolic Blood Pressure\n") +
theme_MacYates()


# Dot Plot breakouts using the ggplot2::ggplot() function
par(ask=TRUE)
ggplot2::ggplot(ExerciseLong.df,
aes(x = Lifestyle, y = SBP)) +
geom_dotplot(binaxis = "y", stackdir = "center",
aes(fill=Lifestyle), binwidth=2) +
ggtitle("
Systolic Blood Pressure (Dot Plot) by Lifestyle:
Active, Moderate, and Sedentary") +
labs(
x = "\nLifestyle", y = "Systolic Blood Pressure\n") +
theme_MacYates()

#################################################################################################
#Step 8: Confirm Study Design
#Purpose: Ensure correct test selection.

#Use Oneway ANOVA only if:
             3 or more independent groups (Sedentary, Moderate, Active)
			 One continuous outcome (SBP)
			 Each subject belongs to one group only (no repeated measures)

#Quick check in R (balanced groups):

table(ExerciseLong.df$Lifestyle)


#Step 9: Assess Homogeneity of Variances
#Purpose: Check equal variance assumption. 
#Oneway ANOVA assumes similar variances across groups.

#Option A (robust): Fligner–Killeen test (recommended)

fligner.test(SBP ~ Lifestyle, data = ExerciseLong.df)

#Interpretation rule
             If p > 0.05 → variances are similar (assumption satisfied)
			 If p ≤ 0.05 → variances differ (consider Welch ANOVA or nonparametric test)
#Output
p-value = 0.02292
The p-value is less than 0.05

#Interpretation:
             The null hypothesis of equal variances is rejected. This indicates that the variances of systolic blood pressure are not equal across Lifestyle groups.

#Implication:
             Because the equal-variance assumption is violated, the standard Oneway ANOVA assumption is not fully met. In this situation, Welch’s ANOVA or a nonparametric alternative (Kruskal–Wallis) is more appropriate.

#Option B: Bartlett test (sensitive to non-normality)

bartlett.test(SBP ~ Lifestyle, data = ExerciseLong.df)

#Output
p-value = 0.001484
The p-value is less than 0.05

#Interpretation:
             The null hypothesis of equal variances is rejected. This indicates that the variances of systolic blood pressure differ significantly across Lifestyle groups.

#Implication:
             Because the equal-variance assumption is violated, the standard Oneway ANOVA assumption is not satisfied. In this case, Welch’s ANOVA or a nonparametric alternative (Kruskal–Wallis test) should be considered.

#If Assumptions Fail
#If variance assumption fails → use Welch’s ANOVA
#If normality is strongly violated → use Kruskal–Wallis


#################################################################################################
#Step 10: State the Hypotheses
#Purpose: Define inference clearly.

Null Hypothesis (H₀):
There is no statistically significant difference (p ≤ 0.05) in systolic blood pressure among subjects based on lifestyle group (Sedentary, Moderate, Active).

Because the data are self-generated, they are expected to follow an approximately normal distribution.
H₀:
There is no statistically significant difference in mean systolic blood pressure among Sedentary, Moderate, and Active groups.

H₁:
At least one group mean differs.

Significance level:
α = 0.05

#################################################################################################
#Step 11: Exploratory analysis
###############################
#Purpose: To determine whether any statistically significant differences exist among group means, without yet identifying which groups differ.

oneway.test(SBP ~ Lifestyle, data = ExerciseLong.df, var.equal = TRUE)

#Output:
One-way analysis of means
p-value <0.0000000000000002

#Tests whether mean Systolic Blood Pressure (SBP) differs among lifestyle groups
#Assumes equal variances across groups

oneway.test(SBP ~ Lifestyle, data = ExerciseLong.df, var.equal = FALSE)

#Output:
One-way analysis of means (not assuming equal variances)
p-value <0.0000000000000002

#Performs the same test without assuming equal variances

#Interpretation
             In both cases, the p-value is much smaller than 0.05
             Therefore, the null hypothesis is rejected
             There is a statistically significant difference in mean SBP among Lifestyle groups

#################################################################################################
#Step 12: Conduct Oneway ANOVA
#Oneway ANOVA – Method 1: lm() and anova()
##########################################

anova(lm(SBP ~ Lifestyle - 1, data = ExerciseLong.df,
         na.action = na.exclude))

| Code Part                | Meaning                                                                 |
| ------------------------ | ----------------------------------------------------------------------- |
| `lm()`                   | Fits a **linear model**                                                 |
| `SBP`                    | Dependent (measured) variable: Systolic Blood Pressure                  |
| `~`                      | Separates the outcome from the predictors                               |
| `Lifestyle`              | Independent (grouping) variable                                         |
| `- 1`                    | Removes the intercept so groups are compared **directly to each other** |
| `data = ExerciseLong.df` | Specifies the dataset used                                              |
| `na.action = na.exclude` | Excludes missing values but keeps alignment                             |
| `anova()`                | Produces the **ANOVA table** from the fitted model                      |


#Output Interpretation
| Term         | Meaning        | Interpretation in This Output                             |
| ------------ | ---------------| --------------------------------------------------------- |
| **F value**  | Test statistic | Very large F (18599) indicates strong group differences   |
| **Pr(>F)**   | p-value        | p < 0.05 → statistically significant                      |


#The p-value for Lifestyle is < 0.05
#This confirms a statistically significant difference in SBP among groups
#The F-statistic indicates how large the between-group variation is relative to within-group variation


#Oneway ANOVA – Method 2: aov() Function
########################################
summary(aov(SBP ~ Lifestyle, data = ExerciseLong.df))

#Performs a standard Oneway ANOVA


#Output Interpretation
| Term         | Meaning        | Interpretation in This Output                             |
| ------------ | ---------------| --------------------------------------------------------- |
| **F value**  | Test statistic | Very large F (61.4) indicates strong group differences   |
| **Pr(>F)**   | p-value        | p < 0.05 → statistically significant                      |

#The null hypothesis is rejected
#There is a significant difference in mean SBP among Lifestyle groups



#Why These Results Are Not Sufficient Alone
###########################################
#Unlike a Student’s t-test (which compares only two groups), Oneway ANOVA compares three or more groups. 
#A significant ANOVA result raises important follow-up questions, such as:
             Which specific Lifestyle groups differ?
			 Are some groups similar while others are different?
			 Is one group distinct from all others?

#Post-Hoc Mean Comparisons
#########################
#After a statistically significant Oneway ANOVA result, it is necessary to determine which specific group means differ and which are similar (in parity).
#This is done using a post-hoc mean comparison test.


#Common Post-Hoc Tests Used After Oneway ANOVA
| Test Name | Description                                   |
| --------- | --------------------------------------------- |
| Duncan    | Duncan’s multiple range test                  |
| LSD       | Least Significant Difference                  |
| Scheffé   | Scheffé’s test                                |
| SNK       | Student–Newman–Keuls test                     |
| Tukey     | Tukey’s Honestly Significant Difference (HSD) |


#Tukey’s HSD is often preferred because it:
             Controls the family-wise error rate
			 Is suitable for all pairwise comparisons
			 Works well with balanced designs


TukeyHSD(
  aov(SBP ~ Lifestyle, data = ExerciseLong.df),
  conf.level = 0.95
)


#TukeyHSD Output (Key Results)
#Pairwise Comparisons of Lifestyle Groups
| Comparison           | Mean Difference | Adjusted p-value | Interpretation                |
| -------------------- | --------------- | ---------------- | ----------------------------- |
| Moderate − Active    | 11.64           | < 0.05           | Statistically significant     |
| Sedentary − Active   | 13.96           | < 0.05           | Statistically significant     |
| Sedentary − Moderate | 2.32            | > 0.05           | Not statistically significant |

#Simple Interpretation
             Active vs Moderate: Mean SBP differs significantly
			 Active vs Sedentary: Mean SBP differs significantly
			 Sedentary vs Moderate: No significant difference

#This indicates that:
             The Active group is distinct from both Sedentary and Moderate
             Sedentary and Moderate groups are statistically similar in mean SBP

#A boxplot of SBP by Lifestyle was generated to visually support the statistical findings.
par(ask=TRUE)

ggplot2::ggplot(data=ExerciseLong.df,
aes(x=Lifestyle, y=SBP, fill=Lifestyle)) +
geom_boxplot() +
stat_summary(fun.y=mean, color="black", geom="point",
shape=18, size=2, show.legend=FALSE) +
stat_summary(fun.y=mean, color="black", geom="text",
size=6, show.legend=FALSE, vjust=1.50,
aes(label=round(..y.., digits=1))) +
labs(title=
"Mean Systolic Blood Pressure by Lifestyle:
Active, Moderate, and Sedentary",
caption="Mean shows as a small black dot inside the box
and median shows as a solid horizontal line.\n",
x="\nLifestyle",
y="Systolic Blood Pressure\n") +
theme(plot.caption=element_text(face="bold", size=08,
hjust=0.5, color="black")) +
theme(legend.position="none") +
theme_MacYates()

#################################################################################################
#Welch’s ANOVA
##############
#Welch’s ANOVA is a modification of Oneway ANOVA used to compare the means of three or more independent groups when the assumption of equal variances is violated.

#When to Use
             Normality is approximately satisfied
			 Homogeneity of variances is violated
			 Unequal group variances or unequal sample sizes

#R Function
oneway.test(outcome ~ group, var.equal = FALSE)

oneway.test(SBP ~ Lifestyle, data = ExerciseLong.df, var.equal = FALSE)

#Interpretation
             A significant p-value (p ≤ 0.05) indicates that at least one group mean differs

#Post-hoc tests are needed to identify which groups differ

#Output
p-value < 2.2 × 10⁻¹⁶
The p-value is far below 0.05

#Interpretation:
             The null hypothesis is rejected. This indicates that there is a statistically significant difference in mean systolic blood pressure among the Lifestyle groups.

#Implication:
             Because the equal-variance assumption was violated, Welch’s ANOVA is the appropriate test. The result confirms that at least one Lifestyle group differs in mean SBP from the others.

#Post-hoc Tests After Welch’s ANOVA
| Post-hoc Test                                  | When to Use                                   | Why It Is Appropriate                                                 |
| ---------------------------------------------- | --------------------------------------------- | --------------------------------------------------------------------- |
| **Games–Howell**                               | Unequal variances and/or unequal sample sizes | Specifically designed for Welch’s ANOVA; no equal-variance assumption |
| **Tamhane’s T2**                               | Unequal variances                             | Conservative; controls Type I error                                   |
| **Dunnett’s T3**                               | Unequal variances                             | Good for multiple pairwise comparisons                                |
| **Pairwise Welch t-tests** (with p-adjustment) | Simple alternative                            | Uses Welch t-test per pair with multiple-testing correction           |


#Games–Howell Post-hoc Test
###########################
install.packages("rstatix")
library(rstatix)

games_howell_test(ExerciseLong.df, SBP ~ Lifestyle)

#Output
| Comparison            | Mean Difference (SBP) | 95% CI        | Adjusted p-value | Significance         |
| --------------------- | --------------------: | ------------- | ---------------: | :------------------- |
| Active vs Moderate    |                  11.6 | 8.81 to 14.5  |     3.37 × 10⁻¹⁰ | **** (Significant)   |
| Active vs Sedentary   |                  14.0 | 10.8 to 17.2  |          < 0.001 | **** (Significant)   |
| Moderate vs Sedentary |                  2.32 | −1.27 to 5.91 |            0.278 | ns (Not significant) |


#Statistical Interpretation
             The SBP significantly lower in the Active group compared with both the Moderate and Sedentary groups (adjusted p < 0.05).
			 There is no statistically significant difference in systolic blood pressure between the Moderate and Sedentary groups (adjusted p > 0.05).


#################################################################################################
#Parametric vs Nonparametric Approaches
#######################################

#Parametric Approach to Oneway ANOVA

#Based on earlier analyses:
             Systolic Blood Pressure (SBP) data showed acceptable normality
             Group distributions were suitable for parametric testing
             Oneway ANOVA and Tukey’s HSD were applied
             Statistically significant differences were observed at p ≤ 0.05

#Therefore, the parametric Oneway ANOVA approach was justified for this dataset.

#Nonparametric Alternative to Oneway ANOVA
#Why Consider a Nonparametric Test?

#Even when parametric assumptions are met, it is good practice to ask:
             What if the data were not normally distributed?

#A nonparametric analysis:
             Does not assume normality
             Provides an independent check of conclusions
             Increases confidence in final interpretation

#Nonparametric Global Test: Kruskal–Wallis Test
kruskal.test(SBP ~ as.factor(Lifestyle),
             data = ExerciseLong.df)


| Test           | Statistic  | df | p-value | Decision  |
| -------------- | ---------- | -- | ------- | --------- |
| Kruskal–Wallis | χ² = 72.88 | 2  | < 0.05  | Reject H₀ |

#Interpretation
             The p-value is much smaller than 0.05
             The null hypothesis is rejected
             There is a statistically significant difference in SBP among Lifestyle groups

#⚠️ Limitation:
             Like Oneway ANOVA, the Kruskal–Wallis test only tells us that a difference exists, not which groups differ.

#Nonparametric Post-Hoc Test: Dunn’s Test
#To identify which groups differ, Dunn’s Test is used as the nonparametric equivalent of Tukey’s HSD.

install.packages("dunn.test", dependencies=TRUE)
library(dunn.test) # Load the dunn.test package.
help(package=dunn.test) # Show the information page.
sessionInfo() # Confirm all attached packages.


dunn.test::dunn.test(
  ExerciseLong.df$SBP,
  ExerciseLong.df$Lifestyle,
  method = "bonferroni",
  kw = TRUE
)

#Dunn’s Test Results (Adjusted p-values)
| Group Comparison      | Adjusted p-value | Interpretation                |
| --------------------- | ---------------- | ----------------------------- |
| Active vs Moderate    | < 0.05           | Statistically significant     |
| Active vs Sedentary   | < 0.05           | Statistically significant     |
| Moderate vs Sedentary | > 0.05           | Not statistically significant |

#Interpretation of Nonparametric Results
             SBP differs significantly between:
			     Active and Moderate
				 Active and Sedentary
			 No significant difference between:
			     Moderate and Sedentary

#These findings match exactly what was observed using:
             Parametric Oneway ANOVA
			 Tukey’s HSD test

#Parametric vs Nonparametric Summary
| Aspect            | Parametric              | Nonparametric    |
| ----------------- | ----------------------- | ---------------- |
| Global test       | Oneway ANOVA            | Kruskal–Wallis   |
| Post-hoc test     | Tukey HSD               | Dunn’s Test      |
| Assumes normality | Yes                     | No               |
| Results           | Significant differences | Same conclusions |

#Final Conclusion 
#Both parametric and nonparametric analyses lead to the same conclusion: systolic blood pressure differs significantly between the Active lifestyle group and the other groups, while Moderate and Sedentary groups do not differ significantly.

#Comparison of Group Comparison Tests
| Test               | Data Type             | Key Assumptions                                           | When to Use                                              |
| ------------------ | --------------------- | --------------------------------------------------------- | -------------------------------------------------------- |
| **Oneway ANOVA**   | Continuous            | Normality (by group), equal variances, independent groups | Standard test when assumptions are satisfied             |
| **Welch’s ANOVA**  | Continuous            | Normality (by group), **unequal variances allowed**       | Use when variances are not equal                         |
| **Kruskal–Wallis** | Continuous or ordinal | No normality assumption, independent groups               | Use when normality is violated or data are nonparametric |


#Key Terms in Nonparametric Post-Hoc Testing
| Term                 | What It Is                                | Why It Is Used                                                         |
| -------------------- | ----------------------------------------- | ---------------------------------------------------------------------- |
| **Dunn’s Test**      | A nonparametric post-hoc test             | Identifies which groups differ after a significant Kruskal–Wallis test |
| **Bonferroni**       | A p-value adjustment method               | Controls false positives when making multiple comparisons              |
| **p-value**          | Probability of observing results under H₀ | Used to decide statistical significance                                |
| **Adjusted p-value** | p-value corrected for multiple tests      | Prevents inflated Type I error                                         |
