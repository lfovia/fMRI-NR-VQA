# fMRI-NR-VQA

Evaluation of No Reference Video Quality Assessment using fMRI voxel models of Alex-Net.

This is the code for our paper VIDEO QUALITY PREDICTION USING VOXEL-WISE MODELS OF THE VISUAL CORTEX. In this repository, we provide code for training the voxel models and testing them for the no reference video quality prediction.

If you find our work useful in your research, please cite the following paper

N. S. Mahankali, M. Raghavan and S. S. Channappayya, "No-Reference Video Quality Assessment Using Voxel-wise fMRI Models of the Visual Cortex," in IEEE Signal Processing Letters, doi: 10.1109/LSP.2021.3136487.
   
The fMRI data-set can be downloaded from  https://crcns.org/data-sets/vc/vim-2.


# Data processing steps:
 
 1.  Split the training and test videos into segments and then extract the frames of these segments using "video_preprocessing.m".
 
 2.  The ground truth fMRI data can be processed using  "fmri_data_processing.m".
 
 3.  Features are extracted using "AlexNet_feature_extraction.py".
 
 4. These features are processed for dimensionality reduction using "AlexNet_feature_processing_encoding.m". The svd matrices computed over the vim-2 dataset are used for the dimensionality reduction of the features of all the other datasets. The precomputed svd matrices can be downloaded from [here](https://drive.google.com/drive/folders/1ze305Xzd-0Db-H6-_N6n_V3QdXor9i9v?usp=sharing). 
 
 5. Using these dimensionality reduced features, encode the voxel models for all the three subjects using "encode.m". Our pretrained voxel models on Vim-2 dataset can be downloaded from our [drive](https://drive.google.com/drive/folders/10oloKHJSG9qHazv1Gr78S4kzmG_V-4vh?usp=sharing).
 
 6.  You can predict the voxel responses of new videos using "predict_response.m".
    
 7.  The NIQE scores can be computed using the official release which is included here.
 
 8.  The Spatial index and Temporal index of a video can be computed using "SITI.m".
 
 9.  Compute the temporal curvature features with "curvature.m" and "curvature_16roi.m".
 
 10.  Find the quality sore and its correlation with mos uaing "fMRI_NR_VQA.m".
