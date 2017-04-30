clc
v_nb_of_corespondencesbrisk=[];
v_repeatabilitybrisk=[];
for i=2:1:6

    str=num2str(i);
    original=imread('E:\MyResearch\paper\image\detector\Colles\view\1.PNG');
    distorted=imread(strcat('E:\MyResearch\paper\image\detector\Colles\view\',str,'.PNG'));
% ptsoriginalmser  = detectMSERFeatures(rgb2gray(original));
% ptsdistortedmser = detectMSERFeatures(rgb2gray(distorted));
%  a=[ptsoriginalmser.Location ptsoriginalmser.Axes ptsoriginalmser.Orientation  ];
%  b=[ptsdistortedmser.Location ptsdistortedmser.Axes  ptsdistortedmser.Orientation];
% 
 aa=1;
    if length(size(original))==3&&length(size(distorted))==3
        original=im2double(rgb2gray(original));
        distorted=im2double(rgb2gray(distorted));
    end
points1=detectBRISKFeatures(original);
points2=detectBRISKFeatures(distorted);

[featuresoriginalsurf,validptsoriginalbrisk]=extractFeatures(original,points1,'Method','SURF');
[featuresdistortedsurf,validptsdistortedbrisk]=extractFeatures(distorted,points2,'Method','SURF');

loc1=points1.Location;
S1=points1.Scale;
O1=validptsoriginalbrisk.Orientation;

loc2=points2.Location;
S2=points2.Scale;
O2=validptsdistortedbrisk.Orientation;

initial=1;
intervall=1;
endnum1=size(loc1,1);
endnum2=size(loc2,1);
img1brisk=[loc1(initial:intervall:endnum1,1) loc1(initial:intervall:endnum1,2) ones(size(initial:intervall:endnum1,2) ,1).*aa zeros(size(initial:intervall:endnum1,2),1).*aa ones(size(initial:intervall:endnum1,2),1)];
img2brisk=[loc2(initial:intervall:endnum2,1) loc2(initial:intervall:endnum2,2) ones(size(initial:intervall:endnum2,2) ,1).*aa zeros(size(initial:intervall:endnum2,2),1).*aa ones(size(initial:intervall:endnum2,2),1)];
p1 = [1.0;size(img1brisk,1)];
p2 = [1.0;size(img2brisk,1)];
q1 = double(img1brisk);
q2 = double(img2brisk);
save('img1brisk.txt','p1','q1','-ascii')
save('img2brisk.txt','p2','q2','-ascii')
H=importdata(strcat('E:\MyResearch\paper\image\detector\Colles\view\',num2str(i),'.txt'));
[v_overlap, v_repeatability, v_nb_of_corespondences,matching_score,nb_of_matches] = repeatability('img1brisk.txt', 'img2brisk.txt',H, 'E:\MyResearch\paper\image\detector\Colles\view\1.PNG',strcat('E:\MyResearch\paper\image\detector\Colles\view\',str,'.PNG'),1);
v_nb_of_corespondencesbrisk=[v_nb_of_corespondencesbrisk v_nb_of_corespondences];
v_repeatabilitybrisk=[v_repeatabilitybrisk v_repeatability];
% % [v_overlap,v_repeatability,v_nb_of_corespondences,matching_score,nb_of_matches,twi] = repeatability('img1.haraff.sift','img2.haraff.sift','H1to2p','img1.ppm','img2.ppm',0);
% % [correct_match_nn,total_match_nn,correct_match_sim,total_match_sim,correct_match_rn,total_match_rn] = descperf('img1.haraff.sift','img2.haraff.sift','H1to2p','img1.ppm','img2.ppm',v_nb_of_corespondences(5),twi);
% % figure 
% display_features('img1harris.txt', '30.PNG',1,1) 
% figure
% plot(v_overlap,v_repeatability);
 end
save(['E:\MyResearch\paper\image\detector\Colles\view\','v_nb_of_corespondencesbrisk2_6.mat'],'v_nb_of_corespondencesbrisk')
save(['E:\MyResearch\paper\image\detector\Colles\view\','v_repeatabilitybrisk2_6.mat'],'v_repeatabilitybrisk')