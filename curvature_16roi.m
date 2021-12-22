%%%%%% computing the curvature and difference features for the 16 RoI
%%%%%% of the visual cortex using the selected subset of 1500 voxels
clc;
clear;
close all;

for sub=1:3
    video_list = dir('path/to/videos/folder');
    len1 = length(video_list);
    
    load([active_voxels_sub',num2str(sub),'.mat'],'k','s');
    vox=vox(1:100,:);
    [a,b]=hist(vox,unique(vox));
    id=b;
    roi=s(id);                      % selecting the 1500 voxel subset
    
    % % %%% The 16 Regions of Interest (RoI) of the visual cortex
    
    reg={'v1lh','v2lh','v3lh','v4lh','MTlh','v3alh','v3blh','latocclh','v1rh','v2rh','v3rh','v4rh','MTrh','v3arh','v3brh','latoccrh'};
    
    cur_full=cell(length(reg),len1);
    dif1=cell(length(reg),len1);
    dif2=cell(length(reg),len1);
    ii=1;
    for r=1:length(reg)
        
        f=find(strcmp(roi,reg{r})==1);
        id=vox(f);                      % selecting voxels of the specified RoI
        
        for j=1:len1
            video_name=video_list(j);
            load(['/path/to/predicted/responses/sub',num2str(sub),'/',video_name,'.mat'],'X');
            X=X(:,id);
            
            f=find(all(isnan(X),1));
            X(:,f)=[];
            f=find(std(X)==0);
            X(:,f)=[];
            
            X(isnan(X))=0;
            s=size(X);
            len=s(1)-1;
            x1=zeros(s);
            temp=1:len;
            len=length(temp);
            for i=1:len-1
                
                f1=X(temp(i),:);
                f2=X(temp(i+1),:);
                x1(i,:)=abs(f1-f2);
                x1(i,:)=x1(i,:)/norm(x1(i,:));
                
            end
            
            f=find(all(isnan(x1),1));
            x1(:,f)=[];
            x1(isnan(x1))=0;
            f=find(std(x1)==0);
            x1(:,f)=[];
            len=nnz(x1(:,1));
            cur1=zeros(len-1,1);
            for i=1:len-1
                cur1(i)=acosd(x1(i,:)*x1(i+1,:)');
            end
            cur_full{r,j}=cur1;             % curvature feature vector
            dif1{r,j}=mean(diff(x1,1),2);   % first difference feature vector
            dif2{r,j}=mean(diff(x1,2),2);   % second difference feature vector
        end
    end
    % end
    save([''/path/to/dataset/sub',num2str(sub),'_16roi_diff.mat'],'cur_full','dif1','dif2');
end
