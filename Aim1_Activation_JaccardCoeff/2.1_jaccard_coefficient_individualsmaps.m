all_subjs = dir('/nfs/turbo/ahrb-data/FSL_Analysis/models/mid_anticipation');
folder_path = all_subjs.folder;

num_of_subjs = 104;
num_of_maps = 10; 

all_subj_results_similarity = [];
all_subjs_results_distance = [];
for subjID = 1:num_of_subjs
    concatenated = [];
    for mapID = 1:num_of_maps
        subjs_path = all_subjs(subjID+2).name;
        search_path = [folder_path '/' subjs_path '/model/SecondLevel/PE_second.gfeat/cope' num2str(mapID) '.feat/stats/zstat1_thresh_bin.nii.gz'];
        ind_subj_vol = load_nifti(search_path);
        individual_maps = ind_subj_vol.vol;
        individual_maps = reshape(individual_maps,size(individual_maps,1),size(individual_maps,2)*size(individual_maps,3));
        concatenated = cat(3,concatenated,individual_maps);
    end
    overlap_matrix_similarity = zeros(size(concatenated,3));
    overlap_matrix_distance = zeros(size(concatenated,3));
    for i = 1:size(overlap_matrix_similarity,2)
        for j = 1:size(overlap_matrix_distance,2)     
            intersected_image = sum(sum((bitand(concatenated(:,:,i),concatenated(:,:,j)))));             %%Find intersection of A&B as a logical AND between two binarized images 
            union_image = sum(sum(concatenated(:,:,i)))+sum(sum(concatenated(:,:,j)))-intersected_image; %%Find union of A&B
            jaccard_similarity = intersected_image/union_image;      %% Jaccard similarity
            jaccard_distance = 1-jaccard_similarity; 
            overlap_matrix_similarity(i,j) = jaccard_similarity;
            overlap_matrix_distance(i,j) = jaccard_distance;
        end          
    end
   all_subj_results_similarity(:,:,subjID) = cat(3,overlap_matrix_similarity);
   all_subj_results_distance(:,:,subjID) = cat(3,overlap_matrix_distance);
end


for i = 1:10
    for j = 1:10
        [pe(i,j), lb(i,j), ub(i,j)] = bootstrap_ci(all_subj_results_similarity(i,j,:),0.05,5000,'bootnorm');
    end
end

