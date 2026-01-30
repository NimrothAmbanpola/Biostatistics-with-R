# Biostatistics with R – Teaching Scripts & Worked Examples

This repository contains a **teaching-oriented biostatistics course** implemented in **R**.  
Each lesson is provided as an **R script that combines theory and practice**, where:

- Statistical concepts are explained **in detail using comments**
- R code is used to demonstrate **real analyses step by step**
- Emphasis is placed on **interpretation**, not just computation

The material is designed for **students in biology, biochemistry, biotechnology, public health, and related life sciences**, with minimal prior programming experience.

---

## Course Structure

The course is organized into **self-contained R scripts**, each corresponding to one major statistical topic.

## Lesson Descriptions

### **01. Introduction to R and RStudio**
- What is R and why it is used in biostatistics
- RStudio interface overview
- Basic R syntax, objects, vectors, and functions

---

### **02. Setting Up the R Environment for Data Analysis**
- Working directories and file paths
- Installing and loading packages
- Reproducible workflows
- Good coding and documentation practices

---

### **03. Data Exploration and Visualization**
- Data structures in R (data frames, factors)
- Descriptive statistics
- Histograms, boxplots, density plots
- Introduction to `ggplot2`
- Visual data quality checks

---

### **04. Student’s t-Test for Independent Samples**
- Conceptual background of hypothesis testing
- Assumptions of the independent samples t-test
- Effect size and interpretation
- Visualization and reporting results

---

### **05. Student’s t-Test for Paired (Matched) Samples**
- Paired study designs
- Difference scores
- Assumptions and diagnostics
- Interpretation in biological contexts

---

### **06. One-Way Analysis of Variance (ANOVA)**
- Comparing means across multiple groups
- Assumptions of ANOVA
- Post hoc tests (Tukey HSD)
- Interpretation and reporting

---

### **07. Two-Way (Factorial) ANOVA**
- Main effects and interaction effects
- Model specification using `aov()`
- Diagnostic checks
- Post hoc analysis using `TukeyHSD()` and `emmeans`
- Interaction plots and interpretation

---

### **08. Correlation and Regression Analysis**
- Pearson and Spearman correlation
- Simple linear regression
- Model assumptions
- Interpretation of coefficients
- Visualization of relationships

---

## 📂 Data Folder

The `data/` directory contains **all datasets required** to run the scripts.

- Each dataset is used in one or more lessons
- Files are provided in standard formats (e.g. `.csv`)
- Variable names are chosen to be **self-explanatory**
- A separate `data/README.md` explains each dataset
