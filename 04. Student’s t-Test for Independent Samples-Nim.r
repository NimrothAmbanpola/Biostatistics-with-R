###############################################################
# Master in Biochemistry and Biotechnology – Semester I 
# Topic : Student’s t-Test for Independent Samples -4
# Course: BCBT 54813 - Biostatistics
# Author: Nimroth Ambanpola
##############################################################

#What is the Student’s t-Test?
##############################

#The Student’s t-Test for Independent Samples is a statistical test used to check whether two independent groups are significantly different from each other with respect to one continuous variable.

#It tells us whether the difference between two group averages (means) is real or just due to chance.

#When Do We Use the Student’s t-Test?
#####################################

1. We compare ONE measured variable(e.g., blood pressure, weight, milk fat percentage)
2. Between TWO independent groups(e.g., male vs female, breed A vs breed B)
3. The data are continuous (numeric)
4. Sample size is small (usually ≤ 30)(but the test is also often used for larger samples)

#Each question compares two groups using one continuous variable.

# Why Is It Called “Student’s” t-Test?
######################################

# The test was developed over 100 years ago
# It was created during quality control work for a beverage company
# It was published under the pen name “Student”
# The real name of the scientist was William Sealy Gosset

#Independent Samples vs Matched Pairs
#####################################
#Independent Samples:
             Two groups are separate
             One subject belongs to only one group

#Example:
             Holstein cows vs Jersey cows
             Male vs Female humans

👉 First we focus on independent samples
# Matched Pairs (later):
             Same subjects measured twice
             Example: before vs after treatment


# Common Keywords You Must Know (Exam-Important)
###############################################

| **Term**                           | **Very Simple Definition**                                                                                           |
| ---------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| **Student’s *t*-Test**             | A statistical test used to check if the average values of **two groups** are different.                              |
| **Independent samples**            | Two groups where the individuals in one group **do not belong** to the other group.                                  |
| **t-statistic**                    | A number calculated in a *t*-test that shows **how different the two group means are** compared to random variation. |
| **z-statistic**                    | A number that shows how far a value is from the average when the sample size is **large**.                           |
| **Histogram**                      | A graph that shows **how data are spread** by grouping values into bars.                                             |
| **Barplot**                        | A graph that compares **categories or groups** using bars.                                                           |
| **Boxplot (box-and-whisker plot)** | A graph that shows the **median, spread, and extreme values** of data.                                               |
| **Density plot**                   | A smooth curve that shows the **shape of the data distribution**.                                                    |
| **Dotchart**                       | A plot where each data value is shown as a **single dot**.                                                           |
| **Statistical significance**       | A result that is **unlikely to happen by chance**.                                                                   |
| **p-value**                        | A number that shows **how likely the result is due to chance**.                                                      |


#Important Considerations When Using Student’s t-Test
#####################################################

# When using Student’s t-Test for Independent Samples to determine whether there is a statistically significant difference between two groups (usually when p ≤ 0.05), the following points should be remembered.

#Sample Size Considerations:
             Student’s t-Test is commonly used for small samples(typically 30 or fewer observations).
             However, it is also appropriate for larger samples.
             When the sample size (N) becomes larger than about 30:
                 t-statistic begins to approximate the z-statistic
                 This is because of the Central Limit Theorem
👉 In practice, this means the t-Test remains reliable even with larger datasets.

#The Central Limit Theorem (CLT):
             When the sample size is large enough (usually N ≥ 30), the average of the data behaves like a normal distribution, even if the original data are not perfectly normal.
			 
👉 In practice, this means the t-Test remains reliable even with larger datasets.


# Comparison of t-Statistic and z-Statistic
###########################################
| **Feature**                          | **t-Statistic**                           | **z-Statistic**                           |
| ------------------------------------ | ----------------------------------------- | ----------------------------------------- |
| **Used when**                        | Sample size is **small** (usually N ≤ 30) | Sample size is **large** (usually N ≥ 30) |
| **Population standard deviation**    | **Unknown**                               | **Known or well-estimated**               |
| **Related test**                     | Student’s *t*-Test                        | *z*-Test                                  |
| **Distribution used**                | *t*-distribution                          | Normal (z) distribution                   |
| **Shape of distribution**            | Slightly **wider** with heavier tails     | **Standard normal** curve                 |
| **Effect of increasing sample size** | Becomes closer to the *z*-statistic       | Already normal                            |
| **Why used in this lesson**          | Suitable for **small biological samples** | Approximated when sample size is large    |
| **Connection to CLT**                | Approaches *z* as N increases             | Based on CLT for large samples            |


# Assumptions of the Student’s t-Test
#####################################
# To decide whether the observed difference between two groups is real or due to chance, several assumptions should be considered:
             Normality - The data in each group should roughly follow a normal distribution.
             Random Selection - Ideally, subjects in both groups should be selected randomly.

# Robustness of the t-Test
##########################
# Even if these assumptions are not perfectly met, Student’s t-Test is considered robust, meaning:
             Small violations of normality are often acceptable
             Perfect random sampling is not always required



# Replication and Representation
###############################
# When interpreting results from a Student’s t-Test:
             Replication (repeating measurements or studies)
             Representation (how well samples reflect the population)


# Meaning of p ≤ 0.05
#####################
             The value p ≤ 0.05 defines the probability threshold for decision-making
             If the calculated p-value is ≤ 0.05: The Null Hypothesis is rejected
             If the p-value is > 0.05: The Null Hypothesis is not rejected

##A p-value of 0.05 means there is at most a 5% chance that the observed difference occurred by random chance alone.

# Other Common Significance Levels
##################################
# Although p ≤ 0.05 is very common
# Some studies use p ≤ 0.01
# Others use p ≤ 0.001 (very strict)


#################################################################################################

# Description of the Dataset (Dairy Cow Example)
###############################################
# Breeds Used:
             Holstein cows - Heavier (≈ 1300 lbs or more)
                             Produce more milk per lactation
             Jersey cows -   Lighter (≈ 1000 lbs)
                             Produce milk with higher quality

# Instead of milk quantity, this dataset focuses on milk quality:
             Percentage of butterfat
             Percentage of protein

# Sample Size:
             20 Holstein cows
             22 Jersey cows

#Data values are given up to six decimal places.

# Missing Data:
             One value is missing
             PctProtein for subject SH10
# This is normal in real datasets and must be handled carefully.


# Null Hypothesis (H₀)
#####################

# In this lesson, two Null Hypotheses (H₀) are tested.
# For both hypotheses, the level of significance is set at p ≤ 0.05.

# Null Hypothesis 1 (Butterfat)
             There is no statistically significant difference (p ≤ 0.05) in Percent Butterfat of milk between Holstein and Jersey cows.

# Null Hypothesis 2 (Protein)
             There is no statistically significant difference (p ≤ 0.05) in Percent Protein of milk between Holstein and Jersey cows.


#Creating the Data Frame in R
#############################
MilkBreedFatProt.df <- read.table(
  file = "data/L2/MilkBreedButterfatProtein.csv", #Name of the CSV file
  header = TRUE,                          #The first row contains variable names
  dec = ".",                              #Decimal numbers use a dot
  sep = ","                               #Values are separated by commas
)



#Before any statistical analysis, it is important to confirm that:
             The data were imported correctly
             The object types are as expected
             There are no duplicate observations

class(MilkBreedFatProt.df) #Checking the Class of the Data Object - "data.frame"
str(MilkBreedFatProt.df)   #Checking the Structure of the Data
duplicated(MilkBreedFatProt.df$Subject) #Checking for Duplicate Subjects


nrow(MilkBreedFatProt.df)     # List the number of rows
ncol(MilkBreedFatProt.df)     # List the number of columns
dim(MilkBreedFatProt.df)      # Dimensions of the data frame
names(MilkBreedFatProt.df)    # Identify names
colnames(MilkBreedFatProt.df) # Show column names
rownames(MilkBreedFatProt.df) # Show row names
head(MilkBreedFatProt.df)     # Show the head
tail(MilkBreedFatProt.df)     # Show the tail
summary(MilkBreedFatProt.df)  # Summary statistics
View(MilkBreedFatProt.df)     # Open the entire dataframe
MilkBreedFatProt.df           # Show the entire dataframe


#################################################################################################
#Recoding and Transforming Variables in R
#########################################
#Recoding and transforming variables are important steps in data preparation.
#They help make data clearer, more meaningful, and suitable for statistical analysis.
#These steps are especially important before running statistical tests such as the Student’s t-Test. 

#What Is Recoding?
##################

#Recoding means changing how data values are grouped or labeled, without changing the actual information.

#Examples:
1. Changing numeric codes into text labels
(e.g., 1 = Holstein, 2 = Jersey)

2. Grouping continuous values into categories
(e.g., age → young, adult, old)

