#!/bin/bash

################# Creating Thresholded maps from Cope  zstat outfile form Feat #################

# Purpose: Creating a binarized imaged (thresholded at p = .01 (z = 2.3) to create a binarized image that can be compared via Jaccards coefficient to define similarity between contrasts

###################################################################

# directory

dir=/nfs/turbo/ahrb-data/FSL_Analysis/models/mid_anticipation

#zstat/tstat name, e.g. zstat1.nii.gz, provide zstat1
zstat=zstat1_inv




for subj in $(cat $1) ; do
	echo "### ${subj} ###"
	for cope in {1..10} ; do
	echo "	Starting cope $cope ..."
	# Thresholding mask for every cope to generate activation map at p = .01 (z-statistic 2.3)
	fslmaths $dir/$subj/model/SecondLevel/PE_second.gfeat/cope${cope}.feat/stats/${zstat}.nii.gz -thr 2.3 \
		$dir/$subj/model/SecondLevel/PE_second.gfeat/cope${cope}.feat/stats/${zstat}_thresholded.nii.gz

	# Binarizing the image (1 vs 0) for voxels that are present (at equal/greater than 2.3 / p = .01 )
	fslmaths $dir/$subj/model/SecondLevel/PE_second.gfeat/cope${cope}.feat/stats/${zstat}_thresholded.nii.gz -bin \
		$dir/$subj/model/SecondLevel/PE_second.gfeat/cope${cope}.feat/stats/${zstat}_thresh_bin.nii.gz

	# deleting redundant thresholded file to conserve space
	rm $dir/$subj/model/SecondLevel/PE_second.gfeat/cope${cope}.feat/stats/${zstat}_thresholded.nii.gz
	echo "		... done "
	echo
	done

done


