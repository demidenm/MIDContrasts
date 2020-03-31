############################################################################################
# Title: Code for calculating the upper and lower bounds for Michael's behavioral data
# Author: Karthik G
# Date: 1/21/2020
#
#
# This script implements a bootstrap based approach for calculating confidence intervals of 
# correlation estimates between ROIs and behavioral measures across 104 subjects. 
#
# This script takes as input the behavioral data provided by Michael along with a confidence
# level and provides as output a correlational point estimate along with its confidence 
# intervals calculated using normal approximation with bootstrap standard error.  
#
#
# Input- data: in csv format (line 22)
#        conf_level: confidence level between 0 and 1 (line 30)
#        b: number of bootstrap replicates- suggested value: 1e3 or 5e3 (line 29)
#
# Output- A csv file consisting of the correlational point esimate between ROI and behavioral
# measures along with their lower and upper bounds. (line 100)
#############################################################################################
data = read.csv("C:/Users/gkarthik/Desktop/Michael/behdata/alldata.csv")

measures = data[,c(2:6)]
roi = data[,c(7:ncol(data))]

## Setting the replicates at 5000 as per your previous suggestion that it is the 
## standard bootstrap replicates they follow in literature. 
b = 5e3             # Specify the number of replicates for measures and ROI
conf_level = 0.05   # Specify the confidence level for the upper and lower bounds

# Extract column names for usage in writing out results
colnames_measures = colnames(measures)  
colnames_roi = colnames(roi)

# Initiate output variables
corr_beh_data = data.frame(t(c(0,0,0,0,0)))
colnames(corr_beh_data) = c("ROI", "Pheno", "Boot.r", "Upper.CI", "Lower.CI")
temp_result = data.frame()

# Be inefficient by creating counters. Why? Because we is lazy 
counter = 1

for (obsroi in 1:ncol(roi)){
  for (obsmeasures in 1:ncol(measures)){
    ## Get a little fancy by printing out progress of the code. Why? Because we can. 
    print(paste0(obsroi," out of ",ncol(roi), " ROIs done"))
    print(paste0(obsmeasures," out of ",ncol(measures), " measures done"))
    
    ## Extract each of the roi and measure data for individual correlations
    roidata = roi[,obsroi]
    measure_data = measures[,obsmeasures]

    ## Check if any of the observations have NA. If they do, drop those subjects. 
    NAindices = which(is.na(roidata), arr.ind = TRUE)
    roidata = roidata[complete.cases(roidata)]
    if(length(NAindices)>0){
      measure_data = measure_data[-NAindices]
    }
    
    ## Create shuffle labels for the replicates
    indx = sample(1:length(measure_data), b*length(measure_data), replace = TRUE)
    indy = sample(1:length(roidata), b*length(roidata), replace = TRUE)
    
    ## Create bootstrap samples from measure data
    Bx = measure_data[indx]
    dim(Bx) = c(b,length(measure_data))
    
    ## Create bootstrap samples from roi data             
    By = roidata[indy]
    dim(By) = c(b,length(roidata))
    
    ## Calculate bootstrap distribution of the correlation estimates
    corrmat = 0
    for (i in 1:b){
      corrmat[i] = cor(By[i,],Bx[i,], method = "pearson")       ## Create distributions of correlations
    }
    
    ## Point estimate of correlations value from observed data
    corr_estimate = cor(roidata,measure_data)             

    ## Lower and upper bound calculation using normal approximation with bootstrap standard error
    lcb_na = corr_estimate - qnorm(1 - conf_level/2)*sd(corrmat)
    
    ucb_na = corr_estimate + qnorm(1 - conf_level/2)*sd(corrmat)
    
    temp_result = c(colnames_roi[obsroi], 
                    colnames_measures[obsmeasures],
                    corr_estimate,
                    ucb_na,
                    lcb_na)
    corr_beh_data[counter,] = temp_result
    
    # Add more inefficiency in the code. Why? Because we is badass
    counter = counter + 1
  }
}

## Export result as csv 
write.csv(corr_beh_data,"C:/Users/gkarthik/Desktop/Michael/behdata/pheno_boot_cor.csv",
          row.names = FALSE)
