clc
clear
v_nb_of_corespondencesh=[];
v_repeatabilityh=[];
aa1=1;
alpha=0.04;
 for i=2:1:6
    str=num2str(i);
    original=imread('E:\MyResearch\paper\image\detector\Colles\view\1.PNG');
    distorted=imread(strcat('E:\MyResearch\paper\image\detector\Colles\view\',str,'.PNG'));
    if length(size(original))==3 ||length(size(distorted))==3
        original1=im2double(rgb2gray(original));
         distorted1=im2double(rgb2gray(distorted));
    end
    %% 

    [descriptors1, locs1]=sift(original);
    [descriptors2, locs2]=sift(distorted);
    region11=round([locs1(:,2) locs1(:,1)]);
    region22=round([locs2(:,2) locs2(:,1)]);
    H = testhomog_vgg(original,distorted,region11,region22);
    %% 
    
%     points1=detectHarrisFeatures(original);
%     points2=detectHarrisFeatures(distorted);
%     region1=double(round(points1.Location));
%     region2=double(round(points2.Location));
%% 
    region1=harris(original1,alpha);
    region2=harris(distorted1,alpha);
    img1harris=[region1(:,1) region1(:,2) ones(size(region1,1),1).*aa1 zeros(size(region1,1),1) ones(size(region1,1),1).*aa1 ];
    img2harris=[region2(:,1) region2(:,2) ones(size(region2,1),1).*aa1 zeros(size(region2,1),1) ones(size(region2,1),1).*aa1 ];
    p1 = [1.0;size(img1harris,1)];
    p2 = [1.0;size(img2harris,1)];
    q1 = img1harris;
    q2 = img2harris;
    save('img1harris.txt','p1','q1','-ascii')
    save('img2harris.txt','p2','q2','-ascii')

%   H = testhomog_vgg(original,distorted,img1harris,img2harris);


    save(['E:\MyResearch\paper\image\detector\Colles\view\',strcat(str,'.txt')],'H','-ascii')
%   H=importdata(strcat('E:\MyResearch\paper\image\detector\Colles\view\',num2str(i),'.txt'));
    [v_overlap, v_repeatability, v_nb_of_corespondences,matching_score,nb_of_matches] = repeatability('img1harris.txt', 'img2harris.txt',H, 'E:\MyResearch\paper\image\detector\Colles\view\1.PNG',strcat('E:\MyResearch\paper\image\detector\Colles\view\',str,'.PNG'),1);
    v_nb_of_corespondencesh=[v_nb_of_corespondencesh v_nb_of_corespondences];
    v_repeatabilityh=[v_repeatabilityh v_repeatability];
% % [v_overlap,v_repeatability,v_nb_of_corespondences,matching_score,nb_of_matches,twi] = repeatability('img1.haraff.sift','img2.haraff.sift','H1to2p','img1.ppm','img2.ppm',0);
% % [correct_match_nn,total_match_nn,correct_match_sim,total_match_sim,correct_match_rn,total_match_rn] = descperf('img1.haraff.sift','img2.haraff.sift','H1to2p','img1.ppm','img2.ppm',v_nb_of_corespondences(5),twi);
% % figure 
% display_features('img1harris.txt', '30.PNG',1,1) 
% figure
% plot(v_overlap,v_repeatability);
 end
save(['E:\MyResearch\paper\image\detector\Colles\view\','v_nb_of_corespondencesh2_6.mat'],'v_nb_of_corespondencesh')
save(['E:\MyResearch\paper\image\detector\Colles\view\','v_repeatabilityh2_6.mat'],'v_repeatabilityh')