3. Renaming or simplifying variable values

#Why Recoding Is Needed
#######################

#Recoding is done to:
             Make data easier to understand
             Improve readability of output
             Prepare grouping variables for statistical tests
             Avoid confusion caused by cryptic numeric codes
             Ensure variables are treated as factors when required

#What Is Transformation?
########################

#Transformation means applying a mathematical change to numeric data.

#Examples:
1. Log transformation
2. Standardization (z-scores)
3. Scaling or centering values

#Why Transformation Is Needed
#############################

#Transformation is used to:
             Meet statistical assumptions (e.g., normality)
             Reduce skewness in data
             Make variables comparable
             Improve interpretation of results
             Prepare data for specific statistical methods

#Recoding vs Transformation (Simple Difference)
             Recoding → changes labels or categories
             Transformation → changes numerical values mathematically



#Recoding and Confirming Variable Formats
#########################################
#Ensuring Subject Is a Factor
MilkBreedFatProt.df$Subject <- as.factor(
  MilkBreedFatProt.df$Subject
)


#This step confirms that the variable Subject is treated as a factor.
             Subject is an identifier for individual animals
             It does not represent a numerical measurement
             Treating it as a factor prevents R from applying mathematical operations to it

#Recoding the Breed Variable
MilkBreedFatProt.df$Breed.recode <- factor(
  MilkBreedFatProt.df$Breed,
  labels = c("Holstein", "Jersey")
)

head(MilkBreedFatProt.df)     # Show the head
tail(MilkBreedFatProt.df)     # Show the tail

#Here, a new variable called Breed.recode is created.
#The original numeric codes are:
             1 → Holstein
             2 → Jersey

#These numeric codes are converted into descriptive text labels

#The function factor() is used instead of as.factor() in order to:
             Apply meaningful category labels
             Convert numeric values into an enumerated factor

👉 The original variable Breed is retained, while Breed.recode provides a clearer and more interpretable version for analysis.

#Ensuring Numeric Variables Are Numeric
MilkBreedFatProt.df$PctButterfat <- as.numeric(
  MilkBreedFatProt.df$PctButterfat
)

MilkBreedFatProt.df$PctProtein <- as.numeric(
  MilkBreedFatProt.df$PctProtein
)
#These steps confirm that PctButterfat and PctProtein are stored as numeric variables.

#This is required so that these variables can be used for:
             Summary statistics (e.g., mean, median)
             Graphical analysis (e.g., histograms, boxplots)
             Student’s t-Test for Independent Samples
			 
#################################################################################################
#Conducting a Visual Data Check Using Graphics
##############################################
#Choosing Graphics Based on Variable Type 
             Factor-Type Variables (Categorical Data)
			 Numeric-Type Variables (Continuous Data)

#Factor-Type Variables (Categorical Data)
#The most appropriate first graphic is a barplot(such as Breed.recode).
             A barplot shows the number of observations in each group
             Rectangular bars make it easy to compare group sizes
             Example: Holstein vs Jersey cows
			
⚠️ Pie charts should be avoided.
Pie charts are generally considered poor tools for showing group differences and are not well accepted in professional statistical work, even though they are commonly used in popular media.

barplot(table(MilkBreedFatProt.df$Breed.recode),
        main = "Breed: Barplot Frequency Distribution",
        col = c("black", "burlywood4"),
        ylim = c(0, 25))
		

#Numeric-Type Variables (Continuous Data)

#For numeric variables (such as PctButterfat and PctProtein), several graphical tools are commonly used:
             hist() – histogram
             plot() – basic scatter or index plots
             plot(density()) – density plot
             boxplot() – distribution and spread
             stripchart() or dotchart() – individual data points
             qqnorm() and qqline() – normality assessment			 
			 
#Graphics for PctButterfat
par(ask = TRUE)
par(mfrow = c(2, 4))  # 8 figures arranged in 2 rows and 4 columns

hist(MilkBreedFatProt.df$PctButterfat,
     main = "Percent Butterfat: Histogram")

plot(MilkBreedFatProt.df$PctButterfat,
     main = "Percent Butterfat: Plot")

plot(density(MilkBreedFatProt.df$PctButterfat,
             na.rm = TRUE),  # Required for missing data
     main = "Percent Butterfat: Density Plot")

boxplot(MilkBreedFatProt.df$PctButterfat,
        main = "Percent Butterfat: Box Plot")

stripchart(MilkBreedFatProt.df$PctButterfat,
            main = "Percent Butterfat: Stripchart")

dotchart(MilkBreedFatProt.df$PctButterfat,
         main = "Percent Butterfat: Dotchart")

qqnorm(MilkBreedFatProt.df$PctButterfat,
       main = "Percent Butterfat: Q-Q Plot")

qqnorm(MilkBreedFatProt.df$PctButterfat,
       main = "Percent Butterfat: Q-Q Plot\nand Q-Q Line")
qqline(MilkBreedFatProt.df$PctButterfat)



#Graphics for PctProtein			 
par(ask = TRUE)
par(mfrow = c(2, 4))  # 8 figures arranged in 2 rows and 4 columns



hist(MilkBreedFatProt.df$PctProtein,
     main = "Percent Protein: Histogram")

plot(MilkBreedFatProt.df$PctProtein,
     main = "Percent Protein: Plot")

plot(density(MilkBreedFatProt.df$PctProtein,
             na.rm = TRUE),  # Required for missing data
     main = "Percent Protein: Density Plot")

boxplot(MilkBreedFatProt.df$PctProtein,
        main = "Percent Protein: Box Plot")

stripchart(MilkBreedFatProt.df$PctProtein,
            main = "Percent Protein: Stripchart")

dotchart(MilkBreedFatProt.df$PctProtein,
         main = "Percent Protein: Dotchart")

qqnorm(MilkBreedFatProt.df$PctProtein,
       main = "Percent Protein: Q-Q Plot")

qqnorm(MilkBreedFatProt.df$PctProtein,
       main = "Percent Protein: Q-Q Plot\nand Q-Q Line")
qqline(MilkBreedFatProt.df$PctProtein)

#################################################################################################
#Specialized External Package : epiDisplay package for Factor-Type Variables
############################################################################

install.packages("epiDisplay", dependencies = TRUE)
library(epiDisplay)            # Load the epiDisplay package
help(package = epiDisplay)     # Display package documentation
sessionInfo()                  # Confirm attached packages

#Frequency and Percentage Summary Using tableStack()
epiDisplay::tableStack(
  Breed.recode,
  dataFrame = MilkBreedFatProt.df,
  by = "none",
  count = TRUE,
  decimal = 2,
  percent = c("column", "row"),
  frequency = TRUE,
  name.test = TRUE,
  total.column = TRUE,
  test = TRUE
)

#Purpose of tableStack()
#This function produces descriptive statistics only, including:
             Total sample size
             Group frequencies
             Percentage representation
			 
			 
#Creating a Publication-Quality Barplot Using tab1()
par(mfrow = c(1, 1)) #This resets the plotting area to one figure only.
par(ask = FALSE)

epiDisplay::tab1(
  MilkBreedFatProt.df$Breed.recode,
  decimal = 2,
  sort.group = FALSE,
  cum.percent = TRUE,
  graph = TRUE,
  missing = TRUE,
  bar.values = "frequency",
  horiz = TRUE,
  cex = 1,
  cex.names = 1,
  cex.lab = 1,
  cex.axis = 1,
  main = "Dairy Cow Breeds (Holstein v Jersey) N Values",
  col = c("black", "burlywood4")
)

#The tab1() function:
             Produces a horizontal barplot
             Displays frequencies directly on the bars
             Prints descriptive statistics to the screen at the same time

#################################################################################################
#Visualizing Relationships Between Numeric Variables Using ggplot2
##################################################################

install.packages("ggplot2", dependencies = TRUE)
library(ggplot2)       # Load the ggplot2 package
help(package = ggplot2) # Show the information page
sessionInfo()          # Confirm all attached packages

install.packages("ggthemes", dependencies=TRUE)
library(ggthemes) # Load the ggthemes package.
help(package=ggthemes) # Show the information page.
sessionInfo() # Confirm all attached packages.

#Using Custom Themes in ggplot2
###############################

#To improve the appearance and readability of figures, ggplot2 allows the use of themes.
#Themes control:
             Font size and style
             Axis labels and tick marks
             Titles and legends
             Background appearance

#Rather than repeatedly typing many formatting commands, it is efficient to create a user-defined theme that can be reused.

#The Custom Theme: theme_MacYates()
#Key Theme Settings:
             Font settings → Bold and larger text for clarity
             Axis titles and labels → Improved readability
             Tick marks → Thicker and more visible
             Panel background → Light background to improve contrast
             Reduce repeated code when creating multiple figures

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

