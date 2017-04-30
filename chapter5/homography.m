clear;clc
IMG={'Jezero Crater','Mawrth Vallis','Southwest Melas Chasma Landforms','Nili Fossae','Northeastern Syrtis Major Planitia'};
for j=1:1
I0{j}=imread(strcat('E:\MyResearch\paper\image\Mars2020\',IMG{j},'\1.png'));
I1{j}=imread(strcat('E:\MyResearch\paper\image\Mars2020\',IMG{j},'\2.png'));
if(~isdeployed)
    cd(fileparts(which(mfilename)));
end

% Initialize.
fontSize = 20;
button = menu('Use which demo image?', 'CameraMan', 'Moon', 'Eight', 'Coins', 'Other');
if button == 1
	grayImage = im2double(imread('cameraman.tif'));
elseif button == 2
	grayImage =imread( 'moon.tif');
elseif button == 3
	grayImage = imread('eight.tif');
elseif button == 4
	grayImage = imread('coins.png');
else
	grayImage = (rgb2gray(I0{j}));
    grayImage1 = (rgb2gray(I1{j}));

end
% 
%         figure 
%         imshow(grayImage)
%         figure 
%         imshow(grayImage1,[])
        %% 
        tic
        grayImage =double(grayImage);
        grayImage1 =double(grayImage1);
        windowSize=41;
        b=1;
        c=1;
        mf=127;
        vf=300;
        meanImage = conv2(grayImage, ones(windowSize)/windowSize^2,'same');
        meanImage1 = conv2(grayImage1, ones(windowSize)/windowSize^2,'same'); 
        nHood = ones(windowSize);
        sdImage = stdfilt(grayImage, nHood);
        sdImage1 = stdfilt(grayImage1, nHood);
        B=(c*vf*(grayImage-meanImage)./(c*sdImage+(1-c)*vf*ones(size(grayImage))))+b*mf*ones(size(grayImage))+(1-b)*meanImage;
        B1=(c*vf*(grayImage1-meanImage1)./(c*sdImage1+(1-c)*vf*ones(size(grayImage1))))+b*mf*ones(size(grayImage1))+(1-b)*meanImage1;
        toc
        figure 
        imshow(B,[])
%         figure
%         h1 = histogram(B(:)./9,400);set(gca,'FontSize',16);
%         figure
%         h2 = histogram(grayImage(:),400);set(gca,'FontSize',16);
        figure 
        imshow(B1,[])
%         figure
%         h3 = histogram(B1(:)./9,500);set(gca,'FontSize',16);
%         figure
%         h4 = histogram(grayImage1(:),500);set(gca,'FontSize',16);
        %% 
        
        ptsOriginal  = detectSURFFeatures(B);
        ptsDistorted = detectSURFFeatures(B1);
        [featuresOriginal,validPtsOriginal] = extractFeatures(B, ptsOriginal);
        [featuresDistorted,validPtsDistorted] = extractFeatures(B1,ptsDistorted);
%         ptsOriginal  = detectSURFFeatures(grayImage);
%         ptsDistorted = detectSURFFeatures(grayImage1);
%         [featuresOriginal,validPtsOriginal] = extractFeatures(grayImage, ptsOriginal);
%         [featuresDistorted,validPtsDistorted] = extractFeatures(grayImage1,ptsDistorted);
        index_pairs = matchFeatures(featuresOriginal,featuresDistorted);
        matchedPtsOriginal  = validPtsOriginal(index_pairs(:,1));
        matchedPtsDistorted = validPtsDistorted(index_pairs(:,2));
        [tform,inlierPtsDistorted,inlierPtsOriginal] = estimateGeometricTransform(matchedPtsDistorted,matchedPtsOriginal,'projective');
        figure; showMatchedFeatures(B,B1,inlierPtsOriginal,inlierPtsDistorted,'montage','PlotOptions',{'rs','gs','y-'});

%        outputView = imref2d(size(grayImage));
%        Ir = imwarp(grayImage1,tform,'OutputView',outputView,'FillValues',145);
%        figure; imshow(Ir,[]);
%        title('Recovered image');
        
end