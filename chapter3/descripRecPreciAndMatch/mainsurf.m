clc
clear

v_nb_of_corespondencessu=[];
v_repeatabilitysu=[];
recallsu=[];
precisionsu=[];
 for i=2

    str=num2str(i);
    original=imread('E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\1.jpg');
    distorted=imread(strcat('E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\',str,'.jpg'));
% ptsoriginalmser  = detectMSERFeatures(rgb2gray(original));
% ptsdistortedmser = detectMSERFeatures(rgb2gray(distorted));
%  a=[ptsoriginalmser.Location ptsoriginalmser.Axes ptsoriginalmser.Orientation  ];
%  b=[ptsdistortedmser.Location ptsdistortedmser.Axes  ptsdistortedmser.Orientation];
% 
 
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
region1=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\pts1.txt');%txt file should change all semicolon into comma; or change all comma into semicolon
region2=importdata(strcat('E:\MyResearch\paper\image\descriptor\Colles\rotate\pts2.txt'));

size1=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\kpts1size.txt');
size2=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\kpts2size.txt');

points1 = SURFPoints(region1,'Scale',size1) ;
points2 = SURFPoints(region2,'Scale',size2) ;

[featuresoriginalsurf,validptsoriginalsurf]=extractFeatures(original,points1);
[featuresdistortedsurf,validptsdistortedsurf]=extractFeatures(distorted,points2);
aa=0.02;
img1surf=[region1(:,1) region1(:,2) points1.Scale*aa zeros(size(region1,1),1) points1.Scale*aa featuresoriginalsurf];
img2surf=[region2(:,1) region2(:,2) points2.Scale*aa zeros(size(region2,1),1) points2.Scale*aa featuresdistortedsurf];


p1 = [64;size(img1surf,1)];
p2 = [64;size(img2surf,1)];
q1 = double(img1surf);
q2 = double(img2surf);
save('img1surf.txt','p1','q1','-ascii')
save('img2surf.txt','p2','q2','-ascii')
H=importdata(strcat('E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\',num2str(i),'.txt'));
[v_overlap, v_repeatability, v_nb_of_corespondences,matching_score,nb_of_matches,twi] = repeatability('img1surf.txt', 'img2surf.txt',H, 'E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\1.jpg',strcat('E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage',str,'.jpg'),0);
v_nb_of_corespondencessu=[v_nb_of_corespondencessu v_nb_of_corespondences];
v_repeatabilitysu=[v_repeatabilitysu v_repeatability];
% % [v_overlap,v_repeatability,v_nb_of_corespondences,matching_score,nb_of_matches,twi] = repeatability('img1.haraff.sift','img2.haraff.sift','H1to2p','img1.ppm','img2.ppm',0);
[correct_match_nn,total_match_nn,correct_match_sim,total_match_sim,correct_match_rn,total_match_rn,recall,precision] = descperf('img1surf.txt','img2surf.txt',H,'E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\1.jpg',strcat('E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage',str,'.jpg'),v_nb_of_corespondences,twi);
recallsu=[recallsu;recall]; 
precisionsu=[precisionsu;precision];
% % figure 
% display_features('img1harris.txt', '30.jpg',1,1) 
 figure
 plot(precision,recall);
 end
 
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','v_nb_of_corespondencessu.mat'],'v_nb_of_corespondencessu')
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','v_repeatabilitysu.mat'],'v_repeatabilitysu')
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','recallsu.mat'],'recallsu')
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','precisionsu.mat'],'precisionsu')