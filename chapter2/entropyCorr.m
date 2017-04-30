% 1.Fig2.2 Entropy VS Correlation Coefficient
% 2.This code is entropy and correlation coeffient of 5 candidate landing sites.

clc
clear
IMG = {'Jezero Crater','Mawrth Vallis','Southwest Melas Chasma Landforms','Nili Fossae','Northeastern Syrtis Major Planitia'};

for j = 1:5
    I{j} = imread(strcat('C:\Users\Public\Mars2020\',IMG{j},'\1.jpg'));
    for i = 1:16
        Ii = I{j}(500*(i-1)+1:500*i,:);
        Data{i} = Ii;
        E(i) = entropy(Data{i});
        DataRe{i} = imresize(Ii,1.001);
        [m,n] = size(DataRe{i});
        DataCr{i} = imcrop(DataRe{i},[0 0 2048 500]);
        Corr(i) = corr2(DataCr{i},Data{i}(1:size(DataCr{i},1),1:size(DataCr{i},2)));
    end
    F{j} = E;
    C{j} = Corr;
end

scatter(F{1},C{1},'x');
hold on
scatter(F{2},C{2},'filled','o');
hold on
scatter(F{3},C{3},'d');
hold on
scatter(F{4},C{4},'filled','o');
hold on
scatter(F{5},C{5},'filled','s');
legend({'Jezero Crater','Mawrth Vallis','SW Melas','Nili Fossae','NE Syrtis'},'FontSize',14,'Location','best')
xlabel('Entropy','FontSize',14)
ylabel('Correlation Coefficient','FontSize',14)
ax = gca;
grid on
ax.GridLineStyle = ':';
ax.GridColor = [0 0 0];
ax.LineWidth = 0.8;
ax.GridAlpha = 1;
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');
set(gca,'FontSize',14);

