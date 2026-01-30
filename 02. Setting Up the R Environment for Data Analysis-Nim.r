###############################################################
# Master in Biochemistry and Biotechnology – Semester I 
# Topic : Getting set up - 2
# Course: BCBT 54813 - Biostatistics
# Author: Nimroth Ambanpola
##############################################################

#Working directory
##################

#It is good practice to keep a set of related data, analyses, and text self-contained in a single folder, called the working directory. 

#1. Start RStudio.
#2. Under the File menu, click on New Project. Choose New Directory, then New Project.
#3. Enter a name for this new folder (or “directory”), and choose a convenient location for it. This will be your working directory for the rest of the day (e.g., ~/Biostatistics-MBCBT).
#4. Click on Create Project

#Organizing your working directory
##################################
#1. data_raw/ & data/  - Use these folders to store raw data and intermediate datasets you may create for the need of a particular analysis. F
#2. documents/ - This would be a place to keep manuscript outlines, drafts, and other text.
#3. fig/ - This would be the place to keep figures that you produce from your scripts.
#4. scripts/ - This would be the place to keep your R scripts for different analyses or plotting, and potentially a separate folder for your functions (more on that later).
#5. Additional (sub)directories depending on your project needs.

#Under the Files tab on the right of the screen, click on New Folder and create a folder named "data" within your newly created working directory (e.g., ~/Biostatistics-MBCBT/). 
#(Alternatively, type dir.create("data") at your R console.) Repeat these operations to create other required folders.

#Housekeeping syntax
####################
#Using RStudio projects makes this easy and ensures that your working directory is set properly. #If you need to check it, you can use 
getwd()

#You can change your working directory
setwd("/path/to/working/directory")


#The date() function is used to provide a marker for when the R session is saved and then reviewed again, later.
date()

#R.version.string is used to verify which version of R was used for the session.
R.version.string

#The rm() function is used to remove objects.
rm()

#The ls() function is used to list all files in the current directory.
ls()

#The sessionInfo() function is used to confirm the R version and to gain information on the locale and available packages.
sessionInfo()

#The search() function is used to review the attached packages and to list all objects in the directory.
search()

####Technically R is a function language with a very simple syntax. It is case sensitive, so A and a are different.

################################################################################################
#Comments
########
The comment character in R is #, anything to the right of a # in a script will be ignored by R. It is useful to leave notes and explanations in your scripts.

#Advanced tip: RStudio makes it easy to comment or uncomment a paragraph: after selecting the lines you want to comment, press at the same time on your keyboard Ctrl + Shift + C. If you only want to comment out one line, you can put the cursor at any location of that line (i.e. no need to select the whole line), then press Ctrl + Shift + C

################################################################################################

#Meaning of the Console Prompts
###############################
| Prompt | Meaning                                                         |
| ------ | --------------------------------------------------------------- |
| `>`    | R is ready for a **new command**                                |
| `+`    | R is waiting for **more input** to complete the current command |

#Why Does This Happen?

