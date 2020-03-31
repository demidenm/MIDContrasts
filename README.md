# MIDContrasts

This repository contains information for scripts used in the manuscript [xxxx]

The contents in the main folder contain the [MID_Contrasts_R Code.Rmd] file used in creating correlational matrices used in subsequent bootstrapping and bayes analyses, heatmap presented in the manuscript, general demographic and behavioral correlational table. The [PredictionError_code.Rmd] file was used in conjuction with the behavioral data collected by E-Prime to create Expected Value, Prediction error (Pos and Negative) following the working learnig model presented in the manuscript and below:

RL model trained by reward cues and outcomes (Rescorla & Wagner, 1972):
〖EV〗_t= 〖pGain〗_t  × 〖Cue〗_t
〖 PE〗_t= 〖RR〗_t  × 〖EV〗_t
〖pGain〗_(t+1)= 〖pGain〗_t+( ×〖PE〗_t/〖Cue〗_t ) 

Subfolders in the directory include: FeatFiles, Aim1*, Aim2*, and Aim3*, which are described below.

The [FeatFiles] folder contains all Feat files used to generate group level maps in the analyses. These include all all over the Contrasts described in Table 1 of the manuscript, in addition to direct comparison of Anticipation Difference between Big Win > Big Lose; Difference in Anticipation Big Win > Feedback Big Win.

Contrasts	Phases of MID Modeled
Contrast 1 (C1) - Ant	Win (W) > Neutral (N) (W>N)
Contrast 2 (C2) - Ant	Big Win (BW) > Neutral (N) (BW>N)
Contrast 3 (C3) - Ant	Big Win (BW) > Small Win (SW) (BW>SW)
Contrast 4 (C4) - Ant	Big Win (BW) > Implicit Baseline (BW>BL)
Contrast 5 (C5) - Ant	Big Lose (BL) > Neutral (N) (BL>N)
Contrast 6 (C6) - FB	Big Win (BW) Hit > Neutral (N) Hit (BWH>NH)
Contrast 7 (C7) - FB	Big Lose (BW) Hit > Neutral (N) Hit (BWH>NH)
Contrast 8 (C8) - PE	Expected Value - BW & SM Modulated (EV)
Contrast 9 (C9) - PE	Positive Prediction Error (PE) - BW & SM Modulated (PPE)
Contrast 10 (C10) - PE	Negative Prediction Error (PE) - BL & SL Modulated (NPE)

The subfolder [Aim1_Activation_JaccardCoeff] contains scripts used for calculating the similarity matrices. First, quality control was performed checking missing voxels and outlier voxels in script, to identify individuals which questionable maps that require closer, manual assessment. Errors were common in underpowered contrasts of the feedback phase, such that events <3 resulted in problematic contrasts (which is to be expected). First, Statistical maps were thresholded and converted and bined, to make a easier comparisions of arrays between subjects. The first script [2.1] compared second level maps of individuals, converting the thresholded (p < .05) binned map into an array, comparing voxels between subjects, as: the percent overlap between any two activation maps is defined from a set theoretical point of view, where the overlap J(A,B) is defined by the well-known relation as: J(A,B)=(A∩B)/(A+B-A∩B). Script [2.2] allowed the comparison at the thresholded group level (p<.001), the relation calculates the ratio of common pixels that are activated across two activation maps to the total number of pixels present in the two maps.

Subfolder [Aim2_ROI_Associations] contains script [1] used for creating mean signal intensity values for the regions of interest (provided in subfoler ROI_nii_user), and [1.2] combining values into a single combined .csv to be used in subsequence stages of analyses (see *.Rmd code).

Subfolder [Aim3_ROI_Beh] includes script (Bayes Jasp) used in generating the bayes estimates between brain (8 roi's by 10 contrasts X behavior (5)). These estimates are plotted using the Bayes-Be Forestplots.R script. Further, for convergence, provide R code used for obtained comparable bootstrapped values between ROI-Beh.

Additional information can be obtain by contain the authors:
Michael Demidenko, demidenm@umich.edu




