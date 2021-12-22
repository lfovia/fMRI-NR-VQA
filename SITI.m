%%%%% Computing the Spatial Index and the Temporal Index of the videos %%%%% 

clc;
clear ;
close all;

dataroot = '/path/to/data-set/'; % this is the path to dataset folder where the  videos are preset
d = dir([dataroot,'Video/*.mp4']);
l = length(d);
ViSI = zeros(l,1);
ViTI = zeros(l,1);
for i=1:l
    
    name=([dataroot,'Video/',d(i).name]);
    Vi=VideoReader(name);
    ViRead=read(Vi);
    s=size(ViRead);
    
    ViStd = zeros(1,size(ViRead,4));
    
    for j=1:size(ViRead,4)
        ViFrame=double(rgb2gray(reshape(ViRead(:,:,:,j),[s(1),s(2),s(3)])));
        ViSobel = edge(ViFrame,'Sobel');
        ViStd(1,j)=std(ViSobel(:)); % Spatial Index of j_th frame of the video
    end
    ViSI(i,1)=max(ViStd(:)); % Overall Spatial Index of the video
    
    TiStd = zeros(1,size(ViRead,4)-1);
    
    for j=1:size(ViRead,4)-1
        ViFrame1=double(rgb2gray(reshape(ViRead(:,:,:,j),[s(1),s(2),s(3)])));
        ViFrame2=double(rgb2gray(reshape(ViRead(:,:,:,j+1),[s(1),s(2),s(3)])));
        ViFrame=ViFrame2-ViFrame1;
        TiStd(1,j)=std(ViFrame(:)); 
    end
    ViTI(i,1)=max(TiStd(:)); % Overall Temporal Index of the video
    disp(num2str(i))
    
    % Saving a separate mat file for each video with SI and TI of each frame
    
    m=matfile(sprintf([dataroot,'siti/',d(i).name,'.mat']),'writable',true);
    m.ViSI=ViStd;
    m.ViTI=TiStd;
end
% Saving the mat file with SI and TI of all the videos in the data-set

m=matfile(sprintf('/path/to/dataset/SITI.mat'),'writable',true);
m.SI=ViSI;
m.TI=ViTI;
