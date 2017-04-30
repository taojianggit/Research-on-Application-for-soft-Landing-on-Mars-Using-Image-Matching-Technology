%This code plots Fig5.9~5.11
clc
clear;
C{1}=[];C{2}=[];C{3}=[];C{4}=[];C{5}=[];C{6}=[];C{7}=[];C{8}=[];C{9}=[];C{10}=[];
IMG={'Jezero Crater','Mawrth Vallis','Southwest Melas Chasma Landforms','Nili Fossae','Northeastern Syrtis Major Planitia'};
for i=4
I00{i}=imread(strcat('E:\MyResearch\paper\image\Mars2020\',IMG{i},'\c.jpg'));
I00{i}=rgb2gray(I00{i});
I00{i}=imrotate(I00{i},0);
% figure(1); imshow(I00{i});
I0{i}=imread(strcat('E:\MyResearch\paper\image\Mars2020\',IMG{i},'\s.jpg'));
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
    for j=60
            I1=imresize(I0{i},1/(16-0.2*j));
%             I1=imrotate(I1,5);
%             I1=projectiveImg(I1,0,0,0);
%             PSF = fspecial('motion',1,0);
%             I1 = imfilter(I1,PSF);
%       figure(2); imshow(I1);title('wrap image');
         
            ptsI00  = detectSURFFeatures(I00{i});
%             ptsI00=ptsI00(randperm(size(ptsI00,1), size(ptsI00,1)),:);
    %         figure
    %         imshow(I0{i}); hold on;
    %         plot( ptsOriginal.Location(:,1),ptsOriginal.Location(:,2),'rs');
%             figure
%             imshow(I1); hold on;
            ptsI1= detectSURFFeatures(I1); 
%             ptsI1=ptsI1(randperm(size(ptsI1,1), 140),:);
%             A=ptsI1.Location;
%             B=A(randperm(size(ptsI1,1), 50),:);
%             hold on
%             plot(B(:,1) ,B(:,2),'gs');
            [featuresOriginal,validPtsOriginal] = extractFeatures(I00{i}, ptsI00);
            [featuresDistorted,validPtsDistorted] = extractFeatures(I1,ptsI1);
            index_pairs = matchFeatures(featuresOriginal,featuresDistorted);
            matchedPtsOriginal  = validPtsOriginal(index_pairs(:,1));
            matchedPtsDistorted = validPtsDistorted(index_pairs(:,2));
            [tform,inlierPtsDistorted,inlierPtsOriginal] = estimateGeometricTransform(matchedPtsDistorted,matchedPtsOriginal,'affine');
            figure; 
            showMatchedFeatures(I00{i},I1,inlierPtsOriginal,inlierPtsDistorted,'montage','PlotOptions',{'gs','gs','y-'});

            outputView = imref2d(size(I00{i}));
%            tform.T(3,3)=1;
            tic
           Ir = imwarp(I1,tform,'OutputView',outputView,'FillValues',115);
           t1=toc;

       figure(3); imshow(Ir,[]);title('wraped image');
         tic;  ptsIr=detectSURFFeatures(Ir); t2=toc;
       figure(4); imshow(Ir,[]);title('detect wraped image'); 
         
%           hold on; plot(ptsIr.Location(:,1),ptsIr.Location(:,2),'gs');
%                       plot(ptsIr.selectStrongest(50));
%             A=[115 100;114 102;114 130;115 104;139 120;120 131;121 100;130 140;139 126;138 120;134 110;120,200];
          
            A=ptsIr.Location;
            B=A;
            hold on
            plot(B(:,1) ,B(:,2),'gs');
     %% DBSCAN
        tic ;[class,types]=DBSCAN(B,3);t3=toc;

     figure(5)
        imshow(Ir)
        hold on
        %% plot1
        classNumber=size(tabulate(class),1);
        valueClass=tabulate(class);
        classColor={'sb','sg','sr','sc','sy','sw','sk','sm'};
        errorColor={'ob','og','or','oc','oy','ow','ok','om'};

        %% plot2

        for t =1:size(B,1)
            if class(t) == -1  
            plot(B(t,1),B(t,2),'sb');  
            elseif class(t) == 1  
                    if types(t) == 1  
                        plot(B(t,1),B(t,2),'sg');  
                        C{1}=[C{1};B(t,1),B(t,2)];
                    else  
                        plot(B(t,1),B(t,2),'og');  
                    end  
            elseif class(t) == 2  
                if types(t) == 1  
                    plot(B(t,1),B(t,2),'sr');  
                     C{2}=[C{2};B(t,1),B(t,2)];
                else  
                    plot(B(t,1),B(t,2),'or');  
                end  
            elseif class(t) == 3  
                if types(t) == 1  
                    plot(B(t,1),B(t,2),'sc');  
                     C{3}=[C{3};B(t,1),B(t,2)];
                else  
                    plot(B(t,1),B(t,2),'oc');  
                end  
            elseif class(t) == 4  
                if types(t) == 1  
                    plot(B(t,1),B(t,2),'sy');  
                     C{4}=[C{4};B(t,1),B(t,2)];
                else  
                    plot(B(t,1),B(t,2),'oy');  
                end
             elseif class(t) == 5  
                if types(t) == 1  
                    plot(B(t,1),B(t,2),'sm');  
                     C{5}=[C{5};B(t,1),B(t,2)];
                else  
                    plot(B(t,1),B(t,2),'om');  
                end
                
            elseif class(t) == 6
                if types(t) == 1  
                    plot(B(t,1),B(t,2),'sw');  
                     C{6}=[C{6};B(t,1),B(t,2)];
                else  
                    plot(B(t,1),B(t,2),'ow');  
                end
            elseif class(t) == 7
                if types(t) == 1  
                    plot(B(t,1),B(t,2),'s','Color',[0.5 1 0.5]);  
                     C{7}=[C{7};B(t,1),B(t,2)];
                else  
                    plot(B(t,1),B(t,2),'o','Color',[0.5 1 0.5]);  
                end
            elseif class(t) == 8
                if types(t) == 1  
                    plot(B(t,1),B(t,2),'s','Color',[1 0.5 0.5]);  
                     C{8}=[C{8};B(t,1),B(t,2)];
                else  
                    plot(B(t,1),B(t,2),'o','Color',[1 0.5 0.5]);  
                end
            else  
                if types(t) == 9  
                    plot(B(t,1),B(t,2),'sk');
                     C{9}=[C{9};B(t,1),B(t,2)];
                else  
                    plot(B(t,1),B(t,2),'ok');  
                end  
            end  

        end
        %% 
  
%         p=[size(C{1},1),size(C{2},1)];      
       
        p=[size(C{1},1),size(C{2},1),size(C{3},1),size(C{4},1),size(C{5},1),size(C{6},1),size(C{7},1),size(C{8},1),size(C{9},1)];
        [~,sortClass]=sort(p,'descend');
        CM1=cell2mat(C(sortClass(2)));
        CM2=cell2mat(C(sortClass(3)));
        CM3=cell2mat(C(sortClass(4)));
            %% contrast

    %         windowSize=29;
    %         nHood = ones(windowSize);
    %         sdImage = stdfilt(Ir , nHood);
    %         figure
    %         colormap('hot');   % set colormap
    %          imagesc(sdImage);        % draw image and scale colormap to values range
    %          colorbar; 
    end
        xmin1=min(CM1(:,1));
        xmax1=max(CM1(:,1));
        ymin1=min(CM1(:,2));
        ymax1=max(CM1(:,2));
        width1=100;
        height1=100;
%         width1=xmax1-xmin1;
%         height1=ymax1-ymin1;
        x1=(xmin1+xmax1)/2;
        y1=(ymin1+ymax1)/2;
   
        hold on
        rectangle('Position',[x1-width1/2, y1-width1/2,width1,height1], 'EdgeColor', 'g','LineWidth',1);
        
        
%         rectangle('Position',[x-width/2, y-width/2,width,height], 'EdgeColor', 'g');
%         D=Ir((y-width/2):(y+width/2),(x-width/2):(x+width/2));
%         rectangle('Position',[y-width/2, x-width/2,width,height], 'EdgeColor', 'g');
       
        xmin2=min(CM2(:,1));
        xmax2=max(CM2(:,1));
        ymin2=min(CM2(:,2));
        ymax2=max(CM2(:,2));
%         width=100;
%         height=100;
%         width2=xmax2-xmin2;
%         height2=ymax2-ymin2;
        width2=150;
        height2=150;
        x2=(xmin2+xmax2)/2;
        y2=(ymin2+ymax2)/2;
    
        hold on
        rectangle('Position',[x2-width1/2, y2-width1/2,width1,height1], 'EdgeColor', 'g','LineWidth',1);
        
        xmin3=min(CM3(:,1));
        xmax3=max(CM3(:,1));
        ymin3=min(CM3(:,2));
        ymax3=max(CM3(:,2));
        width3=150;
        height3=150;
        x3=(xmin3+xmax3)/2;
        y3=(ymin3+ymax3)/2;
        hold on
        rectangle('Position',[x3-width1/2, y3-width1/2,width1,height1], 'EdgeColor', 'g','LineWidth',1);
        tic
        D1=Ir((y1-height1/2):(y1+height1/2),(x1-width1/2):(x1+width1/2));
        D2=Ir((y2-height1/2):(y2+height1/2),(x2-width1/2):(x2+width1/2));
        D3=Ir((y3-height1/2):(y3+height1/2),(x3-width1/2):(x3+width1/2));
        t4=toc;
        figure(5)
        imshow(D1)
%         E = real(ifft2(fft2(I0{i}).*fft2(D,size(I0{i},1),size(I0{i},2))));
%         figure(6)
%         imshow(E,[])
       %% 
%         [m,n]=find(E==max(E(:)))
%         thresh = 0.99*max(E(:));
%         F= E > thresh;
%         se = strel('disk',5);
%         G = imdilate(F,se);
%         figure(7)
%         imshow(G)

     %%
     figure(6)
        FFT1=fft2((I00{i}));
        FFT2=fft2((D1),size(I00{i},1),size(I00{i},2));
        Norm1=FFT1.*conj(FFT2)./abs(FFT1.*conj(FFT2));
        result1=real(ifft2(Norm1));
%         surf(result1);
% %         shading flat;
%         ax = gca; % current axes
%         ax.FontSize = 14;
        
        [m,n]=find(result1==max(result1(:)));
        thresh = 0.8*max(result1(:));
        F= result1 > thresh;
        se = strel('disk',30);
        G = imdilate(F,se);
%         figure(7)
%         imshow(G)
        
        FFT11=fft2((I00{i}));
        FFT22=fft2((D2),size(I00{i},1),size(I00{i},2));
        Norm2=FFT11.*conj(FFT22)./abs(FFT11.*conj(FFT22));
        result2=real(ifft2(Norm2));
        
        FFT111=fft2((I00{i}));
        FFT222=fft2((D3),size(I00{i},1),size(I00{i},2));
        Norm3=FFT111.*conj(FFT222)./abs(FFT111.*conj(FFT222));
        result3=real(ifft2(Norm3));
        %% 
%         FFT=fft2(I0{i}).*fft2(D,size(I0{i},1),size(I0{i},2));
%         absIFFT=abs(ifft2(FFT));
%         figure(9)
%         mesh(absIFFT)
%         ax = gca; % current axes
%         ax.FontSize = 14;


        %% 
        tic
        [m1 n1]=find(result1==max(result1(:)))
        [m11 n11]=find(result2==max(result2(:)))
        [m111 n111]=find(result3==max(result3(:)))
        t5=toc
    figure(8)
         hAx  = axes;
        position1 = [n1, m1,width1 ,height1 ];
        position2 = [n11, m11,width2 ,height2 ];
        position3 = [n111, m111,width3 ,height3 ];
        imshow(I00{i},[], 'Parent', hAx);
%         imrect(hAx, position1);
%         imrect(hAx, position2);
%         imrect(hAx, position3);
       rectangle('Position',[xmin1, ymin1,width1,height1], 'EdgeColor', 'g','LineWidth',1);
       hold on
              rectangle('Position',[xmin2, ymin2,width1,height1], 'EdgeColor', 'g','LineWidth',1);
              hold on
                     rectangle('Position',[xmin3, ymin3,width1,height1], 'EdgeColor', 'g','LineWidth',1);
        %% error
        real1=[xmin1,ymin1,1];
        xerror1=real1(1)-n1
        yerror1=real1(2)-m1
        
       real2=[xmin2,ymin2,1];
        xerror2=real2(1)-n11
        yerror2=real2(2)-m11
        
        real3=[xmin3,ymin3,1];
        xerror3=real3(1)-n111
        yerror3=real3(2)-m111
        t=t1+t2+t3+t4
        %%         

%         thresh = 0.99*max(result(:));
%         F= result > thresh;
%         se = strel('disk',5);
%         G = imdilate(F,se);
%         figure(8)
%         imshow(G)
      
end
