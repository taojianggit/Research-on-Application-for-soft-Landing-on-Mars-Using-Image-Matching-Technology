clc
clear

%% set parameters
zoomPara=1.2;
rotatePara=45;
blurPara=5;

%% read image

original=imread('E:\MyResearch\paper\image\matchFeatures\Chaos\0.jpg');

% %% zoom
I1=imresize(original,zoomPara);
imwrite(I1,strcat('E:\MyResearch\paper\image\matchFeatures\Chaos\zoom.jpg'));


% %% rotate
I2=imrotate(I1,rotatePara);
sizeofI2=size(I2);
cc=[sizeofI2(1)/2,sizeofI2(2)/2];
I2=imcrop(I2,[cc(2)+400,cc(1)-700,1024,1024]);
%imwrite(I2,strcat('E:\MyResearch\paper\image\matchFeatures\Chaos\rotate.jpg'));


% %% blur
PSF = fspecial('motion',blurPara,0);
I3= imfilter(I2,PSF);
imwrite(I3, strcat('E:\MyResearch\paper\image\matchFeatures\Chaos\distorted.jpg'));

% %% view
% 
%     tform = affine2d([1 0 0; 0 1.2 0; 0 0 1]);
%     g = imwarp(I3, tform);
%     imshow(g)

distorted=I3;
if length(size(original))==3&&length(size(distorted))==3
original=im2double(rgb2gray(original));
distorted=im2double(rgb2gray(distorted));
end
%% %% akaze region
pts1=importdata('E:\MyResearch\paper\image\matchFeatures\Chaos\pts1.txt');
angle1=importdata('E:\MyResearch\paper\image\matchFeatures\Chaos\kpts1angle.txt');
size1=importdata('E:\MyResearch\paper\image\matchFeatures\Chaos\kpts1size.txt');