#R shows + when:
               A command is incomplete
               Parentheses ( are not closed
               Quotes " " are not closed
               Brackets {} or [] are not closed


#How to Exit the + Prompt

#Option 1: Finish the command
#Add the missing ), ", or }

#Option 2: Cancel the command
Press: Esc


#################################################################################################

#Operators in R
###############
#Arithmetic Operators: Used for mathematical calculations.
| Operator    | Meaning             | Example   |
| ----------- | ------------------- | --------- |
| `+`         | Addition            | `3 + 2`   |
| `-`         | Subtraction         | `5 - 1`   |
| `*`         | Multiplication      | `4 * 2`   |
| `/`         | Division            | `10 / 2`  |
| `^` or `**` | Exponentiation      | `2^3`     |
| `%%`        | Modulus (remainder) | `7 %% 3`  |
| `%/%`       | Integer division    | `7 %/% 3` |

#Assignment Operators: Used to assign values to variables.
| Operator | Meaning                       | Example    |
| -------- | ----------------------------- | ---------- |
| `<-`     | Left assignment (recommended) | `x <- 5`   |
| `=`      | Assignment                    | `x = 5`    |
| `->`     | Right assignment              | `5 -> x`   |
| `<<-`    | Global assignment             | `x <<- 10` |
| `->>`    | Global right assignment       | `10 ->> x` |

#Relational (Comparison) Operators: Used to compare values.
| Operator | Meaning                  | Example  |
| -------- | ------------------------ | -------- |
| `==`     | Equal to                 | `x == 5` |
| `!=`     | Not equal to             | `x != 3` |
| `>`      | Greater than             | `x > 4`  |
| `<`      | Less than                | `x < 4`  |
| `>=`     | Greater than or equal to | `x >= 5` |
| `<=`     | Less than or equal to    | `x <= 3` |

#Logical Operators: Used for logical conditions.
| Operator | Meaning | Example          |        |         |
| -------- | ------- | ---------------- | ------ | ------- |
| `&`      | AND     | `x > 1 & x < 10` |        |         |
| `        | `       | OR               | `x < 1 | x > 10` |
| `!`      | NOT     | `!(x == 5)`      |        |         |

#Indexing Operators: Used to access elements.
| Operator | Meaning                | Example   |
| -------- | ---------------------- | --------- |
| `[]`     | Indexing               | `x[1]`    |
| `[[]]`   | Extract single element | `df[[1]]` |
| `$`      | Access named element   | `df$Age`  |

#Formula Operators (Statistics): Used in modeling.
| Operator | Meaning            | Example     |
| -------- | ------------------ | ----------- |
| `~`      | Model formula      | `y ~ x`     |
| `+`      | Add predictor      | `y ~ x + z` |
| `-`      | Remove predictor   | `y ~ x - z` |
| `:`      | Interaction        | `x:y`       |
| `*`      | Main + interaction | `x * y`     |
| `^`      | Interaction order  | `(x + y)^2` |


#What is an object in R?
########################
#An object in R is a named container that stores data, functions, or results in memory.
#R is an object-oriented language.
#This means:Data are stored in objects
            Functions operate on objects
            Results are returned as objects

#Creating an object
###################
#You create an object using an assignment operator
x <- 10

#Types of objects in R
#Atomic objects (basic objects)
| Type      | Example       |
| --------- | ------------- |
| Numeric   | `x <- 3.5`    |
| Integer   | `x <- 3L`     |
| Character | `x <- "Corn"` |
| Logical   | `x <- TRUE`   |


#Vector objects: A vector is a collection of values of the same type.
y <- c(120, 130, 140)

#Data frame objects: A data frame stores tabular data(most common in biostatistics). 
df <- data.frame(
  Year = c(1997, 1998),
  Yield = c(150, 160)
)

#Matrix objects
M <- matrix(1:6, nrow = 2)

#List objects: Lists can store different types of objects together.
L <- list(
  numbers = c(1,2,3),
  text = "Rainfall",
  data = df
)

#Function objects: Functions are also objects.
f <- function(x) x^2




#Accessing objects
| Function    | Purpose        |
| ----------- | -------------- |
| `class(x)`  | Object class   |
| `str(x)`    | Structure      |
| `typeof(x)` | Internal type  |
| `length(x)` | Size           |
| `names(x)`  | Names (if any) |

#To check existing objects
ls()

##############################################################################################
#Data Structures in R
#####################
#In R, data structures are the ways data are stored, organized, and accessed.

-------------------------------------------------------------------------------------------------------------------------------
Data Structure | Dimension        | Data Type Rule                    | Description / Properties                         | Example
-------------------------------------------------------------------------------------------------------------------------------
Vector         | 1D               | All elements same type            | Simplest R data structure.                       | x <- c(10, 12, 15, 18)
               |                  | (numeric / character / logical)  | One-dimensional.                                 |
               |                  |                                  | Basis of most other structures.                  |
               |                  |                                  | Common types: numeric, character, logical.       |
               |                  |                                  | Used for simple data storage.                    |
-------------------------------------------------------------------------------------------------------------------------------
List           | 1D               | Mixed data types allowed          | Flexible container.                              | mylist <- list(
               |                  |                                  | Can store vectors, data frames, models, etc.     |   name="Alice",
               |                  |                                  | One-dimensional but heterogeneous.               |   age=23,
               |                  |                                  | Commonly used for model outputs.                 |   scores=c(80,85)
               |                  |                                  |                                                  | )
-------------------------------------------------------------------------------------------------------------------------------
Matrix         | 2D               | All elements same type            | Two-dimensional vector.                          | m <- matrix(1:6, nrow=2)
               | (rows × columns) |                                  | Rectangular structure.                           |
               |                  |                                  | Used for linear algebra.                         |
               |                  |                                  | Mathematical computations.                      |
-------------------------------------------------------------------------------------------------------------------------------
Array          | 2D or higher     | All elements same type            | Extension of matrices.                           | a <- array(1:12,
               |                  |                                  | Can have 3 or more dimensions.                   |              dim=c(2,3,2))
               |                  |                                  | Used for simulations and multi-way data.         |
-------------------------------------------------------------------------------------------------------------------------------
Data Frame     | 2D               | Columns may differ in type        | Most common data structure in R.                 | df <- data.frame(
               | (rows × columns) |                                  | Rows = observations.                             |   age=c(18,19,20),
               |                  |                                  | Columns = variables.                             |   gender=c("F","M","F"),
               |                  |                                  | Each column is a vector.                         |   score=c(85.5,90,88)
               |                  |                                  | Widely used in statistics and biostatistics.     | )
-------------------------------------------------------------------------------------------------------------------------------
Factor         | 1D               | Categorical values                | Special vector for categorical data.             | gender <- factor(
               |                  | Stored as integer codes + labels | Has levels (categories).                         |   c("Male","Female","Female")
               |                  |                                  | Can be ordered or unordered.                     | )
               |                  |                                  | Essential for grouping and modeling.             |
-------------------------------------------------------------------------------------------------------------------------------

#How Data Structures Relate to Each Other
#########################################
#Vector  → Matrix / Array
#Vector  → Factor
#List    → Data Frame (special list)
#A data frame is a list of equal-length vectors.

#How to Check Data Structure in R
#################################
class(x)
str(x)
is.vector(x)
is.data.frame(x)

###########################################################################################

#R Libraries (Packages)
#######################
#In R, a library is a collection of:Functions, Datasets, Documentation
#Libraries extend the basic functionality of R and allow users to perform specialized tasks such as statistical analysis, data visualization, data import, and modeling.

### Important: Base R already contains many libraries, but additional libraries can be installed when needed.
| Library    | Purpose                           |
| ---------- | --------------------------------- |
| `base`     | Core R functionality              |
| `stats`    | Statistical tests and models      |
| `graphics` | Basic plotting functions          |
| `utils`    | Data import/export, file handling |
| `datasets` | Example datasets                  |

#Contributed R Libraries
########################
#Contributed libraries are not installed by default and must be downloaded from CRAN or other repositories.
#Installing a Library (once)
install.packages("readxl")

#Loading a Library (every session)
library(readxl)



##############################################################################################

#Import Data Into R
###################

#1. Comma-separated values (.csv) files are typically used to import data into R
#############################################################################

setwd("C:/Users/Nimroth Ambanpola/Downloads/BCBT-2025_Sem I_Batch5/Biostatistics - MBCBT/data")

GenEnd.df <- utils::read.table (file =
"GenderEndurance.csv",
header=TRUE, dec=".", sep=",")

#"utils" is a base R package that is automatically loaded when R starts.
#Use the utils::read.table() function to import the .csv file GenderEndurance.csv into the current R session and place the contents into the object


str(GenEnd.df) # Identify structure
head(GenEnd.df, n=3) # Show the head, 1st 3 cases
summary(GenEnd.df) # Summary statistics


#Quality assurance (QA)
#######################

#Although the data appear to be in the correct order, it is good statistical practice to perform QA before proceeding with further analysis. 
#One effective QA method is to visualize the distribution of the data.
#We can use density plots for this.
#A density plot is a smooth estimate of the probability distribution of a continuous variable.

#eg: Check whether the endurance values look reasonable
plot(density(GenEnd.df$Endurance, na.rm=TRUE),
main="Endurance of Selected Female and Male Subjects:
Quality Assurance Density Plot", col="red", lwd=5)

#plot(density(...)): Plots the density curve
#density(GenEnd.df$Endurance, na.rm = TRUE): Refers to the Endurance variable inside the data frame GenEnd.df
#main: Provides a clear, descriptive title
#col = "red": Uses a red line for visibility
#lwd = 5: Creates a thick line to emphasize the curve

#How to Interpret a Density Plot
################################ 
#(1) Shape of the Distribution
#Ask:1. Is it symmetric? 2. Is it skewed (left or right)? 3. Does it have one peak (unimodal) or multiple peaks (multimodal)?

#Symmetric bell-shape → approximately normal distribution
#Right-skewed → many small values, few large values
#Two peaks → possibly two subgroups (e.g., males vs females)
###In biostatistics, multimodality often indicates hidden grouping variables.


#(2) Center of the Distribution
#Look at:Where the highest peak is located on the x-axis
#This indicates:Typical or central endurance value
                Approximate mean/median location
#If the center is far from what is biologically reasonable → ⚠️ possible data issue.


#(3) Spread (Variability)
#Observe:How wide the curve is
#Narrow curve → low variability
#Wide curve → high variability
#Unexpectedly large spread may indicate:Measurement inconsistency, Data entry errors, Mixed populations


#(4) Tails of the Distribution
#Check:How far the curve extends left and right
#Long or irregular tails can signal:Outliers, Recording mistakes, Rare but real extreme cases (must be verified)


#(5) Smoothness of the Curve
#A good density plot should:Be smooth, and have no sharp spikes or gaps
#Sharp irregularities may indicate:Small sample size, Discrete values entered as continuous, Data coding problems




#QA interpretation of endurance:
#The density curve is smooth and unimodal, indicating the data are properly recorded and continuous.
#The main peak around Endurance ≈ 3.0 suggests a clear and plausible central tendency.
#The spread is moderate, with a slight right skew, but no sharp spikes or extreme tails.
#No obvious outliers or impossible values are visible.
#QA conclusion:The data pass initial quality assurance checks and are suitable for further statistical analysis.

############################################################################################

#2. Import a .txt File of Tab-Separated Values into R
##################################################

BreedMilk.df <- utils::read.table (file =
"BreedMilkLb365.txt",
header=TRUE, dec=".", sep="\t")
# Use the utils::read.table() function to import the .txt file BreedMilkLb365.txt into the current R session and place the contents into the object BreedMilk.df, which is a dataframe that: (1) has a header row, (2) uses a period for decimals, and (3) uses a tab to separate one field from another.


str(BreedMilk.df) # Identify structure
head(BreedMilk.df, n=3) # Show the head, 1st 3 cases
summary(BreedMilk.df) # Summary statistics

plot(density(BreedMilk.df$MilkLb365, na.rm=TRUE),
main="Annual Milk Production (Pounds) of Holstein and
Jersey Cows: Quality Assurance Density Plot",
col="red", lwd=5)


#QA interpretation of MilkLb365:
#The density plot is smooth and clearly bimodal, indicating two distinct peaks in milk production.
#This bimodality is expected and plausible, likely reflecting differences between Holstein and Jersey cows rather than data errors.
#The spread and range of values are reasonable, with no sharp spikes or impossible values.
#No obvious outliers or data entry issues are evident.
#QA conclusion: The data pass quality assurance checks; the bimodal shape reflects real group differences and suggests that breed-wise analysis should be performed in subsequent steps.

###########################################################################################

#3. Import a .txt File of Fixed-Width Format (FWF)Values into R
############################################################

SoilYield.df <- utils::read.fwf(
"YearSoilTypeCropRainYieldBushelsPerAcreNoHeader.txt",
header=FALSE, # There is no header for column names.
skip=0, # Skip no lines; read data from the 1st line.
na.strings=" ",# Blank spaces in a character object are NA.
width=c(-1,4, # Year (1997 to 2016)
-1,4, # Predominant Soil Type (Sand, Silt, Clay)
-1,4, # Crop
-1,6, # Rain (Dry, Normal, Wet)
-1,9)) # Yield (Bushels Per Acre, BUperAcre)

#-1 means --- ignore (skip) exactly one character
#Position  :  1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
#Characters:  _ 1 9 9 7 _ S a n d   _ C o r n
#Here:_ = a space character

#Two possible real cases
#Case 1: File starts immediately with data (most common)

1997 Sand Corn Dry   120.5

#The first character is 1, not a space
#So no skipping is needed before the first column
width = c(4, -1, 4, -1, 4, -1, 6, -1, 9)

#Case 2: File starts with a leading space

 1997 Sand Corn Dry   120.5

#Here:The first character is a space
#You must skip it
width = c(-1, 4, -1, 4, -1, 4, -1, 6, -1, 9)



names(SoilYield.df) <- c(
"Year", # Year
"Soil", # Soil
"Crop", # Crop
"Rain", # Rain
"BUperAcre") # Bushels per Acre
# Column names were not included in the original .txt dataset. Use the names() function to supply column names to the object SoilYield.df.


str(SoilYield.df) # Identify structure
head(SoilYield.df, n=3) # Show the head, 1st 3 cases
summary(SoilYield.df) # Summary statistics

plot(density(SoilYield.df$BUperAcre, na.rm=TRUE),
main="Corn Yield (Bushels per Acre) for Different Soils
from 1997 to 2016 at a Selected Midwestern
Region: Quality Assurance Density Plot", col="red", lwd=5)

#QA interpretation of corn yield:
#The density curve is smooth and unimodal, indicating well-recorded continuous data with no obvious coding issues.
#The main peak around 160–165 bushels/acre represents a clear and plausible central yield level.
#The spread is moderate, with a slight right tail, but no sharp spikes or abrupt cut-offs.
#No extreme or implausible values are evident.
#QA conclusion: The yield data pass initial quality assurance checks and are suitable for further statistical analysis (e.g., comparison across soil types or years).

################################################################################################

#4. Import a .xlsx Spreadsheet File into R
#######################################

install.packages("readxl", dependencies=TRUE)
library(readxl) # Load the readxl package.
help(package=readxl) # Show the information page.
sessionInfo() # Confirm all attached packages

Sorghum.df <- readxl::read_excel("Sorghum2012to2016.xlsx", 1)
# Use the readxl::read_excel() function to import the .xlsx spreadsheet Sorghum2012to2016.xlsx into the current R session and place the contents into the object Sorghum.df.
# The number 1 that shows after the .xlsx filename is used to declare that only the 1st sheet in the spreadsheet should be read into the intended object, Sorghum.df in this example.

str(Sorghum.df) # Identify structure
head(Sorghum.df, n=3) # Show the head, 1st 3 cases
summary(Sorghum.df) # Summary statistics


plot(density(Sorghum.df$BUperAcre, na.rm=TRUE),
main="Sorghum Yield (Bushels per Acre) for Different Management
Practices from 2012 to 2016 at a Selected Midwestern
Region: Quality Assurance Density Plot", col="red", lwd=5)


#QA interpretation of sorghum yield:
#The density curve is smooth and well-defined, indicating high-quality continuous data with no obvious coding or recording errors.
#The distribution is right-skewed with a dominant peak around 85–95 bushels/acre, representing typical sorghum yields.
#Minor secondary bumps at lower yields likely reflect different management practices, not data problems.
#No sharp spikes, gaps, or implausible values are visible.
#QA conclusion:The data pass quality assurance checks and are appropriate for further analysis, such as comparisons across management practices or years.

######################################################################################

#5. Import a .csv File of Comma-Separated Values from an Online Source into R
##########################################################################

install.packages("data.table", dependencies=TRUE)
library(data.table) # Load the data.table package.
help(package=data.table) # Show the information page.
sessionInfo() # Confirm all attached packages.

#https://chronicdata.cdc.gov/api/views/vba9-s8jp/rows.csv contain 31 colums and 60060 rows

ChildHealth.df <- data.table::fread ('https://chronicdata.cdc.gov/api/views/vba9-s8jp/rows.csv')

str(ChildHealth.df) # Identify structure
head(ChildHealth.df, n=3) # Show the head
summary(ChildHealth.df) # Summary statistics

#For this example all analyses and graphics will be specific to:
#Topic: Fruits and Vegetables—Behavior
#Question: Percent of students in grades 9–12 who consume fruit less than one time daily

#Because the dataset ChildHealth.df is so large, it may be helpful to construct a new dataset that relates only to this example.

ChildHealthFruitVegetable.df <- ChildHealth.df[ which(ChildHealth.df$Topic=="Fruits and Vegetables - Behavior"), ]

str(ChildHealthFruitVegetable.df) # Identify structure
head(ChildHealthFruitVegetable.df, n=3) # Show the head
summary(ChildHealthFruitVegetable.df) # Summary statistics

#Quality Assurance and Descriptive Analysis of "Data_Value"Column
#Step 1: Confirm and Enforce Numeric Data Type
ChildHealthFruitVegetable.df$Data_Value <-
as.numeric(ChildHealthFruitVegetable.df$Data_Value)
#Converts Data_Value into a numeric variable
#Prevents errors if the variable was previously stored as character or factor
#Ensures compatibility with statistical functions (mean, SD, plots)

#Step 2: Check the Number of Observations
length(ChildHealthFruitVegetable.df$Data_Value)

#Step 3: Identify Missing Values
table(is.na(ChildHealthFruitVegetable.df$Data_Value))

#Step 4: Compute Descriptive Statistics (Ignoring Missing Values)
mean(ChildHealthFruitVegetable.df$Data_Value, na.rm=TRUE)
sd(ChildHealthFruitVegetable.df$Data_Value, na.rm=TRUE)
median(ChildHealthFruitVegetable.df$Data_Value, na.rm=TRUE)
summary(ChildHealthFruitVegetable.df$Data_Value)

#Step 5: Visual QA via Density Plot
plot(density(ChildHealthFruitVegetable.df$Data_Value,
na.rm=TRUE),
main="Percent of Students in Grades 9-12 Who Consume Fruit
Less Than 1 Time Daily: Quality Assurance
Density Plot", col="red", lwd=5)