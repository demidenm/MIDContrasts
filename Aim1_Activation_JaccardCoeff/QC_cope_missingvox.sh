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
	# multiply zstat files to get all positive values, to bin values using above 0 (via -bin)
	fslmaths cope${cope}.feat/stats/zstat1.nii.gz -mul cope${cope}.feat/stats/zstat1.nii.gz cope${cope}.feat/stats/zstat1_work.nii.gz  
	
	#binarize massk created above
	fslmaths cope${cope}.feat/stats/zstat1_work.nii.gz -bin cope${cope}.feat/stats/zstat1_bin.nii.gz 

	# subtract subject specific mask.nii.gz created by feat and the tstat mask above (to get different value)
	fslmaths cope${cope}.feat/mask.nii.gz -sub cope${cope}.feat/stats/zstat1_bin.nii.gz cope${cope}.feat/stats/zstat1_sub.nii.gz

	# get percent difference between shouldn't vary more than > 00.8% -- cope files should be similar.
	percent=$(fslstats cope${cope}.feat/stats/zstat1_sub.nii.gz -m )
	
	echo "	Cope${cope}.feat Percent = $percent " 
	sleep 1
	
	#remove files to save on space
	rm cope${cope}.feat/stats/zstat1_work.nii.gz
	rm cope${cope}.feat/stats/zstat1_bin.nii.gz
	rm cope${cope}.feat/stats/zstat1_sub.nii.gz
	done
done


