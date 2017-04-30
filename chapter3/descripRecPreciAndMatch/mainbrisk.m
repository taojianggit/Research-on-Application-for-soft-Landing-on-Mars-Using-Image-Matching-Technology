clc
clear

v_nb_of_corespondencesbrisk=[];
v_repeatabilitybrisk=[];
recallbrisk=[];
precisionbrisk=[];
 for i=2
    str=num2str(i);
    original=imread('E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\1.jpg');
    distorted=imread('E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\2.jpg');

if length(size(original))==3&&length(size(distorted))==3
    original=im2double(rgb2gray(original));
    distorted=im2double(rgb2gray(distorted));
end

region1=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\pts1.txt');%txt file should change all semicolon into comma; or change all comma into semicolon
region2=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\pts2.txt');
size1=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\kpts1size.txt');
size2=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\kpts2size.txt');
points1 = BRISKPoints(region1,'Scale',size1) ;
points2 = BRISKPoints(region2,'Scale',size2) ;
[featuresoriginalbrisk,validptsoriginalbrisk]=extractFeatures(original,points1,'Method','BRISK');
[featuresdistortedbrisk,validptsdistortedbrisk]=extractFeatures(distorted,points2,'Method','BRISK');
% img1brisk=[region1(:,1) region1(:,2) ones(size(region1,1),1).*aa zeros(size(region1,1),1) ones(size(region1,1),1).*aa double(featuresoriginalbrisk.Features)];
% img2brisk=[region2(:,1) region2(:,2) ones(size(region2,1),1).*aa zeros(size(region2,1),1) ones(size(region2,1),1).*aa double(featuresdistortedbrisk.Features)];
aa=0.02;
img1brisk=[region1(:,1) region1(:,2) validptsoriginalbrisk.Scale*aa zeros(size(region1,1),1) validptsoriginalbrisk.Scale*aa double(featuresoriginalbrisk.Features)];
img2brisk=[region2(:,1) region2(:,2) validptsdistortedbrisk.Scale*aa zeros(size(region2,1),1) validptsdistortedbrisk.Scale*aa double(featuresdistortedbrisk.Features)];

p1 = [64;size(img1brisk,1)];
p2 = [64;size(img2brisk,1)];
q1 = double(img1brisk);
q2 = double(img2brisk);
save('img1brisk.txt','p1','q1','-ascii')
save('img2brisk.txt','p2','q2','-ascii')
H=importdata(strcat('E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\',num2str(i),'.txt'));
[v_overlap, v_repeatability, v_nb_of_corespondences,matching_score,nb_of_matches,twi] = repeatability('img1brisk.txt', 'img2brisk.txt',H, 'E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\1.jpg',strcat('E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\',str,'.jpg'),0);
v_nb_of_corespondencesbrisk=[v_nb_of_corespondencesbrisk v_nb_of_corespondences];
v_repeatabilitybrisk=[v_repeatabilitybrisk v_repeatability];
% % [v_overlap,v_repeatability,v_nb_of_corespondences,matching_score,nb_of_matches,twi] = repeatability('img1.haraff.sift','img2.haraff.sift','H1to2p','img1.ppm','img2.ppm',0);
[correct_match_nn,total_match_nn,correct_match_sim,total_match_sim,correct_match_rn,total_match_rn,recall,precision] = descperf('img1brisk.txt','img2brisk.txt',H,'E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\1.jpg',strcat('E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\',str,'.jpg'),v_nb_of_corespondences,twi);
recallbrisk=[recallbrisk;recall]; 
precisionbrisk=[precisionbrisk;precision];
% % figure 
% display_features('img1harris.txt', 'E:\MyResearch\paper\image\descriptor\Colles\rotate\1.jpg',1,1) 
figure
plot(precision,recall);
 end
 
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','v_nb_of_corespondencesbrisk.mat'],'v_nb_of_corespondencesbrisk')
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','v_repeatabilitybrisk.mat'],'v_repeatabilitybrisk')
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','recallbrisk.mat'],'recallbrisk')
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','precisionbrisk.mat'],'precisionbrisk')