###############################################################
# Master in Biochemistry and Biotechnology – Semester I 
# Topic : Twoway Analysis of Variance(ANOVA) -7
# Course: BCBT 54813 - Biostatistics
# Author: Nimroth Ambanpola
##############################################################

#Befor we continue the project......
getwd()#To check working directory
sessionInfo()#To confirm the R version and to gain information on the locale and available packages.


#Twoway Analysis of Variance(Twoway ANOVA)
##########################################
#Twoway ANOVA is used to determine whether differences in group means of a measured (dependent) variable are due to chance, true effects of multiple factors, or interactions between factors.
#It extends Oneway ANOVA by simultaneously analyzing two or more categorical independent variables (factors) and their combined effects on a single outcome.

#Factors and Variables
######################

#Independent variables (Factors):
             Gender (Female, Male)
			 Drug (Drug A, B, C, D, Placebo)
			 Race-Ethnicity (Black, Hispanic, Other, White)

#Dependent variable:
             Systolic Blood Pressure (SBP)

#Factors may be:
             Between-subjects (different individuals per group)
			 Within-subjects (repeated measures)
			 Organized in balanced or unbalanced designs

#Advantages of Twoway ANOVA
             Models complex biological relationships
			 Identifies joint effects of multiple factors
			 Reduces unexplained variability
			 One of the most commonly used inferential tests in biological sciences


#Data Structure and Format
             Long (stacked) format is used


#Data Entry Using read.table() and textConnection()
#For this lesson, the dataset is created directly within R by wrapping the read.table() function around the textConnection() function.

#Description of Variables
#The dataset is organized in long (stacked) format, with one row per subject.
| Variable   | Description                   | Type                       |
| ---------- | ----------------------------- | -------------------------- |
| Patient    | Unique subject identifier     | Character                  |
| Gender     | Female, Male                  | Factor (text)              |
| Drug       | 1–5 (Drug A–D, Placebo)       | Categorical (numeric code) |
| RaceEthnic | Black, Hispanic, Other, White | Factor (text)              |
| SBP        | Systolic Blood Pressure       | Numeric (integer)          |


