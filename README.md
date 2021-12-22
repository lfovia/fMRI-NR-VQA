# fMRI-NR-VQA

Evaluation of No Reference Video Quality Assessment using fMRI voxel models of Alex-Net.

This is the code for our paper VIDEO QUALITY PREDICTION USING VOXEL-WISE MODELS OF THE VISUAL CORTEX. In this repository, we provide code for training the voxel models and testing them for the no reference video quality prediction.

If you find our work useful in your research, please cite the following paper

N. S. Mahankali, M. Raghavan and S. S. Channappayya, "No-Reference Video Quality Assessment Using Voxel-wise fMRI Models of the Visual Cortex," in IEEE Signal Processing Letters, doi: 10.1109/LSP.2021.3136487.
   
The fMRI data-set can be downloaded from  https://crcns.org/data-sets/vc/vim-2.


Data processing steps:
 
 Split the training and test videos into segments and then extract the frames of these segments using "video_preprocessing.m".
 
 The ground truth fMRI data can be processed using  "fmri_data_processing.m".
 
 Features are extracted using "AlexNet_feature_extraction.py".
 
 These features are processed for dimensionality reduction using "AlexNet_feature_processing_encoding.m".
 
 Using these dimensionality reduced features encode the voxel for all the three subjects using "encode.m".
 
 You can predict the voxel responses of new videos using "predict_response.m".
    
 The NIQE scores can be computed using the official release which is included here.
 
 The Spatial index and Temporal index of a video can be computed using "SITI.m".
 
 Compute the temporal curvature features with "curvature.m" and "curvature_16roi.m".
 
 Find the quality sore and its correlation with mos uaing "fMRI_NR_VQA.m".
