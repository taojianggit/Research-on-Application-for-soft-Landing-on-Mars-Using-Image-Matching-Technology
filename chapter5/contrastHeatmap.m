%This code plots Fig5.4
clc
clear;

IMG={'Jezero Crater','Mawrth Vallis','Southwest Melas Chasma Landforms','Nili Fossae','Northeastern Syrtis Major Planitia'};

I0=imread(strcat('C:\Users\Public\Mars2020\',IMG{1},'\6.PNG'));
grayImage=rgb2gray(I0);
windowSize=29;
nHood = ones(windowSize);
sdImage = stdfilt(grayImage, nHood);
colormap('hot');   % set colormap
 imagesc(sdImage);        % draw image and scale colormap to values range
 colorbar; 
 
 %heatmap(flipud((sdImage)),'Standardize','COLUMN')


