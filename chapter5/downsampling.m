%This code plots Fig5.1 and tab5.1
clc
clear;

IMG={'Jezero Crater','Mawrth Vallis','Southwest Melas Chasma Landforms','Nili Fossae','Northeastern Syrtis Major Planitia'};
a=[];
b=[];
c=[];
for i=1
I0{i}=imread(strcat('E:\MyResearch\paper\image\Mars2020\',IMG{i},'\altitudeVSmatch.jpg'));
I0{i}=rgb2gray(I0{i});
% I0{i}=testlocalnormalize(I0{i});
% I0{i} = mapminmax(I0{i},0,255);
for j=35
        I1=imresize(I0{i},1/(10-0.2*j));
        
        ptsOriginal  = detectSURFFeatures(I0{i});
%         figure
%         imshow(I0{i}); hold on;
%         plot( ptsOriginal.Location(:,1),ptsOriginal.Location(:,2),'rs');
        
        ptsDistorted = detectSURFFeatures(I1); 
        figure
        imshow(I1); hold on;
        plot(ptsDistorted.Location(:,1),ptsDistorted.Location(:,2),'rs');
        
        [featuresOriginal,validPtsOriginal] = extractFeatures(I0{i}, ptsOriginal);
        [featuresDistorted,validPtsDistorted] = extractFeatures(I1,ptsDistorted);
        index_pairs = matchFeatures(featuresOriginal,featuresDistorted);
        matchedPtsOriginal  = validPtsOriginal(index_pairs(:,1));
        matchedPtsDistorted = validPtsDistorted(index_pairs(:,2));
        [tform,inlierPtsDistorted,inlierPtsOriginal] = estimateGeometricTransform(matchedPtsDistorted,matchedPtsOriginal,'projective');
        b=[b,size(index_pairs,1)];
%         c=[c,size(featuresDistorted,1)];
%         a=[a,size(ptsOriginal,1)];
end
end
%% DBSCAN
% [class,type]=DBSCAN(ptsDistorted.Location,2);
% figure;clf
% imshow(I1)
% hold on
% ptsymb = {'bo','ro','go',',mo','c+'};
% MarkFace = {[0 0 1],[.8 0 0],[0 .5 0]};
% class=class+1;
% x0=[];
% y0=[];
% for i =3
%     clust = find(class == i);
%     x=ptsDistorted.Location(clust,1);
%     y=ptsDistorted.Location(clust,2);
%     
% plot(ptsDistorted.Location(clust,1),ptsDistorted.Location(clust,2),ptsymb{i},'MarkerSize',3,'MarkerFace',MarkFace{i},'MarkerEdgeColor','black');
% x0=[x0 x];
% y0=[y0 y];
% xmin=min(x0(:));
% xmax=max(x0(:));
% ymin=min(y0(:));
% ymax=max(y0(:));
% width=xmax-xmin;
% height=ymax-ymin;
% hold on
% rectangle('Position', [xmin+width/2, ymin*2+width/2,width/2,height/2], 'EdgeColor', 'red');
% %             plot(type(i,1),type(i,2),ptsymb{i},'MarkerSize',10,'MarkerFace',MarkFace{i});
% end
        

        %% kmeans
        
%         [cidx2,cmeans2,sumd2,D2] = kmeans(ptsDistorted.Location,2,'dist','sqEuclidean');
%         P2 = figure;clf;
%         [silh2,h2] = silhouette(ptsDistorted.Location,cidx2,'sqeuclidean');
%         eucD = pdist(ptsDistorted.Location,'euclidean');
%         clustTreeEuc = linkage(eucD,'average');
%         cophenet(clustTreeEuc,eucD);
%         P3 = figure;clf;
%         [h,nodes] =  dendrogram(clustTreeEuc,20);
%         set(gca,'TickDir','out','TickLength',[.002 0],'XTickLabel',[]);
%         [cidx3,cmeans3,sumd3,D3] = kmeans(ptsDistorted.Location,2,'dist','sqEuclidean');
%         P4 = figure;clf;
%         [silh3,h3] = silhouette(ptsDistorted.Location,cidx3,'sqeuclidean');
%         
%         P5 = figure;clf
%         imshow(I1)
%         ptsymb = {'bo','ro','go',',mo','c+'};
%         MarkFace = {[0 0 1],[.8 0 0],[0 .5 0]};
%         hold on
%         for i =1:2
%             clust = find(cidx3 == i);
%             plot(ptsDistorted.Location(clust,1),ptsDistorted.Location(clust,2),ptsymb{i},'MarkerSize',3,'MarkerFace',MarkFace{i},'MarkerEdgeColor','black');
%             plot(cmeans3(i,1),cmeans3(i,2),ptsymb{i},'MarkerSize',10,'MarkerFace',MarkFace{i});
%         end
% hold off




%% probability cluster
% options = statset('Display','off');
% gm = gmdistribution.fit(ptsDistorted.Location,3,'Options',options);
% P6 = figure;clf
% scatter(ptsDistorted.Location(:,1),ptsDistorted.Location(:,2),10,'ro');
% hold on
% ezcontour(@(x,y) pdf(gm,[x,y]),[-15 15],[-15 10]);
% hold off
% P7 = figure;clf
% scatter(ptsDistorted.Location(:,1),ptsDistorted.Location(:,2),10,'ro');
% hold on
% ezsurf(@(x,y) pdf(gm,[x,y]),[-15 15],[-15 10]);
% hold off
% view(33,24)
%  
% 
% cluster1 = (cidx3 == 1);
% cluster3 = (cidx3 == 2);
% % 通过观察，K均值方法的第二类是gm的第三类
% cluster2 = (cidx3 == 3);
% % 计算分类概率
% P = posterior(gm,ptsDistorted.Location);
% P8 = figure;clf
% plot3(ptsDistorted.Location(cluster1,1),ptsDistorted.Location(cluster1,2),P(cluster1,1),'r.')
% grid on;hold on
% plot3(ptsDistorted.Location(cluster2,1),ptsDistorted.Location(cluster2,2),P(cluster2,2),'bo')
% plot3(ptsDistorted.Location(cluster3,1),ptsDistorted.Location(cluster3,2),P(cluster3,3),'g*')
% legend('第 1 类','第 2 类','第 3 类','Location','NW')
% clrmap = jet(80); colormap(clrmap(9:72,:))
% ylabel(colorbar,'Component 1 Posterior Probability')
% view(-45,20);
% % 第三类点部分概率值较低，可能需要其他数据来进行分析。
% % 概率图
% P9 = figure;clf
% [~,order] = sort(P(:,1));
% plot(1:size(ptsDistorted.Location,1),P(order,1),'r-',1:size(ptsDistorted.Location,1),P(order,2),'b-',1:size(ptsDistorted.Location,1),P(order,3),'y-');
% legend({'Cluster 1 Score' 'Cluster 2 Score' 'Cluster 3 Score'},'location','NW');
% ylabel('Cluster Membership Score');
% xlabel('Point Ranking');


%% 

B=2*(reshape(b,[25,5]))';
x=fliplr(2:0.125:5);
figure
p=plot(x,B(1,:),'-x',x,B(2,:),'-+',x,B(3,:),'-d',x,B(4,:),'-o',x,B(5,:),'-s');
set(gca,'FontSize',14);

p(1).LineWidth =2;
p(1).MarkerSize=5;
p(1).MarkerEdgeColor=[0,0,0 ];
p(1).MarkerFaceColor='w';

p(2).LineWidth =2;
p(2).MarkerSize=5;
p(2).MarkerEdgeColor=[0,0,0 ];
p(2).MarkerFaceColor='w';

p(3).LineWidth =2;
p(3).MarkerSize=5;
p(3).MarkerEdgeColor=[0,0,0 ];
p(3).MarkerFaceColor='w';

p(4).LineWidth =2;
p(4).MarkerSize=5;
p(4).MarkerEdgeColor=[0,0,0 ];
p(4).MarkerFaceColor='w';

p(5).LineWidth =2;
p(5).MarkerSize=5;
p(5).MarkerEdgeColor=[0,0,0 ];
p(5).MarkerFaceColor='w';
xlabel('altitude','FontSize',14)
ylabel('Number of matches','FontSize',14)
legend('Jezero Crater','Nili Fossae','Mawrth Vallis','NE Syrtis Major Planitia','SW Melas Chasma','Location','northeast','FontSize',18')

ax = gca;
grid on
ax.GridLineStyle = ':';
ax.GridColor = [0 0 0];
ax.LineWidth=0.6;
ax.GridAlpha = 1;
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');

%% 
% A=2*(reshape(a,[25,5]))';
% B=2*(reshape(b,[25,5]))';
% C=2*(reshape(c,[25,5]))';
% x=fliplr(2:0.125:5);
% figure
% p=plot(x,C(1,:),'-x',x,C(2,:),'-+',x,C(3,:),'-d',x,C(4,:),'-o',x,C(5,:),'-s');
% set(gca,'FontSize',14);
% 
% p(1).LineWidth =2;
% p(1).MarkerSize=5;
% p(1).MarkerEdgeColor=[0,0,0 ];
% p(1).MarkerFaceColor='w';
% 
% p(2).LineWidth =2;
% p(2).MarkerSize=5;
% p(2).MarkerEdgeColor=[0,0,0 ];
% p(2).MarkerFaceColor='w';
% 
% p(3).LineWidth =2;
% p(3).MarkerSize=5;
% p(3).MarkerEdgeColor=[0,0,0 ];
% p(3).MarkerFaceColor='w';
% 
% p(4).LineWidth =2;
% p(4).MarkerSize=5;
% p(4).MarkerEdgeColor=[0,0,0 ];
% p(4).MarkerFaceColor='w';
% 
% p(5).LineWidth =2;
% p(5).MarkerSize=5;
% p(5).MarkerEdgeColor=[0,0,0 ];
% p(5).MarkerFaceColor='w';
% xlabel('altitude','FontSize',14)
% ylabel('Number of features','FontSize',14)
% legend('Jezero Crater','Nili Fossae','Mawrth Vallis','NE Syrtis Major Planitia','SW Melas Chasma','Location','northeast','FontSize',18')
% 
% ax = gca;
% grid on
% ax.GridLineStyle = ':';
% ax.GridColor = [0 0 0];
% ax.LineWidth=0.6;
% ax.GridAlpha = 1;
% set(gca, 'XMinorTick', 'on');
% set(gca, 'YMinorTick', 'on');
%% figure
% A=2*(reshape(a,[25,5]))';
% B=2*(reshape(b,[25,5]))';
% C=2*(reshape(c,[25,5]))';
% x=fliplr(2:0.125:5);
% p=plot(x,A(1,:),'-x',x,A(2,:),'-+',x,A(3,:),'-d',x,A(4,:),'-o',x,A(5,:),'-s');
% set(gca,'FontSize',14);
% 
% p(1).LineWidth =2;
% p(1).MarkerSize=5;
% p(1).MarkerEdgeColor=[0,0,0 ];
% p(1).MarkerFaceColor='w';
% 
% p(2).LineWidth =2;
% p(2).MarkerSize=5;
% p(2).MarkerEdgeColor=[0,0,0 ];
% p(2).MarkerFaceColor='w';
% 
% p(3).LineWidth =2;
% p(3).MarkerSize=5;
% p(3).MarkerEdgeColor=[0,0,0 ];
% p(3).MarkerFaceColor='w';
% 
% p(4).LineWidth =2;
% p(4).MarkerSize=5;
% p(4).MarkerEdgeColor=[0,0,0 ];
% p(4).MarkerFaceColor='w';
% 
% p(5).LineWidth =2;
% p(5).MarkerSize=5;
% p(5).MarkerEdgeColor=[0,0,0 ];
% p(5).MarkerFaceColor='w';
% xlabel('altitude','FontSize',14)
% ylabel('Number of features','FontSize',14)
% legend('Jezero Crater','Nili Fossae','Mawrth Vallis','NE Syrtis Major Planitia','SW Melas Chasma','Location','northeast','FontSize',18')
% 
% ax = gca;
% grid on
% ax.GridLineStyle = ':';
% ax.GridColor = [0 0 0];
% ax.LineWidth=0.6;
% ax.GridAlpha = 1;
% set(gca, 'XMinorTick', 'on');
% set(gca, 'YMinorTick', 'on');
