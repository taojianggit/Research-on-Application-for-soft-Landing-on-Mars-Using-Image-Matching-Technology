%This code plots Tab5.4
clc
clear;
C{1}=[];C{2}=[];C{3}=[];C{4}=[];C{5}=[];C{6}=[];C{7}=[];C{8}=[];C{9}=[];C{10}=[];
IMG={'Jezero Crater','Mawrth Vallis','Southwest Melas Chasma Landforms','Nili Fossae','Northeastern Syrtis Major Planitia'};
for i=1
I00{i}=imread(strcat('E:\MyResearch\paper\image\Mars2020\',IMG{i},'\c.jpg'));
I00{i}=rgb2gray(I00{i});
I00{i}=imrotate(I00{i},0);
% figure(1); imshow(I00{i});
I0{i}=imread(strcat('E:\MyResearch\paper\image\Mars2020\',IMG{i},'\s1.jpg'));
I0{i}=rgb2gray(I0{i});

% I1{i}=imread(strcat('E:\MyResearch\paper\image\Mars2020\',IMG{i},'\4.jpg'));
% I1{i}=rgb2gray(I1{i});
% figure(2); imshow(I0{i});
%        PSF = fspecial('motion',2,0);
%        I0{i} = imfilter(I0{i},PSF);
%        figure
%        imshow(I2);
% I0{i}=testlocalnormalize(I0{i});
% I0{i} = mapminmax(I0{i},0,255);
k=1;
    for j=71
            I1=imresize(I0{i},1/(16-0.2*j));
            I1=imrotate(I1,0);
%             I1=projectiveImg(I1,0,0,0);
%             PSF = fspecial('motion',1,0);
%             I1 = imfilter(I1,PSF);
%       figure(2); imshow(I1);title('wrap image');
            tic
            ptsI00  = detectSURFFeatures(I00{i});
            ptsI00=ptsI00(randperm(size(ptsI00,1), size(ptsI00,1)),:);
    %         figure
    %         imshow(I0{i}); hold on;
    %         plot( ptsOriginal.Location(:,1),ptsOriginal.Location(:,2),'rs');
%             figure
%             imshow(I1); hold on;
            ptsI1= detectSURFFeatures(I1); 
            ptsI1=ptsI1(randperm(size(ptsI1,1), size(ptsI1,1)),:);
%             A=ptsI1.Location;
%             B=A(randperm(size(ptsI1,1), 50),:);
%             hold on
%             plot(B(:,1) ,B(:,2),'gs');
            [featuresOriginal,validPtsOriginal] = extractFeatures(I00{i}, ptsI00);
            [featuresDistorted,validPtsDistorted] = extractFeatures(I1,ptsI1);
            index_pairs = matchFeatures(featuresOriginal,featuresDistorted);
            matchedPtsOriginal  = validPtsOriginal(index_pairs(:,1));
            matchedPtsDistorted = validPtsDistorted(index_pairs(:,2));
            [tform,inlierPtsDistorted,inlierPtsOriginal] = estimateGeometricTransform(matchedPtsDistorted,matchedPtsOriginal,'projective');
            toc
            matchPrecision=size(inlierPtsDistorted,1)/size(matchedPtsDistorted,1);
            computedValue=tform.T'*[512 512 1]';
            
            posPrecision{k}=computedValue-[1425 569 1]';
            k=k+1;
%             figure; 
%             showMatchedFeatures(I00{i},I1,inlierPtsOriginal,inlierPtsDistorted,'montage','PlotOptions',{'gs','gs','y-'});
    end
end