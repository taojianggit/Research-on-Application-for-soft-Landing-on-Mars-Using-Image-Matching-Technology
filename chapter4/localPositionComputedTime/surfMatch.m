%This file plots table4.4, and compute F, R, T
clc
clear;
K=[2078.97327381856,0,0;8.96544997910551,2222.96648717506,0;726.827580966545,436.278172597356,1]';
IMG1={'Sat Dec 31 20-26-56','Sat Dec 31 20-30-38','Sat Dec 31 20-37-57',...
      'Sat Dec 31 21-02-27','Sat Dec 31 21-05-33','Sat Dec 31 21-07-38',...
      'Sat Dec 31 21-11-33','Sat Dec 31 21-13-35','Sat Dec 31 21-15-57','Sat Dec 31 21-19-41'};

% [-7.84152869918514e-07,1.76198670876052e-05,-0.0380949153261820;-1.74231053103808e-05,9.32947218347562e-07,-0.0145398822827956;0.0358234313342215,0.0116484861735100,0.998459172293834]
    I1=imread(strcat('E:\MyResearch\Thesis\thesisPicture\localPosition\',IMG1{1},'.bmp'));
%     imshow(I1) ;
    I1=rgb2gray(I1);

    I2=imread(strcat('E:\MyResearch\Thesis\thesisPicture\localPosition\',IMG1{2},'.bmp'));
    I2=rgb2gray(I2);
%% SURF
tic;points1 = detectSURFFeatures(I1);
points2 = detectSURFFeatures(I2);
pts1=points1(randperm(size(points1,1), 450),:);
pts2=points2(randperm(size(points2,1), 450),:);
    [featuresoriginalsurf,validptsoriginalsurf]=extractFeatures(I1,pts1);
    [featuresdistortedsurf,validptsdistortedsurf]=extractFeatures(I2,pts2);extractTime=toc*1000/1565
    tic; [indexPairssu, matchMetricsu]=matchFeatures(featuresoriginalsurf,featuresdistortedsurf);
    matchedPtsOriginal2=validptsoriginalsurf(indexPairssu(:,1),:);
    matchedPtsDistorted2=validptsdistortedsurf(indexPairssu(:,2),:);
        [tform,inlierPtsDistorted,inlierPtsOriginal] = estimateGeometricTransform(matchedPtsDistorted2,matchedPtsOriginal2,'projective');
    [tform1,inlierPtsDistorted1,inlierPtsOriginal1] = estimateGeometricTransform(inlierPtsDistorted,inlierPtsOriginal,'projective');   matchedTime= toc
     tic; [fLMedS, inliers] = estimateFundamentalMatrix(matchedPtsOriginal2,matchedPtsDistorted2, 'NumTrials', 500,'Method','Norm8Point');fundatmenalTIme=toc
         tic;E=K'*fLMedS*K;essentialTime=toc
    tic;[U,S,V]=svd(E);
    Z=[0 1 0;-1 0 0;0 0 0];W=[0 -1 0;1 0 0;0 0 1];

    R1=(U*W*V)';
    R2=(U*W'*V)';
    positionTIme=toc
    time=positionTIme+fundatmenalTIme+matchedTime+extractTime+essentialTime