clc
clear

%% region
pts1=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\pts1.txt');
angle1=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\kpts1angle.txt');
size1=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\kpts1size.txt');

pts2=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\pts2.txt');
angle2=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\kpts2angle.txt');
size2=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\kpts2size.txt');


angle1=deg2rad(angle1);
for i=1:size(angle1)
    if angle1(i)>3.1416
        angle1(i)=-(2*pi-angle1(i));
    end
end
angle2=deg2rad(angle2);
for i=1:size(angle2)
    if angle2(i)>3.1416
        angle2(i)=-(2*pi-angle2(i));
    end
end

region1=[pts1 size1 angle1];
region2=[pts2 size2 angle2];
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','region1.mat'],'region1')
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','region2.mat'],'region2')

% extract descriptors
original=imread('E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\1.jpg');
distorted=imread('E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\2.jpg');
if length(size(original))==3&&length(size(distorted))==3
    original=im2double(rgb2gray(original));
    distorted=im2double(rgb2gray(distorted));
end
I1=single(original);
I2=single(distorted);
[~,d1] = vl_sift(I1,'frames',region1') ;
[~,d2] = vl_sift(I2,'frames',region2') ;

save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','sift1.mat'],'d1')
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','sift2.mat'],'d2')
region1=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\region1.mat');%txt file should change all semicolon into comma; or change all comma into semicolon
region2=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\region2.mat');

dsift1=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\sift1.mat');
dsift2=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\sift2.mat');
dsift1=dsift1';
dsift2=dsift2';
% img1sift=[region1(:,1) region1(:,2) ones(size(region1,1),1).*aa zeros(size(region1,1),1) ones(size(region1,1),1).*aa double(dsift1)];
% img2sift=[region2(:,1) region2(:,2) ones(size(region2,1),1).*aa zeros(size(region2,1),1) ones(size(region2,1),1).*aa double(dsift2)];
% img1sift=[region1(:,1) region1(:,2) region1(:,3) zeros(size(region1,1),1) region1(:,3) double(dsift1)];
% img2sift=[region2(:,1) region2(:,2) region2(:,3) zeros(size(region2,1),1) region2(:,3) double(dsift2)];
aa=0.02;
img1sift=[region1(:,1) region1(:,2) region1(:,3)*aa zeros(size(region1,1),1) region1(:,3)*aa double(dsift1)];
img2sift=[region2(:,1) region2(:,2) region2(:,3)*aa zeros(size(region2,1),1) region2(:,3)*aa double(dsift2)];
p1 = [128;size(img1sift,1)];
p2 = [128;size(img2sift,1)];
q1 = double(img1sift);
q2 = double(img2sift);
save('img1sift.txt','p1','q1','-ascii')
save('img2sift.txt','p2','q2','-ascii')
%% dispaly sift descriptors based on akaze detectors

% %   orignal image sift descriptors
%     figure
%     imshow(original) ;
%     perm = randperm(size(region1,2)) ;
%     N1=1;
%     N2=10;
%     sel = perm(N1:N2) ;
%     h1 = vl_plotframe(region1(:,sel)) ;
%     h2 = vl_plotframe(region1(:,sel)) ;
%     set(h1,'color','k','linewidth',3) ;
%     set(h2,'color','y','linewidth',2) ;
%     h3 = vl_plotsiftdescriptor(d1(:,sel),region1(:,sel)) ;
%     set(h3,'color','g') ;
%     
% %   distorted image sift descriptors
%     figure
%     imshow(distorted) ;
%     perm = randperm(size(region2,2)) ;
%     N1=1;
%     N2=10;
%     sel = perm(N1:N2) ;
%     h1 = vl_plotframe(region2(:,sel)) ;
%     h2 = vl_plotframe(region2(:,sel)) ;
%     set(h1,'color','k','linewidth',3) ;
%     set(h2,'color','y','linewidth',2) ;
%     h3 = vl_plotsiftdescriptor(d2(:,sel),region2(:,sel)) ;
%     set(h3,'color','g') ;
%% 

H=importdata(strcat('E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\2.txt'));
[v_overlap, v_repeatability, v_nb_of_corespondences,matching_score,nb_of_matches,twi] = repeatability('img1sift.txt', 'img2sift.txt',H, 'E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\1.jpg','E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\2.jpg',0);
% % [v_overlap,v_repeatability,v_nb_of_corespondences,matching_score,nb_of_matches,twi] = repeatability('img1.haraff.sift','img2.haraff.sift','H1to2p','img1.ppm','img2.ppm',0);
v_nb_of_corespondencessift=v_nb_of_corespondences;
v_repeatabilitysift=v_repeatability;

[correct_match_nn,total_match_nn,correct_match_sim,total_match_sim,correct_match_rn,total_match_rn,recall,precision] = descperf('img1sift.txt','img2sift.txt',H,'E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\1.jpg','E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\2.jpg',v_nb_of_corespondences,twi);
recallsift=recall;
precisionsift=precision;
% figure 
% display_features('img1sift.txt', 'E:\MyResearch\paper\image\descriptor\Colles\rotate\1.jpg',1,1) 
% figure
% plot(v_overlap,v_repeatability);
figure
plot(precision,recall);
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','v_nb_of_corespondencessift.mat'],'v_nb_of_corespondencessift')
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','v_repeatabilitysift.mat'],'v_repeatabilitysift')
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','recallsift.mat'],'recallsift')
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','precisionsift.mat'],'precisionsift')