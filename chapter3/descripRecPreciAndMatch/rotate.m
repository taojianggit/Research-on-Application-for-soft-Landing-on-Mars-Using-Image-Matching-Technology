clc
clear

% I1=imread('E:\MyResearch\paper\image\detector\Chaos\zoom\00.jpg');

%% gray image

for i=5
    I1=imread(strcat('E:\MyResearch\paper\image\detector\Chaos\zoom\',num2str(i),'.png'));
    I1=imadjust(I1,[0.5 0.7]);
%     I1=rgb2gray(I1);
    imwrite(I1,strcat('E:\MyResearch\paper\image\detector\Chaos\zoom\',num2str(i),'.png'));
end

%% show image

% for i=1:6
%     I1=imread(strcat('E:\MyResearch\code\akaze\featureDetector\source\data\img',num2str(i),'.pgm'));
%     figure(i)
%     imshow(I1)
% end
%% zoom1

% sizeofI1=size(I1);
% cc=[sizeofI1(1)/2,sizeofI1(2)/2];
% I0=imcrop(I1,[cc(2)-512,cc(1)-512,1024,1024]);
% imwrite(I0,strcat('E:\MyResearch\paper\image\detector\Chaos\zoom\1.jpg'));
% 
% for i=0.1:0.1:0.6
%     I2=imresize(I1,1-i);
%     sizeofI2=size(I2);
%     c=[sizeofI2(1)/2,sizeofI2(2)/2];
%     I2=imcrop(I2,[c(2)-512,c(1)-512,1024,1024]);
%     imwrite(I2,strcat('E:\MyResearch\paper\image\detector\Chaos\zoom','\',num2str(1-i),'.jpg'));
% end
%% zoom2
% I0=imresize(I1,0.4);
% imwrite(I0,strcat('E:\MyResearch\paper\image\detector\Chaos\zoom\1.0.jpg'));
% 
% for i=1.1:0.1:1.5
%     I2=imresize(I0,i);
%     imwrite(I2,strcat('E:\MyResearch\paper\image\detector\Chaos\zoom','\',num2str(i),'.jpg'));
% end

%% rotate1
%  for i=10:10:180
%     I2=imrotate(I0,i);
%     imwrite(I2,strcat('E:\MyResearch\paper\image\detector\Chaos\rotate','\',num2str(i),'.jpg'));
%  end
%% rotate2
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

%  I1=imrotate(I1,40);
%  I1=imcrop(I1,[0,50,250,250]);
%  I2=imcrop(I1,[140,140,285,285 ]);
%  imwrite(I2,strcat(' ','\',num2str(20),'.png'));
%% blur

% for i=10:2.5:20
%     PSF = fspecial('motion',i,0);
%     I2 = imfilter(I1,PSF);
%     imwrite(I2, strcat('E:\MyResearch\paper\image\detector\Chaos\blur','\',num2str(i),'.jpg'));
% end
%% view

%     tform = affine2d([1 0 0; 0 1.4 0; 0 0 1]);png
%     g = imwarp(I1, tform);
%     g = imcrop(g, [60, 0, 550, 550]);
%     imshow(g)