SBPGenderDrugRaceEthnicLong.df <- read.table(textConnection("
PatientID Gender Drug RaceEthnic SBP
ID001 Female 1 Black 122
ID002 Female 1 Hispanic 124
ID003 Female 1 Other 118
ID004 Female 1 White 120
ID005 Female 1 Black 120
ID006 Female 1 Hispanic 122
ID007 Female 1 Other 118
ID008 Female 1 White 116
ID009 Female 2 Black 136
ID010 Female 2 Hispanic 138
ID011 Female 2 Other 128
ID012 Female 2 White 128
ID013 Female 2 Black 138
ID014 Female 2 Hispanic 138
ID015 Female 2 Other 124
ID016 Female 2 White 134
ID017 Female 3 Black 138
ID018 Female 3 Hispanic 118
ID019 Female 3 Other 124
ID020 Female 3 White 124
ID021 Female 3 Black 144
ID022 Female 3 Hispanic 144
ID023 Female 3 Other 118
ID024 Female 3 White 122
ID025 Female 4 Black 142
ID026 Female 4 Hispanic 126
ID027 Female 4 Other 118
ID028 Female 4 White 134
ID029 Female 4 Black 124
ID030 Female 4 Hispanic 138
ID031 Female 4 Other 128
ID032 Female 4 White 128
ID033 Female 5 Black 128
ID034 Female 5 Hispanic 120
ID035 Female 5 Other 124
ID036 Female 5 White 124
ID037 Female 5 Black 120
ID038 Female 5 Hispanic 118
ID039 Female 5 Other 120
ID040 Female 5 White 122
ID041 Male 1 Black 137
ID042 Male 1 Hispanic 134
ID043 Male 1 Other 129
ID044 Male 1 White 126
ID045 Male 1 Black 126
ID046 Male 1 Hispanic 128
ID047 Male 1 Other 118
ID048 Male 1 White 120
ID049 Male 2 Black 141
ID050 Male 2 Hispanic 129
ID051 Male 2 Other 115
ID052 Male 2 White 124
ID053 Male 2 Black 144
ID054 Male 2 Hispanic 139
ID055 Male 2 Other 121
ID056 Male 2 White 121
ID057 Male 3 Black 153
ID058 Male 3 Hispanic 132
ID059 Male 3 Other 124
ID060 Male 3 White 131
ID061 Male 3 Black 137
ID062 Male 3 Hispanic 134
ID063 Male 3 Other 129
ID064 Male 3 White 130
ID065 Male 4 Black 136
ID066 Male 4 Hispanic 138
ID067 Male 4 Other 118
ID068 Male 4 White 124
ID069 Male 4 Black 131
ID070 Male 4 Hispanic 129
ID071 Male 4 Other 115
ID072 Male 4 White 126
ID073 Male 5 Black 144
ID074 Male 5 Hispanic 139
ID075 Male 5 Other 121
ID076 Male 5 White 121
ID077 Male 5 Black 153
ID078 Male 5 Hispanic 122
ID079 Male 5 Other 124
ID080 Male 5 White 130"), header=TRUE)

#Renaming Columns for Clarity
#Although the dataset already contains a header row, column names are explicitly reassigned to reinforce clarity and demonstrate how column names can be modified easily.

colnames(SBPGenderDrugRaceEthnicLong.df) <-
  c("Patient", "Gender", "Drug", "RaceEthnic", "SBP")


#Note: PatientID was renamed to Patient to emphasize flexibility in data management.

#Preparing the Data for Analysis
#Before conducting a Twoway ANOVA, it is essential to ensure that each variable is in the correct format.

#Typical preparation steps include:

str(SBPGenderDrugRaceEthnicLong.df)
head(SBPGenderDrugRaceEthnicLong.df)
summary(SBPGenderDrugRaceEthnicLong.df)


#Recommended additional formatting:

SBPGenderDrugRaceEthnicLong.df$Gender <- as.factor(SBPGenderDrugRaceEthnicLong.df$Gender)
SBPGenderDrugRaceEthnicLong.df$RaceEthnic <- as.factor(SBPGenderDrugRaceEthnicLong.df$RaceEthnic)
SBPGenderDrugRaceEthnicLong.df$Drug <- as.factor(SBPGenderDrugRaceEthnicLong.df$Drug)

#These preparation steps ensure that:
             Categorical predictors are treated as factors
             The dataset is suitable for Twoway (or factorial) ANOVA

#################################################################################################
#Inspecting and Correcting Data Types

#After importing the dataset, the str() function is used to examine the internal structure of the dataframe. 
#This step is critical because statistical models in R (including Twoway ANOVA) depend heavily on correct variable types.

str(SBPGenderDrugRaceEthnicLong.df)

#From the output of str(), it becomes evident that:
             Drug is stored as an integer
             SBP is stored as an integer

#While these formats are not technically wrong, they are not appropriate for analysis in their current form.

#Why Transformation Is Necessary
################################

#Drug (Independent Variable)
             Drug represents categories, not quantities
			 Numeric codes (1–5) are only identifiers
			 If left as integers, R may treat Drug as a continuous variable, which is incorrect

#Therefore, Drug must be converted to a factor, with meaningful labels.

#SBP (Dependent Variable)
             SBP is a measured continuous variable
			 Although entered as integers, it should be explicitly treated as numeric
			 This ensures correct calculation of means, variances, and test statistics

#Therefore, SBP must be converted to numeric.

#Transforming Drug from Integer to Factor (with Labels)
SBPGenderDrugRaceEthnicLong.df$Drug <-
  factor(SBPGenderDrugRaceEthnicLong.df$Drug,
         labels = c("Drug A", "Drug B", "Drug C",
                    "Drug D", "Placebo"))


#This transformation accomplishes two things:
             Converts Drug into a factor-type variable
			 Replaces numeric codes with interpretable labels

#To confirm the transformation:

levels(SBPGenderDrugRaceEthnicLong.df$Drug)

Output
"Drug A" "Drug B" "Drug C" "Drug D" "Placebo"

#Verifying Group Sizes
summary(SBPGenderDrugRaceEthnicLong.df$Drug)

Output
Drug A   Drug B   Drug C   Drug D   Placebo
16       16       16       16       16


#This confirms:
             Each drug group contains 16 observations
             The study design is balanced, which is ideal for ANOVA

#Transforming SBP from Integer to Numeric
SBPGenderDrugRaceEthnicLong.df$SBP <-
  as.numeric(SBPGenderDrugRaceEthnicLong.df$SBP)

#This ensures SBP is treated as a continuous numeric variable.

summary(SBPGenderDrugRaceEthnicLong.df$SBP)

Output
Min.    1st Qu. Median Mean  3rd Qu. Max.
115     121     126    128   134     153


#Final Data Inspection 
attach(SBPGenderDrugRaceEthnicLong.df)
str(SBPGenderDrugRaceEthnicLong.df)
names(SBPGenderDrugRaceEthnicLong.df)
head(SBPGenderDrugRaceEthnicLong.df, 5)
tail(SBPGenderDrugRaceEthnicLong.df, 5)
summary(SBPGenderDrugRaceEthnicLong.df)

#################################################################################################
#Conducting a Visual Data Check Using Graphics
##############################################
#Visualizing the Overall Distribution of SBP

#As a first step, the density plot and histogram are used to examine the overall distribution of Systolic Blood Pressure (SBP).
par(ask=TRUE)
par(mfrow=c(1,2))  # 1 row, 2 columns

plot(density(SBPGenderDrugRaceEthnicLong.df$SBP),
main="Systolic Blood Pressure - Overall",
col="red", # Add color
lwd=3, # Thick line
font.lab=2, # Bold labels
xlab="SBP", # X axis label
xlim=c(100,160), # X axis scale
ylim=c(0,0.05)) # Y axis scale
axis(side=1, font=2) # X axis bold
axis(side=2, font=2) # Y axis bold

hist(SBPGenderDrugRaceEthnicLong.df$SBP,
main="Systolic Blood Pressure - Overall",
xlab="SBP", breaks=20, col="red",
xlim=c(100,160), ylim=c(0,12), font.lab=2,
tck=-0.05)
axis(side=1, font=2) # X axis bold
axis(side=2, font=2) # Y axis bold

#Overall SBP Distribution (Violin Plot)

SBPViolinOverall <-
ggplot2::ggplot(SBPGenderDrugRaceEthnicLong.df,
aes(x=SBP, y=SBP)) +
# SBP has been used for both the x and y aesthetic
# (e.g., aes). Note below how the coordinates are
# flipped, thus the reason for what may otherwise seem
# to be a mistake for X axis and Y axis placement.
geom_violin(fill="red", color="black",
lwd=2) + # Violin Plot geom
ggtitle(
"Systolic Blood Pressure, Overall\n") +
scale_x_discrete(name="") +
scale_y_continuous(name="Systolic Blood Pressure\n",
limits=c(110,155), breaks=seq(110,155,20)) +
theme_bw() +
coord_flip() # Rotate (e.g., flip) the presentation

#SBP by Gender

SBPViolinGender <-
ggplot2::ggplot(SBPGenderDrugRaceEthnicLong.df,
aes(x=Gender, y=SBP, group=Gender)) +
geom_violin(aes(fill=Gender)) + # Violin Plot geom
ggtitle(
"Systolic Blood Pressure by Gender\n") +
scale_x_discrete(name="") +
scale_y_continuous(name="Systolic Blood Pressure\n",
limits=c(110,155), breaks=seq(110,155,20)) +
# The coordinates are flipped, thus the reason for what
# seems to be a mistake for the X axis and Y axis.
theme_bw() +
theme(legend.position="none") +
coord_flip() # Rotate (e.g., flip) the presentation


#SBP by Drug
SBPViolinDrug <-
ggplot2::ggplot(SBPGenderDrugRaceEthnicLong.df,
aes(x=Drug, y=SBP, group=Drug)) +
geom_violin(aes(fill=Drug)) + # Violin Plot geom
ggtitle(
"Systolic Blood Pressure by Drug\n") +
scale_x_discrete(name="") +
scale_y_continuous(name="Systolic Blood Pressure\n",
limits=c(110,155), breaks=seq(110,155,20)) +
theme_bw() +
theme(legend.position="none") +
coord_flip() # Rotate (e.g., flip) the presentation


#SBP by Race-Ethnicity

SBPViolinRaceEthnic <-
ggplot2::ggplot(SBPGenderDrugRaceEthnicLong.df,
aes(x=RaceEthnic, y=SBP, group=RaceEthnic)) +
geom_violin(aes(fill=RaceEthnic)) + # Violin Plot geom
ggtitle(
"Systolic Blood Pressure by Race-Ethnicity\n") +
scale_x_discrete(name="") +
scale_y_continuous(name="Systolic Blood Pressure\n",
limits=c(110,155), breaks=seq(110,155,20)) +
theme_bw() +
theme(legend.position="none") +
coord_flip() # Rotate (e.g., flip) the presentation

gridExtra::grid.arrange(
  SBPViolinOverall,
  SBPViolinGender,
  SBPViolinDrug,
  SBPViolinRaceEthnic,
  ncol=2
)
#################################################################################################
#Visual Data Checks for Two-Factor Breakouts Using Violin Plots
###############################################################

#After examining single-factor distributions, the next step in exploratory analysis is to visually inspect pairs of factor-type variables simultaneously. 
#This step is especially important in the context of Twoway ANOVA, because it provides early insight into possible interaction effects.

#Systolic Blood Pressure by Gender and by Drug

SBPViolinGenderDrug <-
ggplot2::ggplot(SBPGenderDrugRaceEthnicLong.df,
aes(x=Gender, y=SBP, group=Gender)) +
geom_violin(aes(fill=Gender)) +
facet_grid(. ~ Drug) +
ggtitle("Systolic Blood Pressure by Gender and by Drug\n") +
scale_x_discrete(name="") +
scale_y_continuous(name="Systolic Blood Pressure\n",
limits=c(110,155), breaks=seq(110,155,20)) +
theme_bw() +
theme(axis.text.x=element_text(face="bold", size=10)) +
theme(legend.position="none") +
coord_flip()



#Systolic Blood Pressure by Gender and by Race-Ethnicity

SBPViolinGenderRaceEthnic <-
ggplot2::ggplot(SBPGenderDrugRaceEthnicLong.df,
aes(x=Gender, y=SBP, group=Gender)) +
geom_violin(aes(fill=Gender)) +
facet_grid(. ~ RaceEthnic) +
ggtitle("Systolic Blood Pressure by Gender and by Race-Ethnicity\n") +
scale_x_discrete(name="") +
scale_y_continuous(name="Systolic Blood Pressure\n",
limits=c(110,155), breaks=seq(110,155,20)) +
theme_bw() +
theme(axis.text.x=element_text(face="bold", size=10)) +
theme(legend.position="none") +
coord_flip()


#Systolic Blood Pressure by Drug and by Race-Ethnicity

SBPViolinDrugRaceEthnic <-
ggplot2::ggplot(SBPGenderDrugRaceEthnicLong.df,
aes(x=Drug, y=SBP, group=Drug)) +
geom_violin(aes(fill=Drug)) +
facet_grid(. ~ RaceEthnic) +
ggtitle("Systolic Blood Pressure by Drug and by Race-Ethnicity\n") +
scale_x_discrete(name="") +
scale_y_continuous(name="Systolic Blood Pressure\n",
limits=c(110,155), breaks=seq(110,155,20)) +
theme_bw() +
theme(axis.text.x=element_text(face="bold", size=10)) +
theme(legend.position="none") +
coord_flip()

par(ask=TRUE)
gridExtra::grid.arrange(
SBPViolinOverall,
SBPViolinGenderDrug,
SBPViolinGenderRaceEthnic,
SBPViolinDrugRaceEthnic, ncol=2)

#################################################################################################
#Dot Plot by Gender, Drug, and Race-Ethnicity (Including Totals)

ggplot2::ggplot(SBPGenderDrugRaceEthnicLong.df,
aes(x=Gender, y=SBP, group=Gender,
fill="darkred", color="black")) +
geom_point(shape=21, position="jitter") +
facet_grid(RaceEthnic ~ Drug, margins=TRUE) +
labs(title =
"Systolic Blood Pressure by Gender and by Drug and by
Race-Ethnicity and All",
x="Gender", y="Systolic Blood Pressure") +
scale_y_continuous(limits=c(110,155),
breaks=seq(110,155,20)) +
theme_bw() +
theme(axis.text.y=element_text(face="bold", size=10),
legend.position="none")

#################################################################################################
#Descriptive Statistics for Initial Analysis of the Data

install.packages("s20x", dependencies=TRUE)
library(s20x)

#Overall SBP
with(SBPGenderDrugRaceEthnicLong.df,
     s20x::summaryStats(SBP))

#Key observations:
             Mean SBP ≈ 128
			 Moderate variability (SD ≈ 8.9)
			 Slight positive skewness (0.7)
			 Balanced sample size (n = 80)


#SBP by Gender
with(SBPGenderDrugRaceEthnicLong.df,
     s20x::summaryStats(SBP ~ Gender))

| Gender | Mean SBP | SD   |
| ------ | -------- | ---- |
| Female | 126.75   | 8.17 |
| Male   | 129.83   | 9.33 |


#A difference in means is visible, but statistical significance must be confirmed inferentially.

#SBP by Drug
with(SBPGenderDrugRaceEthnicLong.df,
     s20x::summaryStats(SBP ~ Drug))


#Clear variation in mean SBP across drug groups is observed, suggesting a possible treatment effect.

#SBP by Race-Ethnicity
with(SBPGenderDrugRaceEthnicLong.df,
     s20x::summaryStats(SBP ~ RaceEthnic))


#Substantial differences in mean SBP across race-ethnicity groups are evident, warranting formal testing.


par(ask=TRUE)
par(mfrow=c(2,2)) # 4 figures - 2 row by 2 column grid

boxplot(SBPGenderDrugRaceEthnicLong.df$SBP,
main="SBP -- All Patients", xlab="", ylab="")

boxplot(SBPGenderDrugRaceEthnicLong.df$SBP ~
SBPGenderDrugRaceEthnicLong.df$Gender,
main="SBP by Gender", xlab="", ylab="")

boxplot(SBPGenderDrugRaceEthnicLong.df$SBP ~
SBPGenderDrugRaceEthnicLong.df$Drug,
main="SBP by Drug", xlab="", ylab="")

boxplot(SBPGenderDrugRaceEthnicLong.df$SBP ~
SBPGenderDrugRaceEthnicLong.df$RaceEthnic,
main="SBP by RaceEthnic", xlab="", ylab="")

#################################################################################################
#Quality Assurance, Data Distribution, and Tests for Normality

#Tests for Normality


#Two complementary approaches are used:
             Overall normality testing using stats::shapiro.test()
             Group-wise normality testing using RVAideMemoire::byf.shapiro()



#Overall Normality of SBP
shapiro.test(SBPGenderDrugRaceEthnicLong.df$SBP)

#Output
p-value = 0.000741

#Interpretation
             The calculated p-value (0.000741) is less than 0.05, indicating that SBP does not follow a normal distribution at the overall level.

#This finding raises a concern regarding normality; however, ANOVA assumptions are not evaluated solely at the overall level. 
#Instead, normality must be assessed within the levels of each factor-type variable.

#Group-Wise Normality Testing

#Even if the overall distribution is non-normal, SBP may still be approximately normal within specific subgroups (e.g., Gender, Drug, Race-Ethnicity). 
#To investigate this, group-wise Shapiro–Wilk tests are performed.

install.packages("RVAideMemoire", dependencies=TRUE)
library(RVAideMemoire)

#The function RVAideMemoire::byf.shapiro() is particularly useful, as it provides a concise table of normality statistics for each factor level.


#Normality of SBP by Gender
RVAideMemoire::byf.shapiro(SBP ~ Gender,
                           data = SBPGenderDrugRaceEthnicLong.df)

Output
Shapiro-Wilk normality tests
W        p-value
Female   0.8879  0.0008664 ***
Male     0.9564  0.1257107
---
Signif. codes: 0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

#Interpretation

| Gender | p-value   | Conclusion            |
| ------ | --------- | --------------------- |
| Female | 0.0008664 | Normality **not met** |
| Male   | 0.1257107 | Normality **met**     |

# Normality test of SBP by Drug
RVAideMemoire::byf.shapiro(SBP ~ Drug,
data=SBPGenderDrugRaceEthnicLong.df)

# Normality test of SBP by RaceEthnic
RVAideMemoire::byf.shapiro(SBP ~ RaceEthnic,
data=SBPGenderDrugRaceEthnicLong.df)

QQSBPbyOverall <-
ggplot2::ggplot(SBPGenderDrugRaceEthnicLong.df,
aes(sample=SBP)) +
stat_qq(color="red") +
stat_qq_line(color="black", linewidth=1.75) +
ggtitle("
Systolic Blood Pressure (QQ-Plot and QQ-Line) --
Overall") +
labs(
x = "\nTheoretical", y = "Systolic Blood Pressure\n") +
theme_bw()

QQSBPbyGender <-
ggplot2::ggplot(SBPGenderDrugRaceEthnicLong.df,
aes(sample=SBP)) +
stat_qq(color="red") +
stat_qq_line(color="black", linewidth=1.75) +
facet_grid(. ~ Gender) +
ggtitle("
Systolic Blood Pressure (QQ-Plot and QQ-Line)
by Gender") +
labs(
x = "\nTheoretical", y = "Systolic Blood Pressure\n") +
theme_bw()

QQSBPbyDrug <-
ggplot2::ggplot(SBPGenderDrugRaceEthnicLong.df,
aes(sample=SBP)) +
stat_qq(color="red") +
stat_qq_line(color="black", linewidth=1.75) +
facet_grid(. ~ Drug) +
ggtitle("
Systolic Blood Pressure (QQ-Plot and QQ-Line)
by Drug") +
labs(
x = "\nTheoretical", y = "Systolic Blood Pressure\n") +
theme_bw()

QQSBPbyRaceEthnic <-
ggplot2::ggplot(SBPGenderDrugRaceEthnicLong.df,
aes(sample=SBP)) +
stat_qq(color="red") +
stat_qq_line(color="black", linewidth=1.75) +
facet_grid(. ~ RaceEthnic) +
ggtitle("
Systolic Blood Pressure (QQ-Plot and QQ-Line)
by RaceEthnic") +
labs(
x = "\nTheoretical", y = "Systolic Blood Pressure\n") +
theme_bw()

par(ask=TRUE)
gridExtra::grid.arrange(
QQSBPbyOverall,
QQSBPbyGender,
QQSBPbyDrug,
QQSBPbyRaceEthnic, ncol=2)

#################################################################################################
#Statistical Test
#################

library(s20x) # Load the s20x package.

Twoway ANOVA Using aov()

#Twoway ANOVA of SBP by Gender, Drug, and RaceEthnic

summary(aov(SBP ~ Gender * Drug * RaceEthnic,
            data = SBPGenderDrugRaceEthnicLong.df))


#The * operator expands the model to include:
             All main effects
			 All two-way interactions
			 The three-way interaction

                       Df Sum Sq Mean Sq F value   Pr(>F)    
Gender                  1  189.1   189.1   5.295  0.02667 *  
Drug                    4  661.4   165.4   4.630  0.00363 ** 
RaceEthnic              3 2249.2   749.7  20.994 2.49e-08 ***
Gender:Drug             4  575.4   143.9   4.028  0.00774 ** 
Gender:RaceEthnic       3  289.9    96.6   2.706  0.05803 .  
Drug:RaceEthnic        12  510.9    42.6   1.192  0.32152    
Gender:Drug:RaceEthnic 12  283.8    23.6   0.662  0.77600    
Residuals              40 1428.5    35.7   


#Interpretation of Twoway ANOVA Results
#Main Effects
             Gender: statistically significant
			 Drug: statistically significant
			 Race-Ethnicity: statistically significant


#Interaction Effects
| Interaction                    | Result          | Interpretation                          |
| ------------------------------ | --------------- | --------------------------------------- |
| Gender × Drug                  | **Significant** | Effect of Drug on SBP differs by Gender |
| Gender × Race-Ethnicity        | Not significant | Gender effects consistent across races  |
| Drug × Race-Ethnicity          | Not significant | Drug effects consistent across races    |
| Gender × Drug × Race-Ethnicity | Not significant | No higher-order interaction             |

#Key Conclusions from the Twoway ANOVA
             SBP differs significantly by Gender
			 SBP differs significantly by Drug
			 SBP differs significantly by Race-Ethnicity
			 
			 A Gender × Drug interaction exists
			 No evidence of higher-order or other two-way interactions

#This confirms that both independent effects and selected joint effects influence SBP.

#################################################################################################
#Post Hoc Tests After Twoway ANOVA
##################################
#Why Post Hoc Tests Are Needed

#A Twoway ANOVA tells us whether statistically significant differences exist, but not where those differences occur.

#Post hoc tests are required:
             After a significant main effect with more than two levels (e.g. Drug, RaceEthnic)
			 After a significant interaction, to explore simple effects

#Step 1: Identify What Needs Post Hoc Testing (from your results)
| Effect             | Significant?  | Post hoc needed?        |
| ------------------ | --------------| ----------------------  |
| Gender             | ✅ Yes        | ❌ No (2 levels only)   |
| Drug               | ✅ Yes        | ✅ Yes                  |
| RaceEthnic         | ✅ Yes        | ✅ Yes                  |
| Gender × Drug      | ✅ Yes        | ✅ Yes (simple effects) |
| Other interactions | ❌ No         | ❌ No                   |

#Step 2: Post Hoc Tests for Main Effects
#2.1 Post Hoc for Drug (5 levels)

#Use Tukey’s HSD, the standard post hoc test after ANOVA.

model <- aov(SBP ~ Gender * Drug * RaceEthnic,
             data = SBPGenderDrugRaceEthnicLong.df)

TukeyHSD(model, "Drug")

#Why do we convert the ANOVA into a model object?
#Because TukeyHSD() does not work on raw data.
#It works on a fitted ANOVA model object that already contains:
             group means
			 pooled error variance
			 degrees of freedom
			 residuals
			 design structure
#In R, aov() does two things:
             Fits the statistical model
			 Returns an object that stores everything about that model
#So model is:
             a fitted ANOVA model
             containing all information needed for post hoc comparisons

#Output
Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = SBP ~ Gender * Drug * RaceEthnic, data = SBPGenderDrugRaceEthnicLong.df)

$Drug
                  diff        lwr       upr     p adj
Drug B-Drug A   7.5000   1.465557 13.534443 0.0084145
Drug C-Drug A   7.7500   1.715557 13.784443 0.0060604
Drug D-Drug A   4.8125  -1.221943 10.846943 0.1733706
Placebo-Drug A  3.2500  -2.784443  9.284443 0.5445402
Drug C-Drug B   0.2500  -5.784443  6.284443 0.9999537
Drug D-Drug B  -2.6875  -8.721943  3.346943 0.7094938
Placebo-Drug B -4.2500 -10.284443  1.784443 0.2792132
Drug D-Drug C  -2.9375  -8.971943  3.096943 0.6372666
Placebo-Drug C -4.5000 -10.534443  1.534443 0.2278039
Placebo-Drug D -1.5625  -7.596943  4.471943 0.9458269


#Interpretation (Tukey HSD, α = 0.05):
             Drug B vs Drug A: Mean SBP is significantly higher for Drug B than Drug A (p = 0.008).
			 Drug C vs Drug A: Mean SBP is significantly higher for Drug C than Drug A (p = 0.006).
			 All other pairwise comparisons: Not statistically significant (adjusted p > 0.05).

#Conclusion:
             The overall drug effect is driven primarily by higher SBP under Drug B and Drug C compared with Drug A. No significant differences are observed among Drug B, Drug C, Drug D, and Placebo, or between Drug D / Placebo and Drug A after adjustment.

#2.2 Post Hoc for Race-Ethnicity (4 levels)

TukeyHSD(model, "RaceEthnic")

#Output
  Tukey multiple comparisons of means
    95% family-wise confidence level

Fit: aov(formula = SBP ~ Gender * Drug * RaceEthnic, data = SBPGenderDrugRaceEthnicLong.df)

$RaceEthnic
                 diff       lwr        upr     p adj
Hispanic-Black  -5.20 -10.26539 -0.1346102 0.0422961
Other-Black    -14.00 -19.06539 -8.9346102 0.0000000
White-Black    -10.45 -15.51539 -5.3846102 0.0000126
Other-Hispanic  -8.80 -13.86539 -3.7346102 0.0001994
White-Hispanic  -5.25 -10.31539 -0.1846102 0.0397141
White-Other      3.55  -1.51539  8.6153898 0.2533620


#Interpretation:
             Black vs Hispanic: Black has significantly higher mean SBP than Hispanic (p = 0.042).
			 Black vs Other: Black has significantly higher mean SBP than Other (p < 0.001).
			 Black vs White: Black has significantly higher mean SBP than White (p < 0.001).
			 Hispanic vs Other: Hispanic has significantly higher mean SBP than Other (p < 0.001).
			 Hispanic vs White: Hispanic has significantly higher mean SBP than White (p = 0.040).
			 White vs Other: No significant difference (p = 0.253).

#Conclusion:
             Mean SBP is highest in Black, followed by Hispanic, then White, and lowest in Other.
			 All pairwise differences are significant except between White and Other.

#Step 3: Post Hoc Tests for the Gender × Drug Interaction
#Because the Gender × Drug interaction is significant, main-effect post hoc tests alone are not sufficient.

#You must examine simple effects:
             Drug differences within each Gender
			 OR Gender differences within each Drug

#Option A: Drug differences within each Gender (recommended)
# Females only
TukeyHSD(aov(SBP ~ Drug,
             data = subset(SBPGenderDrugRaceEthnicLong.df,
                           Gender == "Female")))

# Males only
TukeyHSD(aov(SBP ~ Drug,
             data = subset(SBPGenderDrugRaceEthnicLong.df,
                           Gender == "Male")))




#Option B: Gender differences within each Drug (alternative)
# Example: Gender difference for Drug A
t.test(SBP ~ Gender,
       data = subset(SBPGenderDrugRaceEthnicLong.df,
                     Drug == "Drug A"))


###Repeat for each drug if needed.

#Step 4: (Optional) Use emmeans for Clean, Professional Output 

#This is the best modern approach and highly recommended for reports.

install.packages("emmeans")
library(emmeans)

emm <- emmeans(model, ~ Gender * Drug)

pairs(emm, by = "Gender", adjust = "tukey")


| Code part          | Meaning                                 | Why it is used                                                                            |
| ------------------ | --------------------------------------- | ----------------------------------------------------------------------------------------- |
| `model`            | Fitted ANOVA model (`aov()` result)     | Contains group means, residual variance, and degrees of freedom needed for post hoc tests |
| `emmeans()`        | Computes **estimated marginal means**   | Provides adjusted group means accounting for the full ANOVA model                         |
| `~ Gender * Drug`  | Specifies factors and their interaction | Requests means for **each Gender × Drug combination**                                     |
| `emm <-`           | Stores results in an object             | Allows reuse for comparisons, plots, and summaries                                        |
| `pairs()`          | Performs pairwise comparisons           | Compares group means statistically                                                        |
| `by = "Gender"`    | Splits comparisons by Gender            | Compares **Drug levels separately within each Gender**                                    |
| `adjust = "tukey"` | Multiple-comparison correction          | Controls family-wise error rate (recommended for ANOVA)                                   |

emm <- emmeans(model, ~ Gender * Drug)
NOTE: Results may be misleading due to involvement in interactions

#In your model, Gender × Drug is significant, so:
             The effect of Drug is different for males and females
             A single “average Drug effect” across genders can be misleading
			 
#output

Gender = Female:
 contrast         estimate   SE df t.ratio p.value
 Drug A - Drug B   -13.000 2.99 40  -4.351  0.0008
 Drug A - Drug C    -9.000 2.99 40  -3.012  0.0343
 Drug A - Drug D    -9.750 2.99 40  -3.263  0.0181
 Drug A - Placebo   -2.000 2.99 40  -0.669  0.9619
 Drug B - Drug C     4.000 2.99 40   1.339  0.6692
 Drug B - Drug D     3.250 2.99 40   1.088  0.8118
 Drug B - Placebo   11.000 2.99 40   3.681  0.0058
 Drug C - Drug D    -0.750 2.99 40  -0.251  0.9991
 Drug C - Placebo    7.000 2.99 40   2.343  0.1528
 Drug D - Placebo    7.750 2.99 40   2.594  0.0908

Gender = Male:
 contrast         estimate   SE df t.ratio p.value
 Drug A - Drug B    -2.000 2.99 40  -0.669  0.9619
 Drug A - Drug C    -6.500 2.99 40  -2.175  0.2099
 Drug A - Drug D     0.125 2.99 40   0.042  1.0000
 Drug A - Placebo   -4.500 2.99 40  -1.506  0.5647
 Drug B - Drug C    -4.500 2.99 40  -1.506  0.5647
 Drug B - Drug D     2.125 2.99 40   0.711  0.9527
 Drug B - Placebo   -2.500 2.99 40  -0.837  0.9175
 Drug C - Drug D     6.625 2.99 40   2.217  0.1943
 Drug C - Placebo    2.000 2.99 40   0.669  0.9619
 Drug D - Placebo   -4.625 2.99 40  -1.548  0.5385

Results are averaged over the levels of: RaceEthnic 
P value adjustment: tukey method for comparing a family of 5 estimates 

#Interpretation of the simple‐effects post hoc results (Tukey-adjusted, α = 0.05):

#Females
             Drug A vs Drug B: Drug B has significantly higher SBP than Drug A (p = 0.0008).
			 Drug A vs Drug C: Drug C has significantly higher SBP than Drug A (p = 0.034).
			 Drug A vs Drug D: Drug D has significantly higher SBP than Drug A (p = 0.018).
			 Drug B vs Placebo: Drug B has significantly higher SBP than Placebo (p = 0.0058).
			 All other comparisons: Not significant.

#Conclusion (Females):
             Drug A is associated with lower SBP compared with Drugs B, C, and D, while Drug B increases SBP relative to Placebo.

#Males
             All drug pairwise comparisons: Not statistically significant (all p > 0.05).

#Conclusion (Males):
             There is no evidence of differential drug effects on SBP among males.

#Overall Interpretation
             Drug effects on SBP differ by gender, confirming the significant Gender × Drug interaction observed in the ANOVA.
             Drug-related SBP differences are present in females but not in males, explaining why the interaction is statistically significant.
			 
#################################################################################################
#Visualizing the Gender × Drug Interaction in SBP
#################################################
#Because the Gender × Drug interaction was statistically significant, additional plots are used to visualize how drug effects differ between males and females. 
#Interaction plots help translate statistical output into an interpretable pattern.


#1. Mean Plot Using ggplot2 (Overview Interaction Plot)
ggplot2::ggplot(
  SBPGenderDrugRaceEthnicLong.df,
  aes(x = Gender, y = SBP, color = Drug, group = Drug)
) +
  stat_summary(fun = mean, geom = "point") +
  stat_summary(fun = mean, geom = "line", size = 1.25) +
  ggtitle("Systolic Blood Pressure Means by Gender and Drug") +
  scale_x_discrete(name = "Gender") +
  scale_y_continuous(name = "Systolic Blood Pressure\n") +
  theme_MacYates()

#What this plot shows
             Points: Mean SBP for each Gender–Drug combination
             Lines: How mean SBP changes across Gender for each Drug
             Different colored lines: Different drugs

#How to interpret
             If lines are parallel, there is little or no interaction
             If lines cross or diverge, this indicates an interaction
			 
#Interpretation of the plot
             The plot shows mean systolic blood pressure (SBP) for each Gender–Drug combination.
			 The lines are not parallel and some diverge/cross, indicating a Gender × Drug interaction.

    Drug effects differ by gender:
             For Drug A and Placebo, mean SBP increases markedly from females to males.
			 For Drug B and Drug D, mean SBP decreases slightly from females to males.
			 Drug C shows an increase from females to males.

#Conclusion: 
             The effect of drug on SBP depends on gender, visually confirming the statistically significant Gender × Drug interaction found in the ANOVA.

#2. Interaction Plot (Base R): Drug on X-axis, Gender as Traces

par(ask=TRUE)

interaction.plot(
SBPGenderDrugRaceEthnicLong.df$Drug,
SBPGenderDrugRaceEthnicLong.df$Gender, # Note the order
SBPGenderDrugRaceEthnicLong.df$SBP, # of the variables.
main="Interaction: Gender, Drug, and SBP",
fun=mean, # Use mean instead of median.
legend=TRUE, 
trace.label="Gender", 
fixed=TRUE,
col=c("red", "blue"), 
lwd=4, 
lty=c("solid", "dashed"),
xlab="Drug",
ylab="Systolic Blood Pressure", 
font.lab=2,
ylim=c(120,135), 
xtick=TRUE)

3. Interaction Plot (Reversed): Gender on X-axis, Drug as Traces

par(ask=TRUE)

interaction.plot(
SBPGenderDrugRaceEthnicLong.df$Gender,
SBPGenderDrugRaceEthnicLong.df$Drug, # Note the order
SBPGenderDrugRaceEthnicLong.df$SBP, # of the variables.
main="Interaction: Drug, Gender, and SBP",
fun=mean, # Use mean instead of median.
legend=TRUE, 
trace.label="Drug", 
fixed=TRUE,
col=c("red", "blue", "black", "green", "orange"),
lwd=4, 
lty=c("solid", "dashed", "dotted", "dotdash","longdash"),
xlab="Gender",
ylab="Systolic Blood Pressure", 
font.lab=2,
ylim=c(120,135), 
xtick=TRUE)