#Explanation of Terms Used in the Custom Theme:
			theme_MacYates – A user-created function that defines how ggplot figures should look.
			base_size – Sets the default text size for the plot.
			base_family – Sets the font type used in the plot (e.g., sans-serif).
			plot.title – Controls the appearance of the main title of the plot.
			face = "bold" – Makes the text bold.
			size – Controls the size of the text.
			hjust – Controls horizontal alignment of text (0 = left, 0.5 = center, 1 = right).
			axis.title.x – Controls the x-axis title appearance.
			axis.text.x – Controls the tick label text on the x-axis.
			axis.title.y – Controls the y-axis title appearance.
			vjust – Controls vertical alignment of text (0 = bottom, 0.5 = center, 1 = top).
			angle – Rotates the text by a specified number of degrees.
			axis.text.y – Controls the tick label text on the y-axis.
			legend.title – Controls the appearance of the legend title.
			legend.text – Controls the appearance of legend labels.
			axis.ticks.x – Controls the thickness of tick marks on the x-axis.
			axis.ticks.y – Controls the thickness of tick marks on the y-axis.
			axis.ticks.length – Sets the length of axis tick marks.
			unit("cm") – Specifies the measurement unit (centimeters).
			panel.background – Controls the background color of the plotting area.
			fill = "whitesmoke" – Sets a light background color to improve contrast.

#Simple Meaning of Alignment Parameters
             hjust – Moves text left or right.
             vjust – Moves text up or down.
             angle – Rotates text to improve readability.

#This theme can be added to any ggplot using:
+ theme_MacYates()

#Confirming the Theme Object
class(theme_MacYates)

#By default:
             A custom theme (like theme_MacYates) exists only in the current R session
             When you close R or RStudio, it is lost
			 
#Creating ggplot2 Figures for Numeric Variables - 1. Percent Butterfat
######################################################################
#Histogram of Percent Butterfat (Overall)
             A histogram shows the distribution of percent butterfat values
             The mean is marked by a red dashed line
             The median is marked by a blue dotted line
             Axis limits and tick marks are manually adjusted for clarity
             The custom theme ensures the figure is bold and readable

# Create and store the histogram as an object
HistogramPctButterfatOverall <-

  # Start a ggplot using the dataframe MilkBreedFatProt.df
  ggplot2::ggplot(
    MilkBreedFatProt.df,
    
    # Specify that PctButterfat is the variable on the x-axis
    aes(x = PctButterfat)
  ) +
  
  # Draw a histogram of Percent Butterfat
  geom_histogram(
    binwidth = 0.30,      # Width of each histogram bar
    color = "black",      # Color of the bar borders
    linewidth = 1.25,     # Thickness of the bar borders
    fill = "cornsilk2"    # Fill color inside the bars
  ) +
  
  # Add a vertical line showing the MEAN of PctButterfat
  geom_vline(
    aes(xintercept = mean(PctButterfat, na.rm = TRUE)), # Mean value
    color = "darkred",    # Red color for the mean line
    linetype = "dashed",  # Dashed line style
    linewidth = 1.25      # Thickness of the line
  ) +
  
  # Add a vertical line showing the MEDIAN of PctButterfat
  geom_vline(
    aes(xintercept = median(PctButterfat, na.rm = TRUE)), # Median value
    color = "dodgerblue", # Blue color for the median line
    linetype = "dotted",  # Dotted line style
    linewidth = 1.25      # Thickness of the line
  ) +
  
  # Add a title to the plot
  ggtitle(
    "Percent Butterfat Produced by Holstein and Jersey
Dairy Cows, Mean - Red and Median - Blue"
  ) +
  
  # Customize the x-axis (Percent Butterfat)
  scale_x_continuous(
    name = "Percent Butterfat", # Label for x-axis
    limits = c(0, 6),           # Minimum and maximum x-axis values
    breaks = seq(0, 6, 1.0)     # Tick marks every 1 unit
  ) +
  
  # Customize the y-axis (Count of observations)
  scale_y_continuous(
    name = "Count",             # Label for y-axis
    limits = c(0, 10),           # Minimum and maximum y-axis values
    breaks = seq(0, 10, 1)       # Tick marks every 1 unit
  ) +
  
  # Apply the custom theme for consistent styling
  theme_MacYates()


#Clean code:
HistogramPctButterfatOverall <-
  ggplot2::ggplot(
    MilkBreedFatProt.df,
    aes(x = PctButterfat)
  ) +
  geom_histogram(
    binwidth = 0.30,
    color = "black",
    linewidth = 1.25,
    fill = "cornsilk2"
  ) +
  geom_vline(
    aes(xintercept = mean(PctButterfat, na.rm = TRUE)),
    color = "darkred",
    linetype = "dashed",
    linewidth = 1.25
  ) +
  geom_vline(
    aes(xintercept = median(PctButterfat, na.rm = TRUE)),
    color = "dodgerblue",
    linetype = "dotted",
    linewidth = 1.25
  ) +
  ggtitle(
    "Percent Butterfat Produced by Holstein and Jersey
Dairy Cows, Mean - Red and Median - Blue"
  ) +
  scale_x_continuous(
    name = "Percent Butterfat",
    limits = c(0, 6),
    breaks = seq(0, 6, 1.0)
  ) +
  scale_y_continuous(
    name = "Count",
    limits = c(0, 10),
    breaks = seq(0, 10, 1)
  ) +
  theme_MacYates()







#Histogram of Percent Butterfat by Breed
             facet_grid() creates separate panels for each breed
             This allows direct visual comparison between Holstein and Jersey cows
             Additional theme elements are applied to:
                 Make facet labels bold
                 Improve contrast of the facet background


# Create and store the faceted histogram as an object
HistogramPctButterfatBreed.recode <-

  # Start a ggplot using the dataframe MilkBreedFatProt.df
  ggplot2::ggplot(
    MilkBreedFatProt.df,
    
    # Map Percent Butterfat to the x-axis
    # (This can be replaced with any numeric variable in another dataset)
    aes(x = PctButterfat)
  ) +
  
  # Draw a histogram of the numeric variable
  geom_histogram(
    binwidth = 0.30,      # Width of each bar (controls detail level)
    color = "black",      # Color of the bar borders
    linewidth = 1.25,     # Thickness of the bar borders
    fill = "cornsilk2"    # Fill color inside the bars
  ) +
  
  # Split the histogram into separate panels by group
  # (Each group appears in its own panel)
  facet_grid(. ~ Breed.recode) +
  
  # Add a clear, descriptive title to the figure
  ggtitle(
    "Percent Butterfat Produced by Holstein and Jersey
Dairy Cows by Breed: Holstein v Jersey"
  ) +
  
  # Customize the x-axis (numeric variable)
  scale_x_continuous(
    name = "Percent Butterfat", # Label for the x-axis
    limits = c(0, 6),           # Range of values shown on the x-axis
    breaks = seq(0, 6, 1.0)     # Tick marks at regular intervals
  ) +
  
  # Customize the y-axis (frequency/count)
  scale_y_continuous(
    name = "Count",             # Label for the y-axis
    limits = c(0, 10),           # Range of values shown on the y-axis
    breaks = seq(0, 10, 1)       # Tick marks at regular intervals
  ) +
  
  # Customize the appearance of the facet (panel) titles
  theme(
    strip.text.x = element_text(
      face = "bold",            # Make panel titles bold
      size = 12,                # Size of the panel title text
      color = "navyblue"        # Color of the panel title text
    )
  ) +
  
  # Customize the background of the facet labels
  theme(
    strip.background = element_rect(
      fill = "wheat1"           # Background color of panel labels
    )
  ) +
  
  # Apply the custom theme for overall styling
  theme_MacYates()


#Clean code:
HistogramPctButterfatBreed.recode <-
  ggplot2::ggplot(
    MilkBreedFatProt.df,
    aes(x = PctButterfat)
  ) +
  geom_histogram(
    binwidth = 0.30,
    color = "black",
    linewidth = 1.25,
    fill = "cornsilk2"
  ) +
  facet_grid(. ~ Breed.recode) +
  ggtitle(
    "Percent Butterfat Produced by Holstein and Jersey
Dairy Cows by Breed: Holstein v Jersey"
  ) +
  scale_x_continuous(
    name = "Percent Butterfat",
    limits = c(0, 6),
    breaks = seq(0, 6, 1.0)
  ) +
  scale_y_continuous(
    name = "Count",
    limits = c(0, 10),
    breaks = seq(0, 10, 1)
  ) +
  theme(
    strip.text.x = element_text(
      face = "bold",
      size = 12,
      color = "navyblue"
    )
  ) +
  theme(
    strip.background = element_rect(
      fill = "wheat1"
    )
  ) +
  theme_MacYates()

