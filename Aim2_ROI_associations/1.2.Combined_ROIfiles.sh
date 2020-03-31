#!/bin/bash

############################### subject combining .txt files loop script ################################### 



proj=/nfs/turbo/ahrb-data
model=$proj/FSL_Analysis/models/mid_anticipation
out=$proj/Demidenko/MID_contrastcomp/output/roi




  
########################### Do Not Edit Below This Line ############################### 


for subj in $(cat $1 ) ; do

masktxt="./cope1.feat/${subj}_cope1_ROImean.csv
./cope2.feat/${subj}_cope2_ROImean.csv
./cope3.feat/${subj}_cope3_ROImean.csv
./cope4.feat/${subj}_cope4_ROImean.csv
./cope5.feat/${subj}_cope5_ROImean.csv
./cope6.feat/${subj}_cope6_ROImean.csv
./cope7.feat/${subj}_cope7_ROImean.csv
./cope8.feat/${subj}_cope8_ROImean.csv
./cope9.feat/${subj}_cope9_ROImean.csv
./cope10.feat/${subj}_cope10_ROImean.csv"
	
	cd $model/$subj/model/SecondLevel/PE_second.gfeat/

	paste ${masktxt} > $out/${subj}.csv 

done

