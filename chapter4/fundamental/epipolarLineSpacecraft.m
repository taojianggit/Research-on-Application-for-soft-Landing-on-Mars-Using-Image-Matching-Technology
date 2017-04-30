clc
clear;

IMG={'IMG_20161230_201212','IMG_20161230_201222','IMG_20161230_185552','IMG_20161230_185600','IMG_20161230_195657','IMG_20161230_195702'};

    I1=imread(strcat('E:\MyResearch\Thesis\thesisPicture\fundamental\',IMG{1},'.jpg'));
%      image(I1) ;
    I1=rgb2gray(I1);
    I2=imread(strcat('E:\MyResearch\Thesis\thesisPicture\fundamental\',IMG{2},'.jpg'));
    I2=rgb2gray(I2);
    %% SIFT
    

   
%     I1=single(I1);
%     I2=single(I2);
%     [f1,d1] = vl_sift(I1) ;
%     [f2,d2] = vl_sift(I2) ;
%     perm = randperm(size(f1,2)) ;
%     sel = perm(1:50) ;
%     h1 = vl_plotframe(f1(:,sel)) ;
%     h2 = vl_plotframe(f1(:,sel)) ;
%     set(h1,'color','k','linewidth',3) ;
%     set(h2,'color','y','linewidth',2) ;
%     pts1=f1(1:2,:)';
%     pts2=f2(1:2,:)';
%     [indexPairss, matchScores]=vl_ubcmatch(d1,d2);
%     indexPairss=indexPairss';
%     matchedPtsOriginal2=pts1(indexPairss(:,1),:);
%     matchedPtsDistorted2=pts2(indexPairss(:,2),:);
    %% SURF
    
             pts1  = detectSURFFeatures(I1);             pts2  = detectSURFFeatures(I2);
            [featuresOriginal,validPtsOriginal] = extractFeatures(I1, pts1);
            [featuresDistorted,validPtsDistorted] = extractFeatures(I2,pts2);
            index_pairs = matchFeatures(featuresOriginal,featuresDistorted);
            matchedPtsOriginal2  = validPtsOriginal(index_pairs(:,1));
            matchedPtsDistorted2 = validPtsDistorted(index_pairs(:,2));
          
            %% 
              tic 
            [fLMedS, inliers] = estimateFundamentalMatrix(matchedPtsOriginal2,matchedPtsDistorted2, 'NumTrials', 1000);toc
            [tform,inlierPtsDistorted,inlierPtsOriginal] = estimateGeometricTransform(matchedPtsDistorted2,matchedPtsOriginal2,'projective');
             [tform1,inlierPtsDistorted1,inlierPtsOriginal1] = estimateGeometricTransform(inlierPtsDistorted,inlierPtsOriginal,'projective');
             size(inlierPtsDistorted1,1)/size(inlierPtsDistorted,1)
           
%             figure; 
%             showMatchedFeatures(I1,I2,inlierPtsOriginal,inlierPtsDistorted,'montage','PlotOptions',{'gs','gs','y-'});
            %% 
            
            epiLines1 = epipolarLine(fLMedS', matchedPtsDistorted2.Location(inliers, :));
            points1 = lineToBorderPoints(epiLines1, size(I1));
            figure;
            imshow(I1)
            hold on
%             plot(matchedPtsOriginal.Location(inliers,1),matchedPtsOriginal.Location(inliers,2), 'yo','LineWidth',2)
            line(points1(:, [1,3])', points1(:, [2,4])');
%             
            epiLines2 = epipolarLine(fLMedS, matchedPtsOriginal2.Location(inliers, :));
            points2 = lineToBorderPoints(epiLines2, size(I2));
            figure
            imshow(I2);
            hold on
%             plot(matchedPtsDistorted.Location(inliers,1),matchedPtsDistorted.Location(inliers,2), 'bo','LineWidth',2)
            line(points2(:, [1,3])', points2(:, [2,4])');
            truesize;
            %% epipolorDistance
%             inlierPtsOriginal1=inlierPtsOriginal1(randperm(size(inlierPtsOriginal1,1), 67),:);
%             inlierPtsDistorted1=inlierPtsDistorted1(randperm(size(inlierPtsDistorted1,1), 67),:);
            x2=[inlierPtsDistorted1.Location,ones(size(inlierPtsDistorted1.Location,1),1)];
            x1=[inlierPtsOriginal1.Location,ones(size(inlierPtsOriginal1.Location,1),1)];
            R = diag(x2*fLMedS*x1');
            meanError=sum(abs(R))/size(inlierPtsOriginal1.Location,1);
            
            a=fLMedS*x1';b=fLMedS'*x2';
            c=1./sqrt(a(1,:).^2+a(2,:).^2);
            d=1./sqrt(b(1,:).^2+b(2,:).^2);
            D=(c+d).*R';
            meanDis=sum(abs(D))/size(inlierPtsOriginal1.Location,1);
            
            
            
            
            
            
            
            
            
            
            
            
            
            