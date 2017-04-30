clc
clear

v_nb_of_corespondencesfreak=[];
v_repeatabilityfreak=[];
recallfreak=[];
precisionfreak=[];
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
[featuresoriginalfreak,validptsoriginalfreak]=extractFeatures(original,points1,'Method','FREAK');
[featuresdistortedfreak,validptsdistortedfreak]=extractFeatures(distorted,points2,'Method','FREAK');
aa=0.02;
img1freak=[region1(:,1) region1(:,2) validptsoriginalfreak.Scale*aa zeros(size(region1,1),1) validptsoriginalfreak.Scale*aa double(featuresoriginalfreak.Features)];
img2freak=[region2(:,1) region2(:,2) validptsdistortedfreak.Scale*aa zeros(size(region2,1),1) validptsdistortedfreak.Scale*aa double(featuresdistortedfreak.Features)];

p1 = [64;size(img1freak,1)];
p2 = [64;size(img2freak,1)];
q1 = double(img1freak);
q2 = double(img2freak);
save('img1freak.txt','p1','q1','-ascii')
save('img2freak.txt','p2','q2','-ascii')
H=importdata(strcat('E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\',num2str(i),'.txt'));
[v_overlap, v_repeatability, v_nb_of_corespondences,matching_score,nb_of_matches,twi] = repeatability('img1freak.txt', 'img2freak.txt',H, 'E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\1.jpg',strcat('E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\',str,'.jpg'),0);
v_nb_of_corespondencesfreak=[v_nb_of_corespondencesfreak v_nb_of_corespondences];
v_repeatabilityfreak=[v_repeatabilityfreak v_repeatability];
% % [v_overlap,v_repeatability,v_nb_of_corespondences,matching_score,nb_of_matches,twi] = repeatability('img1.haraff.sift','img2.haraff.sift','H1to2p','img1.ppm','img2.ppm',0);
[correct_match_nn,total_match_nn,correct_match_sim,total_match_sim,correct_match_rn,total_match_rn,recall,precision] = descperf('img1freak.txt','img2freak.txt',H,'E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\1.jpg',strcat('E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\',str,'.jpg'),v_nb_of_corespondences,twi);
recallfreak=[recallfreak;recall]; 
precisionfreak=[precisionfreak;precision];
% % figure 
plot(precision,recall)
 end
 
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','v_nb_of_corespondencesfreak.mat'],'v_nb_of_corespondencesfreak')
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','v_repeatabilityfreak.mat'],'v_repeatabilityfreak')
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','recallfreak.mat'],'recallfreak')
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','precisionfreak.mat'],'precisionfreak')