gridExtra::grid.arrange(HistogramPctButterfatBreed.recode)

#To print both objects
gridExtra::grid.arrange(
HistogramPctButterfatOverall,
HistogramPctButterfatBreed.recode, ncol=2)

#################################################################################################
# Boxplot of Percent Butterfat (Overall)
# Create and store a boxplot for Percent Butterfat (all cows together)
BoxplotPctButterfatOverall <-

  # Start a ggplot using the dataframe MilkBreedFatProt.df
  ggplot2::ggplot(
    MilkBreedFatProt.df,
    
    # Create a dummy x-axis using factor(0)
    # This forces all data into a single boxplot
    aes(x = factor(0), y = PctButterfat)
  ) +
  
  # Draw the boxplot for the numeric variable
  geom_boxplot() +
  
  # Add a point showing the MEAN value
  stat_summary(
    fun = mean,         # Function used to calculate the summary (mean)
    geom = "point",     # Draw the summary as a point
    shape = 1,          # Open circle symbol
    size = 12,          # Size of the circle
    col = "red"         # Color of the mean point
  ) +
  
  # Add a descriptive title to the plot
  ggtitle(
    "Percent Butterfat Produced by Holstein and Jersey
Dairy Cows, Mean - Red Circle"
  ) +
  
  # Label the x-axis to explain what the single box represents
  xlab("Both Breeds: Holstein and Jersey") +
  
  # Remove x-axis tick marks (not needed for a dummy variable)
  scale_x_discrete(breaks = NULL) +
  
  # Customize the y-axis scale
  scale_y_continuous(
    name = "Percent Butterfat", # Label for y-axis
    limits = c(3.0, 6.0),       # Minimum and maximum values shown
    breaks = seq(3, 6, 0.5)     # Tick marks every 0.5 units
  ) +
  
  # Apply the custom theme for consistent styling
  theme_MacYates()

📌 Important Learning Note
# x = factor(0)
#This is a dummy variable
             It is used to force all observations into one boxplot
             This technique is useful when you want one overall boxplot, not grouped by category

#Clean code:
BoxplotPctButterfatOverall <-
  ggplot2::ggplot(
    MilkBreedFatProt.df,
    aes(x = factor(0), y = PctButterfat)
  ) +
  geom_boxplot() +
  stat_summary(
    fun = mean,       
    geom = "point",    
    shape = 1,          
    size = 12,         
    col = "red"        
  ) +
  ggtitle(
    "Percent Butterfat Produced by Holstein and Jersey
Dairy Cows, Mean - Red Circle"
  ) +
  xlab("Both Breeds: Holstein and Jersey") +
  scale_x_discrete(breaks = NULL) +
  scale_y_continuous(
    name = "Percent Butterfat", 
    limits = c(3.0, 6.0),       
    breaks = seq(3, 6, 0.5)     
  ) +
  theme_MacYates()


# Boxplot of Percent Butterfat by Breed
# Create and store boxplots for Percent Butterfat, separated by Breed
BoxplotPctButterfatBreed.recode <-

  # Start a ggplot using the same dataframe
  ggplot2::ggplot(
    MilkBreedFatProt.df,
    
    # Again use a dummy x variable so each panel has one boxplot
    aes(x = factor(0), y = PctButterfat)
  ) +
  
  # Draw the boxplot
  geom_boxplot() +
  
  # Split the boxplots into panels by Breed
  facet_grid(. ~ Breed.recode) +
  
  # Add a descriptive title
  ggtitle(
    "Percent Butterfat Produced by Holstein and Jersey
Dairy Cows by Breed: Holstein v Jersey"
  ) +
  
  # Remove x-axis values (breed is already shown by facets)
  scale_x_discrete(
    name = "Breed",
    breaks = NULL
  ) +
  
  # Customize the y-axis scale
  scale_y_continuous(
    name = "Percent Butterfat",
    limits = c(3.0, 6.0),
    breaks = seq(3, 6, 0.5)
  ) +
  
  # Customize the appearance of the facet titles
  theme(
    strip.text.x = element_text(
      face = "bold",        # Bold panel titles
      size = 12,            # Text size
      color = "navyblue"    # Text color
    )
  ) +
  
  # Customize the background of the facet labels
  theme(
    strip.background = element_rect(
      fill = "wheat1"       # Background color of facet labels
    )
  ) +
  
  # Apply the overall custom theme
  theme_MacYates()



# Clean code:

BoxplotPctButterfatBreed.recode <-
  ggplot2::ggplot(
    MilkBreedFatProt.df,
    aes(x = factor(0), y = PctButterfat)
  ) +
  geom_boxplot() +
  facet_grid(. ~ Breed.recode) +
  ggtitle(
    "Percent Butterfat Produced by Holstein and Jersey
Dairy Cows by Breed: Holstein v Jersey"
  ) +
  scale_x_discrete(
    name = "Breed",
    breaks = NULL
  ) +
  scale_y_continuous(
    name = "Percent Butterfat",
    limits = c(3.0, 6.0),
    breaks = seq(3, 6, 0.5)
  ) +
  theme(
    strip.text.x = element_text(
      face = "bold",        
      size = 12,            
      color = "navyblue"    
    )
  ) +
  theme(
    strip.background = element_rect(
      fill = "wheat1"      
    )
  ) +
  theme_MacYates()

  
par(ask=TRUE)
gridExtra::grid.arrange(
BoxplotPctButterfatOverall,
BoxplotPctButterfatBreed.recode, ncol=2) 

#################################################################################################
# Density Curve of Percent Butterfat (Overall)

# Create and store a density curve for Percent Butterfat (all cows together)
DensityCurvePctButterfatOverall <-

  # Start a ggplot using the dataframe MilkBreedFatProt.df
  ggplot2::ggplot(
    MilkBreedFatProt.df,
    
    # Map Percent Butterfat to the x-axis
    aes(x = PctButterfat)
  ) +
  
  # Draw a smooth density curve (distribution estimate)
  geom_density(
    linewidth = 1.5,   # Thickness of the density curve line
    col = "red"        # Color of the density curve
  ) +
  
  # Add a descriptive title
  ggtitle(
    "Percent Butterfat Produced by Holstein and
Jersey Dairy Cows"
  ) +
  
  # Customize the x-axis (numeric variable)
  scale_x_continuous(
    name = "Percent Butterfat", # Label for x-axis
    limits = c(0, 6),           # Range of values shown
    breaks = seq(0, 6, 1.0)     # Tick marks every 1 unit
  ) +
  
  # Customize the y-axis (density values)
  scale_y_continuous(
    name = "Density",           # Label for y-axis
    limits = c(0, 0.60),        # Range of density values shown
    breaks = seq(0, 1, 0.1)     # Tick marks for density
  ) +
  
  # Apply the custom theme for consistent styling
  theme_MacYates()

# Clean code:
DensityCurvePctButterfatOverall <-
  ggplot2::ggplot(
    MilkBreedFatProt.df,
    aes(x = PctButterfat)
  ) +
  geom_density(
    linewidth = 1.5,   
    col = "red"      
  ) +
  ggtitle(
    "Percent Butterfat Produced by Holstein and
Jersey Dairy Cows"
  ) +
  scale_x_continuous(
    name = "Percent Butterfat", 
    limits = c(0, 6),           
    breaks = seq(0, 6, 1.0)     
  ) +
  scale_y_continuous(
    name = "Density",           
    limits = c(0, 0.60),       
    breaks = seq(0, 1, 0.1)    
  ) +
  theme_MacYates()


# Density Curve of Percent Butterfat by Breed

# Create and store density curves for Percent Butterfat by Breed
DensityCurvePctButterfatBreed.recode <-

  # Start a ggplot using the same dataframe
  ggplot2::ggplot(
    MilkBreedFatProt.df,
    
    # Map Percent Butterfat to the x-axis
    aes(x = PctButterfat)
  ) +
  
  # Draw density curves
  geom_density(
    linewidth = 1.5,   # Thickness of the density curve
    col = "red"        # Color of the density curve
  ) +
  
  # Split the density curves into panels by Breed
  facet_grid(. ~ Breed.recode) +
  
  # Add a descriptive title
  ggtitle(
    "Percent Butterfat Produced by Holstein and Jersey
Dairy Cows by Breed: Holstein v Jersey"
  ) +
  
  # Customize the x-axis
  scale_x_continuous(
    name = "Percent Butterfat",
    limits = c(0, 6),
    breaks = seq(0, 6, 1.0)
  ) +
  
  # Customize the y-axis (density scale)
  scale_y_continuous(
    name = "Density",
    limits = c(0, 2),
    breaks = seq(0, 2, 0.5)
  ) +
  
  # Customize the facet (panel) titles
  theme(
    strip.text.x = element_text(
      face = "bold",        # Make facet titles bold
      size = 12,            # Text size
      color = "navyblue"    # Text color
    )
  ) +
  
  # Customize the background of facet labels
  theme(
    strip.background = element_rect(
      fill = "wheat1"       # Background color of facet labels
    )
  ) +
  
  # Apply the overall custom theme
  theme_MacYates()


