##############################################################
# Master in Biochemistry and Biotechnology – Semester I 
# Topic : Before we start -1
# Course: BCBT 54813 - Biostatistics
# Author: Nimroth Ambanpola
##############################################################



#What is R? What is RStudio?
############################
#The term “R” is used to refer to both the programming language and the software that interprets the scripts written using it.

#RStudio IDE is currently a very popular way to not only write your R scripts but also to interact with the R software. To function correctly, RStudio needs R and therefore both need to be installed on your computer.



#Setup instructions
###################
#R and RStudio are separate downloads and installations. You need to install R before you install RStudio. 

#Windows
#If you already have R and RStudio installed
#Open RStudio, and click on “Help” > “Check for updates”. If a new version is available, quit RStudio, and download the latest version for RStudio.
#To check which version of R you are using,you can type, which will also display which version of R you are running. 
sessionInfo()

#Output:
R version 4.4.2 (2024-10-31 ucrt)
Platform: x86_64-w64-mingw32/x64
Running under: Windows 11 x64 (build 26200)

Matrix products: default


locale:
[1] LC_COLLATE=English_United Kingdom.utf8  LC_CTYPE=English_United Kingdom.utf8    LC_MONETARY=English_United Kingdom.utf8
[4] LC_NUMERIC=C                            LC_TIME=English_United Kingdom.utf8    

time zone: Europe/Berlin
tzcode source: internal

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

loaded via a namespace (and not attached):
[1] compiler_4.4.2 tools_4.4.2 

#Go on the CRAN website and check whether a more recent version is available. If so, please download and install it. 


#If you don’t have R and RStudio installed
#Download R from the CRAN website. Run the .exe file that was just downloaded

#macOS
#Download R from the CRAN website. Select the .pkg file for the latest R version




#RStudio is divided into 4 “Panes”: 
#1. Source for your scripts and documents (top-left, in the default layout)
#2. Environment/History (top-right)
#3. Files/Plots/Packages/Help/Viewer (bottom-right)
#4. R Console (bottom-left)



#R version

R.Version()$version.string
#Output:
[1] "R version 4.4.2 (2024-10-31 ucrt)"


#################################################################################################

#You saw this message in R:

The downloaded binary packages are in
C:\Users\Nimroth Ambanpola\AppData\Local\Temp\RtmpwlLxQ1\downloaded_packages

#What this means

#When you run install.packages(), R:
             Downloads the package files into a temporary folder
             Installs them into your R library
             Leaves the downloaded archive behind (unless R exits)


#Once a package is installed:
             R does not use the downloaded archive anymore

#The actual package lives in:

Documents\R\win-library\<version>\
#or
Program Files\R\R-x.x.x\library\


#Is it safe to delete them?
✅ YES — 100% safe


#What happens if you delete them?
             Installed packages continue to work normally
             Nothing breaks
             If needed again, R will simply re-download them


#Best ways to remove them
             Close R / RStudio
             Press Windows + R
             Type: %temp%
             Delete folders starting with: Rtmp*****
