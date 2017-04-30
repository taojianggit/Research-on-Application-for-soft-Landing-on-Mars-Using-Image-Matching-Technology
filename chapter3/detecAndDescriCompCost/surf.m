clc
clear


imageFile1=imread('E:\MyResearch\paper\image\detector\Chaos\view\1.PNG');
imageFile2=imread('E:\MyResearch\paper\image\detector\Fossa\view\1.PNG');
imageFile3=imread('E:\MyResearch\paper\image\detector\Crater\view\1.PNG');
imageFile4=imread('E:\MyResearch\paper\image\detector\Colles\view\1.PNG');
    if length(size(imageFile1))==3
        image1= (rgb2gray(imageFile1));
    else
        image1= (imageFile1);
    end
    
    
    if length(size(imageFile2))==3
        image2= (rgb2gray(imageFile2));
    else
        image2= (imageFile2);
    end

    if length(size(imageFile3))==3
        image3= (rgb2gray(imageFile3));
    else
        image3= (imageFile3);
    end
    
    if length(size(imageFile4))==3
        image4= (rgb2gray(imageFile4));
    else
        image4= (imageFile4);
    end
        
        
% tic        
% points1=detectSURFFeatures(image1);
% c1=points1.Count
% t1=toc

% tic
% points2=detectSURFFeatures(image2);
% c2=points2.Count
% t2=toc

% tic
% points3=detectSURFFeatures(image3);
% c3=points3.Count
% t3=toc
% tic
% points4=detectSURFFeatures(image4);
% c4=points4.Count
% t4=toc
% 
% t=(t1+t2+t3+t4)/4
% 
% tic
% extractFeatures(image1,points1,'Method','FREAK');
% extractFeatures(image1,points2,'Method','FREAK');
% extractFeatures(image1,points3,'Method','FREAK');
% extractFeatures(image1,points4,'Method','FREAK');
% toc/4
% tic
% extractFeatures(image1,points1,'Method','BRISK');
% extractFeatures(image1,points2,'Method','BRISK');
% extractFeatures(image1,points3,'Method','BRISK');
% extractFeatures(image1,points4,'Method','BRISK');
% toc/4
% 
% tic
% extractFeatures(image1,points1,'Method','SURF');
% extractFeatures(image1,points2,'Method','SURF');
% extractFeatures(image1,points3,'Method','SURF');
% F=extractFeatures(image1,points4,'Method','SURF');
% toc/4