# Clean code:

DensityCurvePctButterfatBreed.recode <-
  ggplot2::ggplot(
    MilkBreedFatProt.df,
    aes(x = PctButterfat)
  ) +
  geom_density(
    linewidth = 1.5,   
    col = "red"        
  ) +
  facet_grid(. ~ Breed.recode) +
  ggtitle(
    "Percent Butterfat Produced by Holstein and Jersey
Dairy Cows by Breed: Holstein v Jersey"
  ) +
  scale_x_continuous(
    name = "Percent Butterfat",
    limits = c(0, 6),
    breaks = seq(0, 6, 1.0)
  ) +
  scale_y_continuous(
    name = "Density",
    limits = c(0, 2),
    breaks = seq(0, 2, 0.5)
  ) +
  theme(
    strip.text.x = element_text(
      face = "bold",        
      size = 12,            
      color = "navyblue"   
    )
  ) +
  theme(
    strip.background = element_rect(
      fill = "wheat1"      
    )
  ) +
  theme_MacYates()

#Display Both Density Plots Together
par(ask = TRUE)

gridExtra::grid.arrange(
  DensityCurvePctButterfatOverall,
  DensityCurvePctButterfatBreed.recode,
  ncol = 2              # Two plots in one row
)

################################################################################################
#Creating ggplot2 Figures for Numeric Variables - 2. Percent Protein
####################################################################
# Histogram of Percent Protein (Overall)

