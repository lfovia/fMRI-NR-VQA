%%%%%% Finding the correlation of the quality score computed using the
%%%%%% three combinations of the feature vectors 

clc;
clear;
close all;

addpath('/home/sailaja/backup/desktop');
sub=1                   % specify the identity of the subject

% % load the curvature and difference features computed for the dataset for
% % the given subject

load(['/path/to/dataset/sub',num2str(sub),'_16roi_diff.mat'],'cur_full','dif1','dif2');
l=load(['/path/to/dataset/sub',num2str(sub),'_cur_full_diff.mat'],'cur_full','dif1','dif2');

% % load the niqe, SI, TI and MOS scores of the data-set

load(['/path/to/dataset/mos_file'],'mos');
load(['/path/to/dataset/niq.mat'],'niq');
load(['/path/to/dataset/SITI.mat'],'SI','TI');
niq=cellfun(@(c) fillmissing(c,'constant',0), niq,'UniformOutput',false);
niq1=cellfun(@mean,niq)';
niq1(isnan(niq1))=0;
temp_niq=[];

dist=((vertcat((cellfun(@mean,cur_full)),(cellfun(@mean,dif1)),(cellfun(@mean,dif2))))');
dist1=((vertcat((cellfun(@mean,cur_full)),(cellfun(@mean,dif1)),(cellfun(@mean,dif2)),cellfun(@mean,niq),SI',TI'))');
dist2=((vertcat((cellfun(@mean,l.cur_full)),(cellfun(@mean,l.dif1)),(cellfun(@mean,l.dif2)),cellfun(@mean,niq),SI',TI'))');

no_of_iterations = 100;
TrainRatio = 0.8;
TestRatio = 0.2;
ValidationRatio = 0;
cor48=[];
cor51=[];
cor6=[];
cor_niq=[];
model48={};
model51={};
model6={};
dmos=mos;
for iter = 1:no_of_iterations
    iter
    [trainInd,valInd,testInd] = dividerand(size(dist,1),TrainRatio,ValidationRatio,TestRatio);
    mos_cap = dmos(testInd);
    mdl = fitrsvm(dist(trainInd,:),dmos(trainInd),'KernelFunction','rbf','KernelScale','auto','Standardize',true,'CacheSize','maximal');
    y_cap = predict(mdl,dist(testInd,:));
    y_cap(isnan(y_cap))=0;
    cor48(iter,:) = calculatepearsoncorr(y_cap,mos_cap);
    model48{iter}=mdl;
    
    mdl = fitrsvm(dist1(trainInd,:),dmos(trainInd),'KernelFunction','rbf','KernelScale','auto','Standardize',true,'CacheSize','maximal');
    y_cap = predict(mdl,dist1(testInd,:));
    y_cap(isnan(y_cap))=0;
    cor51(iter,:) = calculatepearsoncorr(y_cap,mos_cap);
    model51{iter}=mdl;
    
    mdl = fitrsvm(dist2(trainInd,:),dmos(trainInd),'KernelFunction','rbf','KernelScale','auto','Standardize',true,'CacheSize','maximal');
    y_cap = predict(mdl,dist2(testInd,:));
    y_cap(isnan(y_cap))=0;
    cor6(iter,:) = calculatepearsoncorr(y_cap,mos_cap);
    cor_niq(iter,:) = calculatepearsoncorr(niq1(testInd),mos_cap);
    model6{iter}=mdl;
    
    median(cor48)
    median(cor51)
    median(cor6)
end