pts2=importdata('E:\MyResearch\paper\image\matchFeatures\Chaos\pts2.txt');
angle2=importdata('E:\MyResearch\paper\image\matchFeatures\Chaos\kpts2angle.txt');
size2=importdata('E:\MyResearch\paper\image\matchFeatures\Chaos\kpts2size.txt');


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
save(['E:\MyResearch\paper\image\matchFeatures\Chaos\','region1.mat'],'region1')
save(['E:\MyResearch\paper\image\matchFeatures\Chaos\','region2.mat'],'region2')

dakaze1=importdata('E:\MyResearch\paper\image\matchFeatures\Chaos\desc1.txt');
dakaze2=importdata('E:\MyResearch\paper\image\matchFeatures\Chaos\desc2.txt');

aa=0.02;
img1akaze=[region1(:,1) region1(:,2) region1(:,3)*aa zeros(size(region1,1),1) region1(:,3)*aa double(dakaze1)];
img2akaze=[region2(:,1) region2(:,2) region2(:,3)*aa zeros(size(region2,1),1) region2(:,3)*aa double(dakaze2)];
p1 = [61;size(img1akaze,1)];
p2 = [61;size(img2akaze,1)];
q1 = double(img1akaze);
q2 = double(img2akaze);
save('img1akaze.txt','p1','q1','-ascii')
save('img2akaze.txt','p2','q2','-ascii')

dakaze1=importdata('E:\MyResearch\paper\image\matchFeatures\Chaos\desc1.txt');
dakaze2=importdata('E:\MyResearch\paper\image\matchFeatures\Chaos\desc2.txt');

%% kaze region
dkaze1=importdata('E:\MyResearch\paper\image\matchFeatures\Chaos\kdesc1.txt');
dkaze2=importdata('E:\MyResearch\paper\image\matchFeatures\Chaos\kdesc2.txt');

%% surf region
size1=importdata('E:\MyResearch\paper\image\matchFeatures\Chaos\kpts1size.txt');
size2=importdata('E:\MyResearch\paper\image\matchFeatures\Chaos\kpts2size.txt');
points1 = SURFPoints(pts1,'Scale',size1) ;
points2 = SURFPoints(pts2,'Scale',size2) ;
[featuresoriginalsurf,validptsoriginalsurf]=extractFeatures(original,points1);
[featuresdistortedsurf,validptsdistortedsurf]=extractFeatures(distorted,points2);

%% sift region
vl_setup;
I1=single(original);
I2=single(distorted);
[~,d1] = vl_sift(I1,'frames',region1') ;
[~,d2] = vl_sift(I2,'frames',region2') ;

save(['E:\MyResearch\paper\image\matchFeatures\Chaos\','sift1.mat'],'d1')
save(['E:\MyResearch\paper\image\matchFeatures\Chaos\','sift2.mat'],'d2')
dsift1=importdata('E:\MyResearch\paper\image\matchFeatures\Chaos\sift1.mat');
dsift2=importdata('E:\MyResearch\paper\image\matchFeatures\Chaos\sift2.mat');
dsift1=double(dsift1');
dsift2=double(dsift2');

 %% match
%  kaze akaze
% [indexPairsa1, ~]=matchFeatures(dakaze1,dakaze2);
% [indexPairsa2, ~]=matchFeatures(dkaze1,dkaze2);
% 
% 
% [intersectIndexPairs1,intersetIndex1]=intersect(indexPairsa1(:,1),indexPairsa2(:,1));
% indexPairsa1(intersetIndex1,:)=[];
% indexPairs1=[indexPairsa1;indexPairsa2];
% matchedPtsOriginal1=validptsoriginalsurf(indexPairs1(:,1));
% matchedPtsDistorted1=validptsdistortedsurf(indexPairs1(:,2));
% [tform1,inlierPtsDistorted1,inlierPtsOriginal1] = estimateGeometricTransform(matchedPtsDistorted,matchedPtsOriginal,'similarity');


% match features
[indexPairsk, matchMetrick]=matchFeatures(dkaze1,dkaze2);
[indexPairssu, matchMetricsu]=matchFeatures(featuresoriginalsurf,featuresdistortedsurf);
[indexPairsak, matchMetricak]=matchFeatures(dakaze1,dakaze2);
[indexPairss, matchScores]=vl_ubcmatch(d1,d2);
indexPairss=indexPairss';
matchScores=matchScores';


%  kaze surf
ksu=indexPairsk;
[intersectIndexPairs1,intersetIndex1]=intersect(indexPairsk(:,1),indexPairssu(:,1));%intersetIndex1 is index of indexPairsk that overlap with indexpairssu
ksu(intersetIndex1,:)=[];%set row of interstIndex1 to 0
indexPairs1=[ksu;indexPairssu];
matchedPtsOriginal1=validptsoriginalsurf(indexPairs1(:,1));
matchedPtsDistorted1=validptsdistortedsurf(indexPairs1(:,2));
[tform1,inlierPtsDistorted1,inlierPtsOriginal1] = estimateGeometricTransform(matchedPtsDistorted1,matchedPtsOriginal1,'similarity');
matchedpts1=size(matchedPtsDistorted1,1);
innerpts1=size(inlierPtsDistorted1,1);
fprintf('kaze&surf   matched indexpairs: %d\n',matchedpts1);
fprintf('kaze&surf correct  matched indexpairs: %d\n',innerpts1);
fprintf('preicision: %f\n',innerpts1/matchedpts1);
fprintf('*****************\n' );



% % kaze akaze
% kak=indexPairsk;
% [intersectIndexPairs2,intersetIndex2]=intersect(indexPairsk(:,1),indexPairsak(:,1));
% kak(intersetIndex2,:)=[];
% indexPairs2=[kak;indexPairsak];
% matchedPtsOriginal2=pts1(indexPairs2(:,1),:);
% matchedPtsDistorted2=pts2(indexPairs2(:,2),:);
% [tform2,inlierPtsDistorted2,inlierPtsOriginal2] = estimateGeometricTransform(matchedPtsDistorted2,matchedPtsOriginal2,'similarity');
% matchedpts2=size(matchedPtsDistorted2,1);
% innerpts2=size(inlierPtsDistorted2,1);
% fprintf('kaze&akaze   matched indexpairs: %d\n',matchedpts2);
% fprintf('kaze&akaze correct  matched indexpairs: %d\n',innerpts2);
% fprintf('preicision: %f\n',innerpts2/matchedpts2);
% fprintf('*****************\n' );



% kaze sift
ks=indexPairsk;
[intersectIndexPairs3,intersetIndex3]=intersect(indexPairsk(:,1),indexPairss(:,1));
ks(intersetIndex3,:)=[];
indexPairs3=[ks;indexPairss];
matchedPtsOriginal3=pts1(indexPairs3(:,1),:);
matchedPtsDistorted3=pts2(indexPairs3(:,2),:);
[tform3,inlierPtsDistorted3,inlierPtsOriginal3] = estimateGeometricTransform(matchedPtsDistorted3,matchedPtsOriginal3,'similarity');
matchedpts3=size(matchedPtsDistorted3,1);
innerpts3=size(inlierPtsDistorted3,1);
fprintf('kaze&sift   matched indexpairs: %d\n',matchedpts3);
fprintf('kaze&sift correct  matched indexpairs: %d\n',innerpts3);
fprintf('preicision: %f\n',innerpts3/matchedpts3);
fprintf('*****************\n' );

% sift
matchedPtsOriginal2=pts1(indexPairss(:,1),:);
matchedPtsDistorted2=pts2(indexPairss(:,2),:);
[tform2,inlierPtsDistorted2,inlierPtsOriginal2] = estimateGeometricTransform(matchedPtsDistorted2,matchedPtsOriginal2,'similarity');
matchedpts2=size(matchedPtsDistorted2,1);
innerpts2=size(inlierPtsDistorted2,1);
fprintf('sift   matched indexpairs: %d\n',matchedpts2);
fprintf('sift correct  matched indexpairs: %d\n',innerpts2);
fprintf('preicision: %f\n',innerpts2/matchedpts2);
fprintf('*****************\n' );





% kaze
matchedPtsOriginal4=pts1(indexPairsk(:,1),:);
matchedPtsDistorted4=pts2(indexPairsk(:,2),:);
[tform4,inlierPtsDistorted4,inlierPtsOriginal4] = estimateGeometricTransform(matchedPtsDistorted4,matchedPtsOriginal4,'similarity');
matchedpts4=size(matchedPtsDistorted4,1);
innerpts4=size(inlierPtsDistorted4,1);
fprintf('kaze   matched indexpairs: %d\n',matchedpts4);
fprintf('kaze correct  matched indexpairs: %d\n',innerpts4);
fprintf('preicision: %f\n',innerpts4/matchedpts4);
fprintf('*****************\n' );



% surf
matchedPtsOriginal5=pts1(indexPairssu(:,1),:);
matchedPtsDistorted5=pts2(indexPairssu(:,2),:);
[tform5,inlierPtsDistorted5,inlierPtsOriginal5] = estimateGeometricTransform(matchedPtsDistorted5,matchedPtsOriginal5,'similarity');
% [tform5,inlierPtsDistorted5,inlierPtsOriginal5] = RansacMatch(matchedPtsDistorted5,matchedPtsOriginal5);
matchedpts5=size(matchedPtsDistorted5,1);
innerpts5=size(inlierPtsDistorted5,1);
fprintf('surf   matched indexpairs: %d\n',matchedpts5);
fprintf('surf correct  matched indexpairs: %d\n',innerpts5);
fprintf('preicision: %f\n',innerpts5/matchedpts5);
fprintf('*****************\n' );


% % akaze
% matchedPtsOriginal6=pts1(indexPairsak(:,1),:);
% matchedPtsDistorted6=pts2(indexPairsak(:,2),:);
% [tform6,inlierPtsDistorted6,inlierPtsOriginal6] = estimateGeometricTransform(matchedPtsDistorted6,matchedPtsOriginal6,'projective','MaxDistance',0.1);
% matchedpts6=size(matchedPtsDistorted6,1);
% innerpts6=size(inlierPtsDistorted6,1);
% fprintf('akaze   matched indexpairs: %d\n',matchedpts6);
% fprintf('akaze correct  matched indexpairs: %d\n',innerpts6);
% fprintf('preicision: %f\n',innerpts6/matchedpts6);
% fprintf('*****************\n' );
% %% dispaly
% N1=size(inlierPtsDistorted1,1);
% figure('color','white')
% showMatchedFeatures(original,distorted,inlierPtsOriginal1(1:30:N1),inlierPtsDistorted1(1:30:N1),'montage');
% 
N1=10;
N2=size(inlierPtsDistorted4,1);
figure('color','white')
showMatchedFeatures(original,distorted,inlierPtsOriginal4(1:N1:N2,:),inlierPtsDistorted4(1:N1:N2,:),'montage');
% 
% N3=size(inlierPtsDistorted3,1);
% figure('color','white')
% showMatchedFeatures(original,distorted,inlierPtsOriginal3(1:50:N3,:),inlierPtsDistorted3(1:50:N3,:),'montage');
% 
% N4=size(inlierPtsDistorted4,1);
% figure('color','white')
% showMatchedFeatures(original,distorted,inlierPtsOriginal4(1:50:N4,:),inlierPtsDistorted4(1:50:N4,:),'montage');









