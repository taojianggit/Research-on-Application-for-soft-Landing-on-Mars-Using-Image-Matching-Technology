clc
v_nb_of_corespondencesbrisk=[];
v_repeatabilitybrisk=[];
for i=40:10:80
    
    str=num2str(i);
    original=imread('30.png');
    distorted=imread(strcat(str,'.png'));
% ptsoriginalmser  = detectMSERFeatures(rgb2gray(original));
% ptsdistortedmser = detectMSERFeatures(rgb2gray(distorted));
%  a=[ptsoriginalmser.Location ptsoriginalmser.Axes ptsoriginalmser.Orientation  ];
%  b=[ptsdistortedmser.Location ptsdistortedmser.Axes  ptsdistortedmser.Orientation];
% 
 aa=0.004;

points1=detectBRISKFeatures(rgb2gray(original));
points2=detectBRISKFeatures(rgb2gray(distorted));

[featuresoriginalsurf,validptsoriginalbrisk]=extractFeatures(rgb2gray(original),points1,'Method','SURF');
[featuresdistortedsurf,validptsdistortedbrisk]=extractFeatures(rgb2gray(distorted),points2,'Method','SURF');

loc1=points1.Location;
S1=points1.Scale;
O1=validptsoriginalbrisk.Orientation;

loc2=points2.Location;
S2=points2.Scale;
O2=validptsdistortedbrisk.Orientation;

initial=1;
intervall=1;
endnum=min(size(loc1,1),size(loc2,1));
img1brisk=[loc1(initial:intervall:endnum,1) loc1(initial:intervall:endnum,2) S1(initial:intervall:endnum).*aa S1(initial:intervall:endnum).*aa O1(initial:intervall:endnum)];
img2brisk=[loc2(initial:intervall:endnum,1) loc2(initial:intervall:endnum,2) S2(initial:intervall:endnum).*aa S2(initial:intervall:endnum).*aa O2(initial:intervall:endnum)];
p1 = [1.0;size(img1brisk,1)];
p2 = [1.0;size(img2brisk,1)];
q1 = double(img1brisk);
q2 = double(img2brisk);
save('img1brisk.txt','p1','q1','-ascii')
save('img2brisk.txt','p2','q2','-ascii')
H=importdata('H.txt');
[v_overlap, v_repeatability, v_nb_of_corespondences,matching_score,nb_of_matches] = repeatability('img1brisk.txt', 'img2brisk.txt',H, '30.png',sprintf('%d.png',i),1);
v_nb_of_corespondencesbrisk=[v_nb_of_corespondencesbrisk v_nb_of_corespondences];
v_repeatabilitybrisk=[v_repeatabilitybrisk v_repeatability];
% % [v_overlap,v_repeatability,v_nb_of_corespondences,matching_score,nb_of_matches,twi] = repeatability('img1.haraff.sift','img2.haraff.sift','H1to2p','img1.ppm','img2.ppm',0);
% % [correct_match_nn,total_match_nn,correct_match_sim,total_match_sim,correct_match_rn,total_match_rn] = descperf('img1.haraff.sift','img2.haraff.sift','H1to2p','img1.ppm','img2.ppm',v_nb_of_corespondences(5),twi);
% % figure 
% display_features('img1harris.txt', '30.png',1,1) 
% figure
% plot(v_overlap,v_repeatability);
 end
