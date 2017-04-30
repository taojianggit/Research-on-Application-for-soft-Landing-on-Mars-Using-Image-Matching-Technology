clc
clear
%% read image

original=imread('E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\1.jpg');
distorted=imread('E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\2.jpg');
if length(size(original))==3&&length(size(distorted))==3
original=im2double(rgb2gray(original));
distorted=im2double(rgb2gray(distorted));
end


% %% zoom2
% I0=imresize(I1,0.4);
% imwrite(I0,strcat('E:\MyResearch\paper\image\detector\Chaos\zoom\1.0.jpg'));
% 
% for i=1.1:0.1:1.5
%     I2=imresize(I0,i);
%     imwrite(I2,strcat('E:\MyResearch\paper\image\detector\Chaos\zoom','\',num2str(i),'.jpg'));
% end
% 
% %% rotate1
%  for i=10:10:180
%     I2=imrotate(I0,i);
%     imwrite(I2,strcat('E:\MyResearch\paper\image\detector\Chaos\rotate','\',num2str(i),'.jpg'));
%  end
% %% rotate2
% sizeofI1=size(I1);
% cc=[sizeofI1(1)/2,sizeofI1(2)/2];
% I0=imcrop(I1,[cc(2)-500,cc(1)-500,1024,1024]);
% % I0=imadjust(rgb2gray(I0),[0.3 0.7],[0 0.7]);
% imwrite(I0,strcat('E:\MyResearch\paper\image\detector\Chaos\rotate\1.jpg'));
%  for i=10:10:180
%     I2=imrotate(I1,i);
%     sizeofI2=size(I2);
%     c=[sizeofI2(1)/2,sizeofI2(2)/2];
%     I2=imcrop(I2,[c(2)-500,c(1)-500,1024,1024]);
% %     I2=imadjust(rgb2gray(I2),[0.3 0.7],[0 0.7]);
%     imwrite(I2,strcat('E:\MyResearch\paper\image\detector\Chaos\rotate','\',num2str(i),'.jpg'));
%  end
% 
%  I1=imrotate(I1,40);
%  I1=imcrop(I1,[0,50,250,250]);
%  I2=imcrop(I1,[140,140,285,285 ]);
%  imwrite(I2,strcat(' ','\',num2str(20),'.png'));
% %% blur
% 
% for i=10:2.5:20
%     PSF = fspecial('motion',i,0);
%     I2 = imfilter(I1,PSF);
%     imwrite(I2, strcat('E:\MyResearch\paper\image\detector\Chaos\blur','\',num2str(i),'.jpg'));
% end
% %% view
% 
%     tform = affine2d([1 0 0; 0 1.4 0; 0 0 1]);png
%     g = imwarp(I1, tform);
%     g = imcrop(g, [60, 0, 550, 550]);
%     imshow(g)


%% akaze

dakaze1=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\desc1.txt');
dakaze2=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\desc2.txt');

%% surf

region1=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\pts1.txt');%txt file should change all semicolon into comma; or change all comma into semicolon
region2=importdata(strcat('E:\MyResearch\paper\image\descriptor\Colles\rotate\pts2.txt'));
size1=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\kpts1size.txt');
size2=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\kpts2size.txt');
points1 = SURFPoints(region1,'Scale',size1) ;
points2 = SURFPoints(region2,'Scale',size2) ;
[featuresoriginalsurf,validptsoriginalsurf]=extractFeatures(original,points1);
[featuresdistortedsurf,validptsdistortedsurf]=extractFeatures(distorted,points2);

%% match
[indexPairs1, matchMetric1]=matchFeatures(dakaze1,dakaze2);
[indexPairs2, matchMetric2]=matchFeatures(featuresoriginalsurf,featuresdistortedsurf);
matchMetric2=double(matchMetric2);

[intersectIndexPairs,intersetIndex]=intersect(indexPairs1(:,1),indexPairs2(:,1));
indexPairs1(intersetIndex,:)=[];
indexPairs=[indexPairs1;indexPairs2];
matchedPtsOriginal=validptsoriginalsurf(indexPairs(:,1));
matchedPtsDistorted=validptsdistortedsurf(indexPairs(:,2));
[tform,inlierPtsDistorted,inlierPtsOriginal] = estimateGeometricTransform(matchedPtsDistorted,matchedPtsOriginal,'affine');
%% dispaly
N=800;
% Strongest = selectStrongest(inlierPtsDistorted,N);
showMatchedFeatures(original,distorted,inlierPtsOriginal(40:50:N),inlierPtsDistorted(40:50:N),'montage');














