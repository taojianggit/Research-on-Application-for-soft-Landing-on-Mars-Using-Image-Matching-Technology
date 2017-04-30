clc
clear

%% set parameters
zoomPara=1.2;
rotatePara=45;
blurPara=5;

%% read image

original=imread('E:\MyResearch\paper\image\matchFeatures\multi\0.jpg');

% %% zoom
I1=imresize(original,zoomPara);
imwrite(I1,strcat('E:\MyResearch\paper\image\matchFeatures\multi\zoom.jpg'));


% %% rotate
I2=imrotate(I1,rotatePara);
sizeofI2=size(I2);
cc=[sizeofI2(1)/2,sizeofI2(2)/2];
I2=imcrop(I2,[cc(2)-1100,cc(1)-100,1200,1200]);
%imwrite(I2,strcat('E:\MyResearch\paper\image\matchFeatures\multi\rotate.jpg'));


% %% blur
PSF = fspecial('motion',blurPara,0);
I3= imfilter(I2,PSF);
imwrite(I3, strcat('E:\MyResearch\paper\image\matchFeatures\multi\distorted.jpg'));

% %% view
% 
%     tform = affine2d([1 0 0; 0 1.2 0; 0 0 1]);
%     g = imwarp(I3, tform);
%     imshow(g)

distorted=I3;
if length(size(original))==3&&length(size(distorted))==3
original=im2double(rgb2gray(original));
distorted=im2double(rgb2gray(distorted));
else
    original=im2double(original);
    distorted=im2double(distorted);
end



%% %% akaze region
pts1=importdata('E:\MyResearch\paper\image\matchFeatures\multi\pts1.txt');
angle1=importdata('E:\MyResearch\paper\image\matchFeatures\multi\kpts1angle.txt');
size1=importdata('E:\MyResearch\paper\image\matchFeatures\multi\kpts1size.txt');

