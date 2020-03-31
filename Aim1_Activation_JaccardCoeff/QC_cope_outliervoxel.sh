#!/bin/bash

################# QC zstat masks #################

# Purpose: Generate a percentage overlap between binarized zstat mask produced by FSL feat gui and that general mask. z-stat for each cope should be similar across each contrast, if not, suggests systematic problems within that cope calculation -- view w/ fsleyes if concerning

###################################################################

# directory

dir=/nfs/turbo/ahrb-data/FSL_Analysis/models/mid_anticipation




for subj in $(cat $1) ; do
echo "Starting $subj .........."
	
	# navigate to subjects folder
	cd $dir/$subj/model/SecondLevel/PE_second.gfeat

	for cope in 1 2 3 4 5 6 7 8 9 10 ; do 
	# calculates standard deviation (-S)
	stdev=$(fslstats cope${cope}.feat/stats/zstat1.nii.gz -S)
	stdev10=$(echo "scale=4; 10*$stdev" | bc)

	# calculates min/max
	min=$(fslstats cope${cope}.feat/stats/zstat1.nii.gz -R | awk '{ print $1 }' )
	max=$(fslstats cope${cope}.feat/stats/zstat1.nii.gz -R | awk '{ print $2 }' )


	# If stdev*10 is NOT greater than maximum signal intensity value, echo subject/cope that does not conform to rule
	if (( $(echo "$stdev10 < $max" | bc -l) )) ; then
	echo  "$subj cope${cope} max intensity (${max}) is greater than stdev (${stdev})"  
	fi
	sleep 1
	
	done
done


