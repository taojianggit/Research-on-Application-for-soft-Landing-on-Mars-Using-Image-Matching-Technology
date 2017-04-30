clc
clear

v_nb_of_corespondencessu=[];
v_repeatabilitysu=[];
recallsu=[];
precisionsu=[];
 for i=2:1:6

    str=num2str(i);
    original=imread('E:\MyResearch\paper\image\descriptor\Colles\view\1.PNG');
    distorted=imread(strcat('E:\MyResearch\paper\image\descriptor\Colles\view\',str,'.PNG'));
% ptsoriginalmser  = detectMSERFeatures(rgb2gray(original));
% ptsdistortedmser = detectMSERFeatures(rgb2gray(distorted));
%  a=[ptsoriginalmser.Location ptsoriginalmser.Axes ptsoriginalmser.Orientation  ];
%  b=[ptsdistortedmser.Location ptsdistortedmser.Axes  ptsdistortedmser.Orientation];
% 
 aa=1;
if length(size(original))==3&&length(size(distorted))==3
    original=im2double(rgb2gray(original));
    distorted=im2double(rgb2gray(distorted));
end
% points1=detectSURFFeatures(original);
% points2=detectSURFFeatures(distorted);
% 
% [featuresoriginalsurf,validptsoriginalsurf]=extractFeatures(original,points1);
% [featuresdistortedsurf,validptsdistortedsurf]=extractFeatures(distorted,points2);
% 
% loc1=points1.Location;
% S1=points1.Scale;
% O1=validptsoriginalsurf.Orientation;
% loc2=points2.Location;
% S2=points2.Scale;
% O2=validptsdistortedsurf.Orientation;
region1=importdata('E:\MyResearch\paper\image\descriptor\Colles\view\vsimage\akaze1.txt');%txt file should change all semicolon into comma; or change all comma into semicolon
region2=importdata(strcat('E:\MyResearch\paper\image\descriptor\Colles\view\vsimage\akaze',str,'.txt'));
points1 = SURFPoints(region1) ;
points2 = SURFPoints(region2) ;
[featuresoriginalsurf,validptsoriginalsurf]=extractFeatures(original,points1);
[featuresdistortedsurf,validptsdistortedsurf]=extractFeatures(distorted,points2);
img1surf=[region1(:,1) region1(:,2) ones(size(region1,1),1).*aa zeros(size(region1,1),1) ones(size(region1,1),1).*aa featuresoriginalsurf];
img2surf=[region2(:,1) region2(:,2) ones(size(region2,1),1).*aa zeros(size(region2,1),1) ones(size(region2,1),1).*aa featuresdistortedsurf];


p1 = [64;size(img1surf,1)];
p2 = [64;size(img2surf,1)];
q1 = double(img1surf);
q2 = double(img2surf);
save('img1surf.txt','p1','q1','-ascii')
save('img2surf.txt','p2','q2','-ascii')
H=importdata(strcat('E:\MyResearch\paper\image\descriptor\Colles\view\',num2str(i),'.txt'));
[v_overlap, v_repeatability, v_nb_of_corespondences,matching_score,nb_of_matches,twi] = repeatability('img1surf.txt', 'img2surf.txt',H, 'E:\MyResearch\paper\image\descriptor\Colles\view\1.PNG',strcat('E:\MyResearch\paper\image\descriptor\Colles\view\',str,'.PNG'),0);
v_nb_of_corespondencessu=[v_nb_of_corespondencessu v_nb_of_corespondences];
v_repeatabilitysu=[v_repeatabilitysu v_repeatability];
% % [v_overlap,v_repeatability,v_nb_of_corespondences,matching_score,nb_of_matches,twi] = repeatability('img1.haraff.sift','img2.haraff.sift','H1to2p','img1.ppm','img2.ppm',0);
[correct_match_nn,total_match_nn,correct_match_sim,total_match_sim,correct_match_rn,total_match_rn,recall,precision] = descperf('img1surf.txt','img2surf.txt',H,'E:\MyResearch\paper\image\descriptor\Colles\view\1.PNG',strcat('E:\MyResearch\paper\image\descriptor\Colles\view\',str,'.PNG'),v_nb_of_corespondences,twi);
recallsu=[recallsu;recall]; 
precisionsu=[precisionsu;precision];
% % figure 
% display_features('img1harris.txt', '30.PNG',1,1) 
% figure
% plot(v_overlap,v_repeatability);
 end
 
save(['E:\MyResearch\paper\image\descriptor\Colles\view\','v_nb_of_corespondencessu2_6.mat'],'v_nb_of_corespondencessu')
save(['E:\MyResearch\paper\image\descriptor\Colles\view\','v_repeatabilitysu2_6.mat'],'v_repeatabilitysu')
save(['E:\MyResearch\paper\image\descriptor\Colles\view\','recallsu2_6.mat'],'recallsu')
save(['E:\MyResearch\paper\image\descriptor\Colles\view\','precisionsu2_6.mat'],'precisionsu')