pts2=importdata('E:\MyResearch\paper\image\matchFeatures\multi\pts2.txt');
angle2=importdata('E:\MyResearch\paper\image\matchFeatures\multi\kpts2angle.txt');
size2=importdata('E:\MyResearch\paper\image\matchFeatures\multi\kpts2size.txt');


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
save(['E:\MyResearch\paper\image\matchFeatures\multi\','region1.mat'],'region1')
save(['E:\MyResearch\paper\image\matchFeatures\multi\','region2.mat'],'region2')

dakaze1=importdata('E:\MyResearch\paper\image\matchFeatures\multi\desc1.txt');
dakaze2=importdata('E:\MyResearch\paper\image\matchFeatures\multi\desc2.txt');

aa=0.02;
img1akaze=[region1(:,1) region1(:,2) region1(:,3)*aa zeros(size(region1,1),1) region1(:,3)*aa double(dakaze1)];
img2akaze=[region2(:,1) region2(:,2) region2(:,3)*aa zeros(size(region2,1),1) region2(:,3)*aa double(dakaze2)];
p1 = [61;size(img1akaze,1)];
p2 = [61;size(img2akaze,1)];
q1 = double(img1akaze);
q2 = double(img2akaze);
save('img1akaze.txt','p1','q1','-ascii')
save('img2akaze.txt','p2','q2','-ascii')

dakaze1=importdata('E:\MyResearch\paper\image\matchFeatures\multi\desc1.txt');
dakaze2=importdata('E:\MyResearch\paper\image\matchFeatures\multi\desc2.txt');

%% kaze region
dkaze1=importdata('E:\MyResearch\paper\image\matchFeatures\multi\kdesc1.txt');
dkaze2=importdata('E:\MyResearch\paper\image\matchFeatures\multi\kdesc2.txt');

%% surf region
size1=importdata('E:\MyResearch\paper\image\matchFeatures\multi\kpts1size.txt');
size2=importdata('E:\MyResearch\paper\image\matchFeatures\multi\kpts2size.txt');
points1 = SURFPoints(pts1,'Scale',size1) ;
points2 = SURFPoints(pts2,'Scale',size2) ;
[featuresoriginalsurf,validptsoriginalsurf]=extractFeatures(original,points1);
[featuresdistortedsurf,validptsdistortedsurf]=extractFeatures(distorted,points2);
featuresdistortedsurf=double(featuresdistortedsurf);
featuresoriginalsurf=double(featuresoriginalsurf);

%% brisk region
briskPoints1 = BRISKPoints(pts1,'Scale',size1) ;
briskPoints2 = BRISKPoints(pts2,'Scale',size2) ;
[featuresoriginalbrisk,validptsoriginalbrisk]=extractFeatures(original,briskPoints1,'Method','BRISK');
[featuresdistortedbrisk,validptsdistortedbrisk]=extractFeatures(distorted,briskPoints2,'Method','BRISK');
dbriskori=double(featuresoriginalbrisk.Features);
dbriskdis=double(featuresdistortedbrisk.Features);
%% kaze+brisk region
kazebriskorides=[dbriskori  dkaze1];
kazebriskdisdes=[dbriskdis  dkaze2];
%% kaze+akaze region
akazekazeorides=[dakaze1 dkaze1];
akazekazedisdes=[dakaze2 dkaze2];
%% kaze+akaze+brisk region
kazeakazebriskorides=[dkaze1 dbriskori  dakaze1];
kazeakazebriskdisdes=[dkaze2 dbriskdis  dakaze2];


%% match features
[indexPairsk, matchMetrick]=matchFeatures(dkaze1,dkaze2);
[indexPairssu, matchMetricsu]=matchFeatures(featuresoriginalsurf,featuresdistortedsurf);
[indexPairsbr, matchMetricbr]=matchFeatures(featuresoriginalbrisk,featuresdistortedbrisk);
[indexPairsak, matchMetricak]=matchFeatures(dakaze1,dakaze2);
[indexPairskb, matchMetric1]=matchFeatures(kazebriskorides,kazebriskdisdes);
[indexPairska, matchMetric2]=matchFeatures(akazekazeorides,akazekazedisdes);
[indexPairskab, matchMetric3]=matchFeatures(kazeakazebriskorides,kazeakazebriskdisdes);
%% MSAC /connect descriptors 

% %  kaze+brisk
% matchedPtsOriginalkb=validptsoriginalbrisk(indexPairskb(:,1));
% matchedPtsDistortedkb=validptsdistortedbrisk(indexPairskb(:,2));
% [tformkb,inlierPtsDistortedkb,inlierPtsOriginalkb] = estimateGeometricTransform(matchedPtsDistortedkb,matchedPtsOriginalkb,'similarity');
% matchedptskb=size(matchedPtsDistortedkb,1);
% innerptskb=size(inlierPtsDistortedkb,1);
% fprintf('kaze&brisk  matched indexpairs: %d\n',matchedptskb);
% fprintf('kaze&brisk correct  matched indexpairs: %d\n',innerptskb);
% fprintf('preicision: %f\n',innerptskb/matchedptskb);
% fprintf('*****************\n' );

% %  kaze+akaze
% matchedPtsOriginalka=validptsoriginalbrisk(indexPairska(:,1));
% matchedPtsDistortedka=validptsdistortedbrisk(indexPairska(:,2));
% [tformka,inlierPtsDistortedka,inlierPtsOriginalka] = estimateGeometricTransform(matchedPtsDistortedka,matchedPtsOriginalka,'similarity');
% matchedptska=size(matchedPtsDistortedka,1);
% innerptska=size(inlierPtsDistortedka,1);
% fprintf('kaze&akaze  matched indexpairs: %d\n',matchedptska);
% fprintf('kaze&akaze correct  matched indexpairs: %d\n',innerptska);
% fprintf('preicision: %f\n',innerptska/matchedptska);
% fprintf('*****************\n' );

% %  kaze+akaze+brisk
% matchedPtsOriginalkab=validptsoriginalbrisk(indexPairskab(:,1));
% matchedPtsDistortedkab=validptsdistortedbrisk(indexPairskab(:,2));
% [tformkab,inlierPtsDistortedkab,inlierPtsOriginalkab] = estimateGeometricTransform(matchedPtsDistortedkab,matchedPtsOriginalkab,'similarity');
% matchedptskab=size(matchedPtsDistortedkab,1);
% innerptskab=size(inlierPtsDistortedkab,1);
% fprintf('kaze&akaze&brisk  matched indexpairs: %d\n',matchedptskab);
% fprintf('kaze&akaze&brisk correct  matched indexpairs: %d\n',innerptskab);
% fprintf('preicision: %f\n',innerptskab/matchedptskab);
% fprintf('*****************\n' );
%% MSAC 

%  kaze brisk
kb=indexPairsk;
[intersectIndexPairs1,intersetIndex1]=intersect(indexPairsk(:,1),indexPairsbr(:,1));%intersetIndex1 is index of indexPairsk that overlap with indexpairssu
kb(intersetIndex1,:)=[];%set row of interstIndex1 to 0
indexPairs1=[kb;indexPairsbr];
matchedPtsOriginal1=validptsoriginalbrisk(indexPairs1(:,1));
matchedPtsDistorted1=validptsdistortedbrisk(indexPairs1(:,2));
[tform1,inlierPtsDistorted1,inlierPtsOriginal1] = estimateGeometricTransform(matchedPtsDistorted1,matchedPtsOriginal1,'similarity');
matchedpts1=size(matchedPtsDistorted1,1);
innerpts1=size(inlierPtsDistorted1,1);
fprintf('kaze&brisk   matched indexpairs: %d\n',matchedpts1);
fprintf('kaze&brisk correct  matched indexpairs: %d\n',innerpts1);
fprintf('preicision: %f\n',innerpts1/matchedpts1);
fprintf('*****************\n' );
% kaze akaze 
ka=indexPairsak;
[intersectIndexPairs2,intersetIndex2]=intersect(indexPairsak(:,1),indexPairsk(:,1));%intersetIndex1 is index of indexPairsk that overlap with indexpairssu
ka(intersetIndex2,:)=[];%set row of interstIndex1 to 0
indexPairs2=[ka;indexPairsk];
matchedPtsOriginal2=validptsoriginalbrisk(indexPairs2(:,1));
matchedPtsDistorted2=validptsdistortedbrisk(indexPairs2(:,2));
[tform2,inlierPtsDistorted2,inlierPtsOriginal2] = estimateGeometricTransform(matchedPtsDistorted2,matchedPtsOriginal2,'similarity');
matchedpts2=size(matchedPtsDistorted2,1);
innerpts2=size(inlierPtsDistorted2,1);
fprintf('akaze&kaze   matched indexpairs: %d\n',matchedpts2);
fprintf('akaze&kaze correct  matched indexpairs: %d\n',innerpts2);
fprintf('preicision: %f\n',innerpts2/matchedpts2);
fprintf('*****************\n' );
%  kaze akaze brisk
kabr=indexPairs2;
[intersectIndexPairs3,intersetIndex3]=intersect(indexPairs2(:,1),indexPairsbr(:,1));%intersetIndex1 is index of indexPairsk that overlap with indexpairssu
kabr(intersetIndex3,:)=[];%set row of interstIndex1 to 0
indexPairs3=[kabr;indexPairsbr];
matchedPtsOriginal3=validptsoriginalbrisk(indexPairs3(:,1));
matchedPtsDistorted3=validptsdistortedbrisk(indexPairs3(:,2));
[tform3,inlierPtsDistorted3,inlierPtsOriginal3] = estimateGeometricTransform(matchedPtsDistorted3,matchedPtsOriginal3,'similarity');
matchedpts3=size(matchedPtsDistorted3,1);
innerpts3=size(inlierPtsDistorted3,1);
fprintf('kaze&akaze&brisk   matched indexpairs: %d\n',matchedpts3);
fprintf('kaze&akaze&brisk correct  matched indexpairs: %d\n',innerpts3);
fprintf('preicision: %f\n',innerpts3/matchedpts3);
fprintf('*****************\n' );

% brisk
matchedPtsOriginal5=pts1(indexPairsbr(:,1),:);
matchedPtsDistorted5=pts2(indexPairsbr(:,2),:);
[tform5,inlierPtsDistorted5,inlierPtsOriginal5] = estimateGeometricTransform(matchedPtsDistorted5,matchedPtsOriginal5,'similarity');
matchedpts5=size(matchedPtsDistorted5,1);
innerpts5=size(inlierPtsDistorted5,1);
fprintf('brisk   matched indexpairs: %d\n',matchedpts5);
fprintf('brisk correct  matched indexpairs: %d\n',innerpts5);
fprintf('preicision: %f\n',innerpts5/matchedpts5);
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

% akaze
matchedPtsOriginal6=pts1(indexPairsak(:,1),:);
matchedPtsDistorted6=pts2(indexPairsak(:,2),:);
[tform6,inlierPtsDistorted6,inlierPtsOriginal6] = estimateGeometricTransform(matchedPtsDistorted6,matchedPtsOriginal6,'similarity');
matchedpts6=size(matchedPtsDistorted6,1);
innerpts6=size(inlierPtsDistorted6,1);
fprintf('akaze   matched indexpairs: %d\n',matchedpts6);
fprintf('akaze correct  matched indexpairs: %d\n',innerpts6);
fprintf('preicision: %f\n',innerpts6/matchedpts6);
fprintf('*****************\n' );

% surf
matchedPtsOriginal7=pts1(indexPairssu(:,1),:);
matchedPtsDistorted7=pts2(indexPairssu(:,2),:);
[tform7,inlierPtsDistorted7,inlierPtsOriginal7] = estimateGeometricTransform(matchedPtsDistorted7,matchedPtsOriginal7,'similarity');
% [tform5,inlierPtsDistorted5,inlierPtsOriginal5] = RansacMatch(matchedPtsDistorted5,matchedPtsOriginal5);
matchedpts7=size(matchedPtsDistorted7,1);
innerpts7=size(inlierPtsDistorted7,1);
fprintf('surf   matched indexpairs: %d\n',matchedpts7);
fprintf('surf correct  matched indexpairs: %d\n',innerpts7);
fprintf('preicision: %f\n',innerpts7/matchedpts7);
fprintf('*****************\n' );


N1=70;
N2=size(inlierPtsDistorted1,1);
figure('color','white')
showMatchedFeatures(original,distorted,inlierPtsOriginal1(1:N1:N2,:),inlierPtsDistorted1(1:N1:N2,:),'montage');

figure('color','white')
showMatchedFeatures(original,distorted,inlierPtsOriginal3(1:N1:N2,:),inlierPtsDistorted3(1:N1:N2,:),'montage');