#!/bin/bash

# 			[This script was created by Michael Demidenko © 2019]
# The function of this script is to use the zstat, preprocessed, files from fsl provided and pull a mean signal intensity for a specified list of ROIs.
# The scripts utilizes fslmeants, whereby an input image '-i' (e.g. zstat file) is masked with a binarized 3D mask '-m', and outputs the mean .txt into a mean_roi (which the script creates) subfolder in the location of the 4D input image provided '-o'.
# Subsequent to this script, please run 3_ROI_meanROI.sh to get list of each subjects mean_ROI


#Please modify the project direction, location of your masks, and output file for paths of mean intensity values created to be used in next script	
	proj=/nfs/turbo/ahrb-data
	model=$proj/FSL_Analysis/models/mid_anticipation
	mask=$proj/Demidenko/MID_contrastcomp/scripts/roi
	output=$proj/Demidenko/HighLowRisk_Analyses/roi_output/Neurosynth_mean_ROI.csv


	

# Do Not Alter Values below this field, unless necessary.



echo "This script requires input of Regions of Interest mask file names ."
echo "Please provide a list with these subject list."
echo " 		example:  ./2.1_ROI_meanROI.sh <subject.txt> "
echo "These must be updated in the script; if not have done so, please end and update"
sleep 2
echo

#echo -e #"subject\tNS_Left_VS\tNS_Right_VS\tNS_Left_Amygdala\tNS_Right_Amygdala\tNS_Left_dlPFC\tNS_Right_dlPFC\tNS_Left_OFC\tNS_Right_OFC\tNS_Left_Insula\tNS_Right_Insula\tNS_Left_PPC\tNS_Right_PPC\tNS_vmPFC\tNS_ACC" > $output


for subj in $(cat $1 ) ; do
echo "## Beginning $subj"	
	for cope in 1 2 3 4 5 6 7 8 9 10 ; do
		#echo "" > $model/$subj/model/SecondLevel/PE_second.gfeat/cope${cope}.feat/${subj}_cope${cope}_ROImean.csv
		#create a empty list or array
		# (ignore) sc=subject contents. The first element in array is subject id
			sc=()
			#sc=("$subj")	
		
		for roi in ACC vmPFC L_Insula R_Insula L_OFC R_OFC L_VS R_VS ; do

			sc+=$(fslmeants -i $model/$subj/model/SecondLevel/PE_second.gfeat/cope${cope}.feat/stats/zstat1.nii.gz -m $mask/${roi}.nii.gz)

		done 

	#add each element in to tab-delimited field on a row 
		echo ${sc[@]}
		echo "${sc[0]} ${sc[1]} ${sc[2]} ${sc[3]} ${sc[4]} ${sc[5]} ${sc[6]} ${sc[7]}" > $model/$subj/model/SecondLevel/PE_second.gfeat/cope${cope}.feat/${subj}_cope${cope}_ROImean.csv
	done
	

done






