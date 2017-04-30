clc
clear;

IMG={'Sat Dec 31 20-24-03-00(32.5)-00(38)-50','Sat Dec 31 20-29-4-00-05-50','Sat Dec 31 20-37-13-05-05--50',...
    'Sat Dec 31 21-01-40-05-05-40','Sat Dec 31 21-05-07-05-10-40','Sat Dec 31 21-07-05-10-10-40',...
    'Sat Dec 31 21-09-56-10-10-30','Sat Dec 31 21-12-55-10-15-30','Sat Dec 31 21-15-23-15-15-30','Sat Dec 31 21-20-26-15-15-20'};
IMG1={'Sat Dec 31 20-26-56','Sat Dec 31 20-30-38','Sat Dec 31 20-37-57',...
      'Sat Dec 31 21-02-27','Sat Dec 31 21-05-33','Sat Dec 31 21-07-38',...
      'Sat Dec 31 21-11-33','Sat Dec 31 21-13-35','Sat Dec 31 21-15-57','Sat Dec 31 21-19-41'};

% [-7.84152869918514e-07,1.76198670876052e-05,-0.0380949153261820;-1.74231053103808e-05,9.32947218347562e-07,-0.0145398822827956;0.0358234313342215,0.0116484861735100,0.998459172293834]
    I1=imread(strcat('E:\MyResearch\Thesis\thesisPicture\localPosition\',IMG1{1},'.bmp'));
%     imshow(I1) ;
    I1=rgb2gray(I1);
   
    I2=imread(strcat('E:\MyResearch\Thesis\thesisPicture\localPosition\',IMG1{2},'.bmp'));
    I2=rgb2gray(I2);
    %% crew recification
    RadialDistortion=[-0.510993831933592,1.125145034618890];
    TangentialDistortion=[-0.007363474397557,-0.001245544728187];
    K=[2078.97327381856,0,0;8.96544997910551,2222.96648717506,0;726.827580966545,436.278172597356,1]';
    I11 = zeros(size(I1));[i,j] = find(~isnan(I11)); 
    Xp = K\[j i ones(length(i),1)]';  
    r2 = Xp(1,:).^2+Xp(2,:).^2;  
    x = Xp(1,:);  
    y = Xp(2,:);  

    x = x.*(1+RadialDistortion(1)*r2 + RadialDistortion(2)*r2.^2) + 2*TangentialDistortion(1).*x.*y + TangentialDistortion(2)*(r2 + 2*x.^2);  
    y = y.*(1+RadialDistortion(1)*r2 + RadialDistortion(2)*r2.^2) + 2*TangentialDistortion(2).*x.*y + TangentialDistortion(1)*(r2 + 2*y.^2); 
    u = reshape(K(1,1)*x + K(1,3),size(I11));  
    v = reshape(K(2,2)*y + K(2,3),size(I11));  
    I11 = interp2(double(I1), u, v);
   
%     figure,imshow(I11,[])
    
    I22 = zeros(size(I2));[i2,j2] = find(~isnan(I22)); 
    Xp2 = K\[j2 i2 ones(length(i2),1)]';  
    r22 = Xp2(1,:).^2+Xp2(2,:).^2;  
    x22 = Xp2(1,:);  
    y22 = Xp2(2,:);  

    x22 = x22.*(1+RadialDistortion(1)*r22 + RadialDistortion(2)*r22.^2) + 2*TangentialDistortion(1).*x22.*y22 + TangentialDistortion(2)*(r22 + 2*x22.^2);  
    y22 = y22.*(1+RadialDistortion(1)*r22 + RadialDistortion(2)*r22.^2) + 2*TangentialDistortion(2).*x22.*y22 + TangentialDistortion(1)*(r22 + 2*y22.^2); 
    u22 = reshape(K(1,1)*x22 + K(1,3),size(I22));  
    v22 = reshape(K(2,2)*y22 + K(2,3),size(I22));  
    I22 = interp2(double(I1), u22, v22);
   
%     figure,imshow(I22,[])
    
    %% SIFT
    
    I11=single(I11);
    I22=single(I22);
    tic;
    [f10,d1] = vl_sift(I11) ;
    [f20,d2] = vl_sift(I22) ;extractTime=toc/8
     tic;perm = randperm(size(f10,2)) ;
    sel = perm(1:50) ;
    f1=f10(:,sel);
    f2=f20(:,sel);
    d1=d1(:,sel);
    d2=d2(:,sel);
% %     h1 = vl_plotframe(f1(:,sel)) ;
% %     h2 = vl_plotframe(f1(:,sel)) ;
% %     set(h1,'color','k','linewidth',3) ;
% %     set(h2,'color','y','linewidth',2) ;
    pts1=f1(1:2,:)';
    pts2=f2(1:2,:)';
    [indexPairss, matchScores]=vl_ubcmatch(d1,d2);
    
    indexPairss=indexPairss';
    matchedPtsOriginal2=pts1(indexPairss(:,1),:);
    matchedPtsDistorted2=pts2(indexPairss(:,2),:);

    %% 
    
    [tform,inlierPtsDistorted,inlierPtsOriginal] = estimateGeometricTransform(matchedPtsDistorted2,matchedPtsOriginal2,'projective');
    [tform1,inlierPtsDistorted1,inlierPtsOriginal1] = estimateGeometricTransform(inlierPtsDistorted,inlierPtsOriginal,'projective');   matchTime= toc
    size(inlierPtsDistorted1,1)/size(inlierPtsDistorted,1)

    %% 
%     
% figure(1); clf;
% imagesc(cat(2, I1, I2));
% axis image off;
% colormap gray;
% 
% % Display a second copy with the matches overlaid
% figure(2) ; clf ;
% imagesc(cat(2, I1, I2));
% axis image off;
% colormap gray;
% indexPairss=indexPairss';
% xa = f1(1, indexPairss(1,:));
% ya = f1(2, indexPairss(1,:));
% xb = f2(1, indexPairss(2,:)) + size(I1,2);
% yb = f2(2, indexPairss(2,:));
% 
% hold on ;
% h = line([xa ; xb], [ya ; yb]);
% set(h, 'linewidth', 1.3, 'color', 'y');
%% 
  
%     figure
%     showMatchedFeatures(I1,I2,inlierPtsOriginal1,inlierPtsDistorted1,'montage','PlotOptions',{'ro','gs','y-'});
    %% 
    
    tic; [fLMedS, inliers] = estimateFundamentalMatrix(matchedPtsOriginal2,matchedPtsDistorted2, 'NumTrials', 500,'Method','Norm8Point');fundatmenalTIme=toc%,'Method','LTS'Norm8Point
    
    tic;E=K'*fLMedS*K;essentialTime=toc
    tic;[U,S,V]=svd(E);
    Z=[0 1 0;-1 0 0;0 0 0];W=[0 -1 0;1 0 0;0 0 1];

    R1=(U*W*V)';
    R2=(U*W'*V)';positionTime=toc
    time=fundatmenalTIme+essentialTime+matchTime+extractTime+positionTime
    %% Dingmeng
    
%     Fd=[ 0 0 -0.0039812;0 0 0.0089931;0.0040532 -0.010347 0.28025];
%     Kd=[571.39464 0 254.23697;0 571.90697 206.67987;0 0 1];
%     Ed=Kd'*Fd*Kd;
%     [Ud ,Sd ,Vd]=svd(Ed);
%     Zd=[0 1 0;-1 0 0;0 0 0];Wd=[0 -1 0;1 0 0;0 0 1];
%     Rd1=Ud*Wd*Vd;
%     Rd2=Ud*Wd'*Vd;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    