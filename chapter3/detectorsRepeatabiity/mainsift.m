clc
v_nb_of_corespondencess=[];
v_repeatabilitys=[];
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

[descriptors1, locs1]=sift(original);
[descriptors2, locs2]=sift(distorted);
initial=1;
intervall=1;
endnum1=size(locs1,1);
endnum2=size(locs2,1);
img1sift=[locs1(initial:intervall:endnum1,2) locs1(initial:intervall:endnum1,1) ones(size(initial:intervall:endnum1,2) ,1).*aa zeros(size(initial:intervall:endnum1,2),1).*aa ones(size(initial:intervall:endnum1,2) ,1)];
img2sift=[locs2(initial:intervall:endnum2,2) locs2(initial:intervall:endnum2,1) ones(size(initial:intervall:endnum2,2) ,1).*aa zeros(size(initial:intervall:endnum2,2),1).*aa ones(size(initial:intervall:endnum2,2) ,1)];
p1 = [1.0;size(img1sift,1)];
p2 = [1.0;size(img2sift,1)];
q1 = img1sift;
q2 = img2sift;
save('img1sift.txt','p1','q1','-ascii')
save('img2sift.txt','p2','q2','-ascii')

% region11=round([locs1(:,2) locs1(:,1)]);
% region22=round([locs2(:,2) locs2(:,1)]);
% H = testhomog_vgg(original,distorted,region11,region22);
H=importdata(strcat('E:\MyResearch\paper\image\detector\Colles\view\',num2str(i),'.txt'));
[v_overlap, v_repeatability, v_nb_of_corespondences,matching_score,nb_of_matches] = repeatability('img1sift.txt', 'img2sift.txt',H, 'E:\MyResearch\paper\image\detector\Colles\view\1.PNG',strcat('E:\MyResearch\paper\image\detector\Colles\view\',str,'.PNG'),1);
v_nb_of_corespondencess=[v_nb_of_corespondencess v_nb_of_corespondences];
v_repeatabilitys=[v_repeatabilitys v_repeatability];

% % [v_overlap,v_repeatability,v_nb_of_corespondences,matching_score,nb_of_matches,twi] = repeatability('img1.haraff.sift','img2.haraff.sift','H1to2p','img1.ppm','img2.ppm',0);
% % [correct_match_nn,total_match_nn,correct_match_sim,total_match_sim,correct_match_rn,total_match_rn] = descperf('img1.haraff.sift','img2.haraff.sift','H1to2p','img1.ppm','img2.ppm',v_nb_of_corespondences(5),twi);
% % figure 
% display_features('img1harris.txt', '30.PNG',1,1) 
% figure
% plot(v_overlap,v_repeatability);
 end
save(['E:\MyResearch\paper\image\detector\Colles\view\','v_nb_of_corespondencess2_6.mat'],'v_nb_of_corespondencess')
save(['E:\MyResearch\paper\image\detector\Colles\view\','v_repeatabilitys2_6.mat'],'v_repeatabilitys')
beep