HistogramPctProteinOverall <-
ggplot2::ggplot(MilkBreedFatProt.df,
aes(x=PctProtein)) +
geom_histogram(binwidth=0.30, color="black", lwd=1.25,
fill="cornsilk2") +
geom_vline(aes(xintercept=mean(PctProtein, na.rm=TRUE)),
color="darkred", linetype="dashed", size=0.75) +
geom_vline(aes(xintercept=median(PctProtein, na.rm=TRUE)),
color="dodgerblue", linetype="dotted", size=1.25) +
ggtitle(
"Percent Protein Produced by Holstein and Jersey
Dairy Cows, Mean - Red and Median - Blue") +
scale_x_continuous(name="Percent Protein", limits=c(0,5),
breaks=seq(0,5,1.0)) +
scale_y_continuous(name="Count", limits=c(0,20),
breaks=seq(0,20,5)) +
theme_MacYates()

# Histogram of Percent Protein by Breed

HistogramPctProteinBreed.recode <-
ggplot2::ggplot(MilkBreedFatProt.df,
aes(x=PctProtein)) +
geom_histogram(binwidth=0.30, color="black", lwd=1.25,
fill="cornsilk2") +
facet_grid(. ~ Breed.recode) +
ggtitle(
"Percent Protein Produced by Holstein and Jersey
Dairy Cows by Breed: Holstein v Jersey") +
scale_x_continuous(name="Percent Protein", limits=c(0,5),
breaks=seq(0,5,1.0)) +
scale_y_continuous(name="Count", limits=c(0,20),
breaks=seq(0,20,5)) +
theme(strip.text.x=element_text(face="bold", size=12,
color="navyblue")) +
theme(strip.background=element_rect(fill="wheat1")) +
theme_MacYates()

par(ask=TRUE)
gridExtra::grid.arrange(
HistogramPctProteinOverall,
HistogramPctProteinBreed.recode, ncol=2)

################################################################################################
# Boxplot of Percent Protein (Overall)

BoxplotPctProteinOverall <-
ggplot2::ggplot(MilkBreedFatProt.df,
aes(x=factor(0), y=PctProtein)) +
geom_boxplot() +
stat_summary(fun.y=mean, geom="point", shape=1, size=12,
col="red") +
ggtitle(
"Percent Protein Produced by Holstein and Jersey
Dairy Cows, Mean - Red Circle") +
scale_x_discrete(name="Both Breeds: Holstein and Jersey",
breaks=NULL) +
scale_y_continuous(name="Percent Protein",
limits=c(3.0,4.25), breaks=seq(3.0,4.25,0.5)) +
theme_MacYates()

# Boxplot of Percent Protein by Breed

BoxplotPctProteinBreed.recode <-
ggplot2::ggplot(MilkBreedFatProt.df,
aes(x=factor(0), y=PctProtein)) +
geom_boxplot() +
facet_grid(. ~ Breed.recode) +
ggtitle(
"Percent Protein Produced by Holstein and Jersey
Dairy Cows by Breed: Holstein v Jersey") +
scale_x_discrete(name="Breed", breaks=NULL) +
scale_y_continuous(name="Percent Protein",
limits=c(3.0,4.25), breaks=seq(3.0,4.25,0.5)) +
theme(strip.text.x=element_text(face="bold", size=12,
color="navyblue")) +
theme(strip.background=element_rect(fill="wheat1")) +
theme_MacYates()

par(ask=TRUE)
gridExtra::grid.arrange(
BoxplotPctProteinOverall,
BoxplotPctProteinBreed.recode, ncol=2)

################################################################################################
# Density Curve of Percent Protein (Overall)

DensityCurvePctProteinOverall <-
ggplot2::ggplot(MilkBreedFatProt.df,
aes(x=PctProtein)) +
geom_density(size=1.5, col=("red")) +
ggtitle(
"Percent Protein Produced by Holstein and
Jersey Dairy Cows") +
scale_x_continuous(name="Percent Protein", limits=c(0,6),
breaks=seq(0,6,1.0)) +
scale_y_continuous(name="Density", limits=c(0.0,2.5),
breaks=seq(0.0,2.5,0.50)) +
theme_MacYates()

# Density Curve of Percent Protein by Breed

DensityCurvePctProteinBreed.recode <-
ggplot2::ggplot(MilkBreedFatProt.df,
aes(x=PctProtein)) +
geom_density(size=1.5, col=("red")) +
facet_grid(. ~ Breed.recode) +
ggtitle(
"Percent Protein Produced by Holstein and Jersey
Dairy Cows by Breed: Holstein v Jersey") +
scale_x_continuous(name="Percent Protein", limits=c(0,6),
breaks=seq(0,6,1.0)) +
scale_y_continuous(name="Density", limits=c(0.0,2.5),
breaks=seq(0.0,2.5,0.50)) +
theme(strip.text.x=element_text(face="bold", size=12,
color="navyblue")) +
theme(strip.background=element_rect(fill="wheat1")) +
theme_MacYates()

par(ask=TRUE)
gridExtra::grid.arrange(
DensityCurvePctProteinOverall,
DensityCurvePctProteinBreed.recode, ncol=2)

################################################################################################
#Descriptive Statistics for Initial Analysis of the Data
########################################################

#Checking for Missing Data
##########################

#Two commonly used functions in R for this purpose are:
             is.na()
             complete.cases()
#Both functions return TRUE or FALSE, depending on whether data are missing.
#To keep the output compact and easy to read, the table() function is wrapped around them.

#Checking for Missing Values Using is.na()
table(is.na(MilkBreedFatProt.df))

#Checking for Complete Observations Using complete.cases()
table(complete.cases(MilkBreedFatProt.df))


#Applying summary() to Selected Variables
#########################################
#Instead of summarizing the entire data frame, the function is applied to specific columns.

summary(MilkBreedFatProt.df[, 3:5])
#This applies summary() to:
             PctButterfat
             PctProtein
             Breed.recode

#Using epiDisplay::summ() for Comprehensive Descriptive Statistics
par(ask = TRUE)
par(mfrow = c(1, 2))  # Arrange 2 figures in 1 row and 2 columns

with(
  MilkBreedFatProt.df,
  epiDisplay::summ(
    PctButterfat,
    by = Breed.recode,
    main = "Percent Butterfat by Breed",
    graph = TRUE
  )
)

with(
  MilkBreedFatProt.df,
  epiDisplay::summ(
    PctProtein,
    by = Breed.recode,
    main = "Percent Protein by Breed",
    graph = TRUE
  )
)

################################################################################################
#Quality Assurance, Data Distribution, and Tests for Normality
##############################################################

#The nortest package provides several widely used normality tests.

install.packages("nortest", dependencies = TRUE)
library(nortest)        # Load the nortest package
help(package = nortest) # Show package documentation
sessionInfo()           # Confirm attached packages

#Normality Tests for PctButterfat
#Anderson–Darling Test
nortest::ad.test(MilkBreedFatProt.df$PctButterfat)

#Output (summary):
             p-value = 0.0011
             Strong evidence against normality

#Cramér–von Mises Test
nortest::cvm.test(MilkBreedFatProt.df$PctButterfat)


#Output (summary):
             p-value = 0.0015
             Strong evidence against normality

#Lilliefors (Kolmogorov–Smirnov) Test
nortest::lillie.test(MilkBreedFatProt.df$PctButterfat)

#Output (summary):
             p-value = 0.00121
             Strong evidence against normality

#Pearson Chi-Square Test
nortest::pearson.test(MilkBreedFatProt.df$PctButterfat)

#Output (summary):
             p-value = 0.033
             Evidence against normality at the 0.05 level

#Shapiro–Francia Test
nortest::sf.test(MilkBreedFatProt.df$PctButterfat)

#Output (summary):
             p-value = 0.0091
             Evidence against normality
			 
#Consistency of Test Results
#Across all applied normality tests for PctButterfat:
             All p-values are ≤ 0.05
             Several are ≤ 0.01
##This provides consistent evidence that PctButterfat does not strictly follow a normal distribution.			 

#####Why Are Many Normality Tests Used?
#We use multiple normality tests to confirm and cross-check whether the data deviate from normal distribution, because no single test is perfect in all situations.

#Which Normality Test Is Most Suited?
| Situation                                | Recommended Test                   |
| ---------------------------------------- | ---------------------------------- |
| Small to moderate samples (N < 50)       | **Shapiro–Wilk / Shapiro–Francia** |
| General-purpose, strong tail sensitivity | **Anderson–Darling**               |
| Teaching & demonstration                 | Multiple tests                     |
| Routine applied analysis                 | One test + graphical checks        |

👉 In this example, Anderson–Darling and Shapiro–Francia are especially appropriate.


#Using a Density Plot as a Visual Check
#######################################
#To better understand the distribution of PctButterfat, a density plot is prepared.
Graphical inspection is an important complement to formal normality tests.

plot(
  density(MilkBreedFatProt.df$PctButterfat, na.rm = TRUE),
  main = "Percent Butterfat: Density Plot",
  col = "red",
  lwd = 3,
  xlim = c(0, 6),
  font = 2
)
#For PctButterfat, the density plot indicates that:
             The curve does not resemble a bell-shaped (normal) curve
             The distribution appears skewed and asymmetric
             The peak and tails do not align with what is expected under normality


#Combined Interpretation (Test + Graph)
#Taken together:
             Formal test evidence - Anderson–Darling p-value = 0.0011 (< 0.05)
             Graphical evidence - Density curve does not approximate a normal distribution

#These two sources of evidence agree and suggest that PctButterfat is not normally distributed overall.
################################################################################################
#Assessing Normality of PctButterfat by Breed
#############################################
#Student’s t-Test compares group means, the normality of each group separately is more relevant than normality of the pooled data.

#Using the RVAideMemoire Package
#The RVAideMemoire package provides convenient functions for assessing normality:
             mshapiro.test() – tests normality of the variable overall
             byf.shapiro() – tests normality within each group

install.packages("RVAideMemoire", dependencies = TRUE)
library(RVAideMemoire)
help(package = RVAideMemoire)
sessionInfo()

#Normality Test of PctButterfat (Overall)
RVAideMemoire::mshapiro.test(MilkBreedFatProt.df$PctButterfat)

#Output (Summary)
             p-value = 0.00281
#Interpretation
             The p-value is less than 0.05
             The null hypothesis of normality is rejected
             PctButterfat is not normally distributed when all observations are pooled together

#Normality Test of PctButterfat by Breed
RVAideMemoire::byf.shapiro(PctButterfat ~ Breed.recode,
                           data = MilkBreedFatProt.df)

#Output (Summary)
| Breed    | W Statistic | p-value |
| -------- | ----------- | ------- |
| Holstein | 0.9405      | 0.2446  |
| Jersey   | 0.9551      | 0.3973  |

#Interpretation of Group-wise Results
#Holstein cows
             p-value = 0.2446 > 0.05
             Fail to reject normality

#Jersey cows
             p-value = 0.3973 > 0.05
             Fail to reject normality

#This indicates that PctButterfat is approximately normally distributed within each breed.

#This situation is very common in practice.
             When data from two groups with different means are combined:
                 The pooled distribution may appear skewed or multimodal
             This can cause overall normality tests to fail
             However, within-group distributions may still be normal

##This phenomenon is known as "mixture distributions".


################################################################################################
#Assessing Normal Distribution of PctProtein
############################################
#The same normality assessment process applied to PctButterfat is now applied to the numeric object variable PctProtein, in order to determine whether normal distribution holds overall and whether further group-wise investigation is necessary.

#Normality Tests for PctProtein
#Anderson–Darling Test
nortest::ad.test(MilkBreedFatProt.df$PctProtein)

#Output (Summary)
             p-value = 0.521
             Since the p-value is greater than 0.05, the null hypothesis of normality is not rejected.

#Additional Normality Tests
             Cramér–von Mises Test: p = 0.531
             Lilliefors Test: p = 0.734
             Pearson Chi-square Test: p = 0.451
             Shapiro–Francia Test: p = 0.613

#In all cases, the calculated p-values are greater than 0.05, providing no evidence against normality.


#Graphical Confirmation Using a Density Plot

plot(
  density(MilkBreedFatProt.df$PctProtein, na.rm = TRUE),
  main = "Percent Protein: Density Plot",
  col = "red",
  lwd = 3,
  xlim = c(0, 6),
  font = 2
)

#Interpretation of the Density Plot
#The density plot shows that:
             The distribution is smooth and symmetric
             The curve approximates a bell-shaped (normal) distribution
             No strong skewness or heavy tails are apparent

#This graphical evidence is consistent with the formal normality test results.

#Summary for PctProtein
             All applied normality tests return p-values > 0.05
             The density plot supports a normal distribution
             Normality concerns for PctProtein are minimal
#Therefore, PctProtein satisfies the normality assumption, both statistically and visually.

################################################################################################
#Assessing Normal Distribution of PctProtein by Breed
#####################################################

#Although overall normality is satisfied, it is still important to determine whether this finding holds within each breed (Holstein vs Jersey).
#This is particularly relevant because Student’s t-Test assumes normality within groups, not only for pooled data.


#Overall Shapiro–Wilk Normality Test
RVAideMemoire::mshapiro.test(MilkBreedFatProt.df$PctProtein)

#Output (Summary)
             p-value = 0.569

#Interpretation
             The p-value is greater than 0.05
             The null hypothesis of normality is not rejected
             PctProtein satisfies normality overall

#Shapiro–Wilk Normality Tests by Breed
RVAideMemoire::byf.shapiro(PctProtein ~ Breed.recode,
                           data = MilkBreedFatProt.df)

#Output (Summary)
| Breed    | W Statistic | p-value |
| -------- | ----------- | ------- |
| Holstein | 0.9671      | 0.7173  |
| Jersey   | 0.9617      | 0.5237  |

#Interpretation of Group-wise Results
#Holstein dairy cows
             p-value = 0.7173 > 0.05
             Fail to reject normality

#Jersey dairy cows
             p-value = 0.5237 > 0.05
             Fail to reject normality
#Thus, PctProtein is approximately normally distributed within each breed.

#All p-values are well above 0.05, providing consistent evidence that PctProtein satisfies the normality assumption, both overall and by breed.
################################################################################################
#Using Q–Q Plots to Reinforce Normality Assessment
##################################################
#Percent Butterfat – Overall

QQPctFatOverall <-
  ggplot2::ggplot(
    MilkBreedFatProt.df,
    aes(sample = PctButterfat)
  ) +
  stat_qq(color = "red") +                     # Q–Q points
  stat_qq_line(color = "blue", linewidth = 1.25) +  # Reference line
  ggtitle("% Butterfat Q–Q Plot and Q–Q Line, Overall") +
  labs(
    x = "\nTheoretical Quantiles",
    y = "Percent\n"
  ) +
  theme_MacYates()

#Percent Butterfat – By Breed

QQPctFatBreed.Recode <-
  ggplot2::ggplot(
    MilkBreedFatProt.df,
    aes(sample = PctButterfat)
  ) +
  stat_qq(color = "red") +
  stat_qq_line(color = "blue", linewidth = 1.25) +
  facet_grid(. ~ Breed.recode) +                # Separate plots by breed
  ggtitle("% Butterfat Q–Q Plot and Q–Q Line, by Dairy Breed") +
  labs(
    x = "\nTheoretical Quantiles",
    y = "Percent\n"
  ) +
  theme(
    strip.text.x = element_text(face = "bold", size = 12, color = "navyblue"),
    strip.background = element_rect(fill = "wheat1")
  ) +
  theme_MacYates()

#Percent Protein – Overall

QQPctProteinOverall <-
  ggplot2::ggplot(
    MilkBreedFatProt.df,
    aes(sample = PctProtein)
  ) +
  stat_qq(color = "red") +
  stat_qq_line(color = "blue", linewidth = 1.25) +
  ggtitle("% Protein Q–Q Plot and Q–Q Line, Overall") +
  labs(
    x = "\nTheoretical Quantiles",
    y = "Percent\n"
  ) +
  theme_MacYates()

#Percent Protein – By Breed

QQPctProteinBreed.Recode <-
  ggplot2::ggplot(
    MilkBreedFatProt.df,
    aes(sample = PctProtein)
  ) +
  stat_qq(color = "red") +
  stat_qq_line(color = "blue", linewidth = 1.25) +
  facet_grid(. ~ Breed.recode) +
  ggtitle("% Protein Q–Q Plot and Q–Q Line, by Dairy Breed") +
  labs(
    x = "\nTheoretical Quantiles",
    y = "Percent\n"
  ) +
  theme(
    strip.text.x = element_text(face = "bold", size = 12, color = "navyblue"),
    strip.background = element_rect(fill = "wheat1")
  ) +
  theme_MacYates()

#Display All Q–Q Plots Together

par(ask = TRUE)

gridExtra::grid.arrange(
  QQPctFatOverall,
  QQPctFatBreed.Recode,
  QQPctProteinOverall,
  QQPctProteinBreed.Recode,
  ncol = 2
)

#Interpretation of the Q–Q Plots
#PctButterfat
             Overall: noticeable departures from the reference line
             By breed: points align more closely with the line
             Confirms earlier findings:
                 Overall non-normality
                 Approximate normality within each breed

#PctProtein
             Overall: points closely follow the reference line
             By breed: alignment remains strong

################################################################################################
#Group Balance
##############
#Group balance refers to whether the groups being compared have similar sample sizes.

#For example:
             Balanced groups: 20 Holstein vs 22 Jersey
             Unbalanced groups: 5 Holstein vs 37 Jersey
#Student’s t-Test works more reliably when group sizes are similar

####Practical Rule of Thumb
#If group sizes differ by more than about 2:1, be cautious with the classical t-Test.

#In such cases:
             Welch’s t-Test
             Nonparametric tests
################################################################################################
#The Normality Spectrum and Test Selection
##########################################
Perfectly Normal
      ↓
Approximately Normal
      ↓
Moderately Non-Normal
      ↓
Strongly Skewed / Heavy Tails
      ↓
Highly Non-Normal / Outliers

#Suitability of Statistical Tests Across the Normality Spectrum

| Data Distribution        | How the Data Look                                                    | Recommended Test                               | Simple Decision               |
| ------------------------ | -------------------------------------------------------------------- | ---------------------------------------------- | ----------------------------- |
| **Approximately Normal** | Symmetric,Few or no outliers, Q–Q plot almost straight               | Student’s *t*-Test, Paired *t*-Test, ANOVA     | ✔️ Use *t*-Test               |
| **Mildly Non-Normal**    | Slight skewness, Small tail deviations, Q–Q plot slightly curved     | Student’s *t*-Test, Welch’s *t*-Test           | ✔️ *t*-Test still OK          |
| **Strongly Non-Normal**  | Clear skewness, Outliers present, Q–Q plot clearly curved            | Mann–Whitney U test, Permutation test          | ⚠️ Avoid *t*-Test if possible |
| **Extremely Non-Normal** | Extreme skewness, Many outliers, Small sample size                   | Nonparametric tests, Robust methods            | ❌ Do NOT use *t*-Test        |

#What About Student’s t-Test?
#############################
             Student’s t-Test is robust to moderate deviations from normality
             With roughly balanced groups and similar variances, it often performs well
             Strict normality is not always required

####Best-Practice Decision Rule (Exam- and Research-Safe)
1. Look at the data visually (Histogram, Density plot, Q–Q plot) 
             Perform this overall and by group
2. Check sample size 
             ≥ 20 per group → t-test is usually safe
			 Small samples (< 15) → assumptions become more important
3. Check group balance
             Similar sizes → robustness increases (The risk of incorrect conclusions is reduced)
			 Strongly unbalanced groups → higher risk of incorrect conclusions
4. Check Normality overall and by Group
             Apply normality tests within each group
             Approximate normality within groups is sufficient
5. Check Variance Equality
             If variances are unequal or groups are unbalanced → prefer Welch’s t-Test
			 
#Then decide
| Condition                                                 | Recommended Test            |
| --------------------------------------------------------- | --------------------------- |
| Groups approximately normal (even if pooled data are not) | Student’s t-Test            |
| Mild or moderate deviation within groups                  | Student’s t-Test (robust)   |
| Unequal variances or unbalanced groups                    | Welch’s t-Test              |
| Strong deviation or many outliers within groups           | Mann–Whitney test           |
| Severe deviation, small samples, extreme outliers         | Nonparametric test          |

#################################################################################################Choice of Inferential Test
###########################
#The parametric Student’s t-Test for Independent Samples will be used to evaluate whether there is a statistically significant difference (p ≤ 0.05) between breeds for:
             Percent Butterfat
             Percent Protein

#Although overall normality was not evident for Percent Butterfat, the following considerations support the use of the t-Test:
             Normality holds within each breed
             Group sizes are moderate and balanced (20 vs 22)
             Student’s t-Test is robust to moderate deviations from normality

#Therefore, concerns regarding overall normality are not sufficient to preclude the use of Student’s t-Test for Independent Samples in this context.

#Null Hypotheses
################
#The inferential testing is based on the following null hypotheses:

H₀₁: There is no statistically significant difference (p ≤ 0.05) in the Percent Butterfat of milk by breed (Holstein vs Jersey).

H₀₂: There is no statistically significant difference (p ≤ 0.05) in the Percent Protein of milk by breed (Holstein vs Jersey).

################################################################################################
#The t.test() function is part of the stats package, which is automatically loaded when R is installed.

#Test 1: Percent Butterfat by Breed
#Null Hypothesis (H₀₁)
             There is no statistically significant difference (p ≤ 0.05) in Percent Butterfat of milk between Holstein and Jersey dairy cows.

t.test(
  MilkBreedFatProt.df$PctButterfat ~     # Measured variable
    MilkBreedFatProt.df$Breed.recode,    # Grouping variable
  alternative = "two.sided",             # Two-sided test
  paired = FALSE,                        # Independent samples
  na.rm = TRUE,                          # Remove missing values
  var.equal = TRUE                       # Assume equal variances
)

t.test(
  MilkBreedFatProt.df$PctButterfat ~ MilkBreedFatProt.df$Breed.recode,    
  alternative = "two.sided",                                   
  na.rm = TRUE,                         
  var.equal = TRUE                      
)

#Output (Summary)
             t = −12.53
             Degrees of freedom = 40
             p-value = 2.01 × 10⁻¹⁵
             Mean values:
                 Holstein: 3.56
                 Jersey: 4.86

#Interpretation
#The calculated p-value is far smaller than the criterion p-value of 0.05.
Therefore, the null hypothesis is rejected.

#Conclusion:
#There is a statistically significant difference in Percent Butterfat between Holstein and Jersey dairy cows. Jersey cows have a significantly higher mean Percent Butterfat than Holstein cows, and this difference is not due to chance.

#Test 2: Percent Protein by Breed
#Null Hypothesis (H₀₂)
             There is no statistically significant difference (p ≤ 0.05) in Percent Protein of milk between Holstein and Jersey dairy cows.

t.test(
  MilkBreedFatProt.df$PctProtein ~        # Measured variable
    MilkBreedFatProt.df$Breed.recode,     # Grouping variable
  alternative = "two.sided",              # Two-sided test
  paired = FALSE,                         # Independent samples
  na.rm = TRUE,                           # Remove missing values
  var.equal = TRUE                        # Assume equal variances
)


t.test(
  MilkBreedFatProt.df$PctProtein ~        
    MilkBreedFatProt.df$Breed.recode,     
  alternative = "two.sided",              
  na.rm = TRUE,                           
  var.equal = TRUE                       
)

#Output (Summary)
             t = −2.13
             Degrees of freedom = 39
             p-value = 0.0394
             Mean values:
                 Holstein: 3.39
                 Jersey: 3.56

#Interpretation
#The calculated p-value (0.0394) is less than the criterion p-value of 0.05.
Therefore, the null hypothesis is rejected.

#Conclusion:
#There is a statistically significant difference in Percent Protein between Holstein and Jersey dairy cows. Jersey cows have a significantly higher mean Percent Protein than Holstein cows, and the observed difference is unlikely to be due to chance.

#Important Note on Choice of Significance Level
#The interpretation of statistical significance depends on the chosen criterion p-value.
             At p ≤ 0.05, the difference in Percent Protein (p = 0.0394) is statistically significant.

             At p ≤ 0.01, the same result would not be statistically significant.

####This example highlights the importance of clearly stating the significance level in advance (e.g., 0.10, 0.05, 0.01, or 0.001) before making inferential conclusions.

################################################################################################
#Redundant Confirmation of Inferential Outcomes
###############################################

#####In applied biostatistics, it is often considered good analytical practice to confirm important inferential results using more than one statistical function or method. 
#While results obtained from different functions may not be numerically identical, there should be a close degree of agreement (parity) in conclusions.

#To reinforce the outcomes obtained using the base R t.test() function, additional tests from the onewaytests package are applied.

#Additional R Packages Used - onewaytests package

install.packages("onewaytests", dependencies = TRUE)
library(onewaytests)
help(package = onewaytests)
sessionInfo()



#Descriptive Statistics: Percent Butterfat by Breed
#Before re-testing, descriptive statistics are generated to confirm consistency with earlier results.

onewaytests::describe(PctButterfat ~ Breed.recode,
                      data = MilkBreedFatProt.df)

#Summary Interpretation
#Holstein cows
             Mean ≈ 3.56
			 Standard deviation ≈ 0.43

#Jersey cows
             Mean ≈ 4.86
			 Standard deviation ≈ 0.21

#These values closely match previously reported descriptive statistics, confirming internal consistency of the dataset.


#Confirmation Using Student’s t-Test (onewaytests)

onewaytests::st.test(PctButterfat ~ Breed.recode,
                     data = MilkBreedFatProt.df,
                     alpha = 0.05,
                     na.rm = TRUE,
                     verbose = TRUE)

#Output Summary
             Test statistic ≈ −12.19
             Degrees of freedom ≈ 39
             p-value ≪ 0.05

#Interpretation
#The difference in Percent Butterfat between Holstein and Jersey cows is statistically significant
#This result closely matches the outcome obtained using stats::t.test()



#Confirmation Using Welch’s Unequal Variances t-Test

onewaytests::wt.test(PctButterfat ~ Breed.recode,
                     data = MilkBreedFatProt.df,
                     alpha = 0.05,
                     na.rm = TRUE,
                     verbose = TRUE)

#Output Summary
             Test statistic ≈ −11.61
			 Degrees of freedom ≈ 24.7
			 p-value ≪ 0.05

#Interpretation
             The difference remains statistically significant
			 Welch’s t-Test is especially useful when:
			     Variances may differ
				 Group sizes are not exactly equal

#Comparison of Test Results
| Test Used                | Variance Assumption | Result      |
| ------------------------ | ------------------- | ----------- |
| `stats::t.test()`        | Equal variances     | Significant |
| `onewaytests::st.test()` | Equal variances     | Significant |
| `onewaytests::wt.test()` | Unequal variances   | Significant |

################################################################################################

#Descriptive Statistics: Percent Protein by Breed

onewaytests::describe(PctProtein ~ Breed.recode,
                      data = MilkBreedFatProt.df)

#Summary Interpretation
#Holstein cows
             Sample size: N = 19 (one missing observation)
			 Mean ≈ 3.39
			 Standard deviation ≈ 0.32

#Jersey cows
             Sample size: N = 22
			 Mean ≈ 3.56
			 Standard deviation ≈ 0.18

#These descriptive statistics are in close agreement with previously reported values, confirming internal consistency of the dataset.


#Confirmation Using Student’s t-Test (onewaytests)

onewaytests::st.test(PctProtein ~ Breed.recode,
                     data = MilkBreedFatProt.df,
                     alpha = 0.05,
                     na.rm = TRUE,
                     verbose = TRUE)

#Output Summary
             Test statistic ≈ −2.13
			 Degrees of freedom ≈ 39
			 p-value ≈ 0.0394

#Interpretation
             The calculated p-value is less than the criterion p-value of 0.05
             The null hypothesis is rejected
			 The difference in Percent Protein between Holstein and Jersey cows is statistically significant

#This result closely matches the earlier findings obtained using stats::t.test().


#Confirmation Using Welch’s Unequal Variances t-Test

onewaytests::wt.test(PctProtein ~ Breed.recode,
                     data = MilkBreedFatProt.df,
                     alpha = 0.05,
                     na.rm = TRUE,
                     verbose = TRUE)

#Output Summary
             Test statistic ≈ −2.05
			 Degrees of freedom ≈ 27.76
			 p-value ≈ 0.0497

#Interpretation
             The difference remains statistically significant at α = 0.05
			 Welch’s t-Test is especially appropriate when:
			     Group variances may differ
				 Group sizes are unequal

#The slightly larger p-value reflects the more conservative nature of Welch’s test

#Comparison of Inferential Results
| Test                     | Variance Assumption | p-value | Conclusion  |
| ------------------------ | ------------------- | ------- | ----------- |
| `stats::t.test()`        | Equal variances     | ≈ 0.039 | Significant |
| `onewaytests::st.test()` | Equal variances     | ≈ 0.039 | Significant |
| `onewaytests::wt.test()` | Unequal variances   | ≈ 0.050 | Significant |

################################################################################################
#t-Statistic versus z-Statistic
###############################

#The t-statistic (t) begins to approximate the z-statistic (z) as the sample size increases, particularly when the number of observations exceeds about 30. 
#This convergence is a direct consequence of the Central Limit Theorem, which states that sampling distributions of the mean tend toward normality as sample size increases.

#Both the t-test and z-test are used to determine whether there is a statistically significant difference between group means. 
#They share similar goals and assumptions, but differ in important ways:

#The t-test is typically used when:
             Sample sizes are small or moderate
			 Population standard deviations are unknown

#The z-test is typically used when:
             Sample sizes are large
			 The sampling distribution can be well approximated by the normal distribution

#As sample size increases, the t-distribution becomes increasingly similar to the standard normal distribution, causing t and z values to converge.

#Demonstration Using a Hypothetical Blood Pressure Dataset
##########################################################

#To illustrate this concept, consider the hypothetical dataset Ad1BloodPressure.df, which contains systolic blood pressure measurements for 40 subjects, grouped by gender (Male vs Female).

#The question of interest is:

Does the t-statistic approximate the z-statistic when the sample size is 40?
Would this approximation improve if the dataset were expanded to 400 subjects?

#Creating the Enumerated Dataset
Ad1BloodPressure.df <- read.table(textConnection("
Ad1Subject Ad1Gender Ad1Systolic
S01 Male 147
S02 Female 121
S03 Female 116
S04 Female 77
S05 Male 79
S06 Female 107
S07 Male 119
S08 Female 105
S09 Female 128
S10 Male 155
S11 Male 79
S12 Female 111
S13 Male 122
S14 Male 130
S15 Female 150
S16 Male 170
S17 Male 146
S18 Male 171
S19 Male 153
S20 Female 113
S21 Male 106
S22 Male 147
S23 Female 158
S24 Male 143
S25 Male 132
S26 Female 131
S27 Male 84
S28 Male 133
S29 Male 165
S30 Female 123
S31 Female 163
S32 Male 119
S33 Female 125
S34 Male 143
S35 Male 106
S36 Male 96
S37 Female 78
S38 Female 125
S39 Male 150
S40 Male 80"), header = TRUE)


#Basic data checks:
str(Ad1BloodPressure.df)
summary(Ad1BloodPressure.df)

#Student’s t-Test for Independent Samples
t.test(
  Ad1BloodPressure.df$Ad1Systolic ~
    Ad1BloodPressure.df$Ad1Gender,
  alternative = "two.sided",
  paired = FALSE,
  na.rm = TRUE,
  var.equal = TRUE
)


#z-Test Using the coin Package
##############################

#To perform a test based on the z-statistic, the coin::independence_test() function is used.

install.packages("coin")
library(coin)

coin::independence_test(
  Ad1Systolic ~ Ad1Gender,
  data = Ad1BloodPressure.df
)

#Output Summary
             Z ≈ −0.85
			 p-value ≈ 0.396

#Interpretation of Results
#For this dataset with 40 subjects:
			 The t-statistic and z-statistic are numerically very similar
			 The p-values are approximately equal
			 Both tests lead to the same inferential conclusion

#This demonstrates that, at this sample size, the t-statistic closely approximates the z-statistic.

#What If the Sample Size Were 400?
#If the dataset were expanded to 400 subjects:
             The approximation of t to z would be even closer
			 The t-distribution would be virtually indistinguishable from the standard normal distribution
			 Differences between t-test and z-test results would become negligible

#Practical Implications
             Student’s t-Test is fully appropriate for small samples (≤ 30 per group)
			 As sample size increases, the t-test naturally behaves like a z-test
			 For large samples, performing a z-test may be of interest, but is not required
			 Confirming results using both tests can provide reassurance in quality assurance settings
			 