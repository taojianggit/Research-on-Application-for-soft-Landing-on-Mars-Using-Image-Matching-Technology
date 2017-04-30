clc
clear

v_nb_of_corespondencesk=[];
v_repeatabilityk=[];
aa=1;
alpha=0.04;
 for i=2:6
str=num2str(i);
region1=importdata('E:\MyResearch\paper\image\detector\Colles\view\vsimage\kaze1.txt');%txt file should change all semicolon into comma; or change all comma into semicolon
region2=importdata(strcat('E:\MyResearch\paper\image\detector\Colles\view\vsimage\kaze',str,'.txt'));

img1kaze=[region1(:,1) region1(:,2) ones(size(region1,1),1).*aa zeros(size(region1,1),1) ones(size(region1,1),1).*aa ];
img2kaze=[region2(:,1) region2(:,2) ones(size(region2,1),1).*aa zeros(size(region2,1),1) ones(size(region2,1),1).*aa ];
p1 = [1.0;size(img1kaze,1)];
p2 = [1.0;size(img2kaze,1)];
q1 = img1kaze;
q2 = img2kaze;
save('img1kaze.txt','p1','q1','-ascii')
save('img2kaze.txt','p2','q2','-ascii')

H=importdata(strcat('E:\MyResearch\paper\image\detector\Colles\view\vsimage\',num2str(i),'.txt'));
[v_overlap, v_repeatability, v_nb_of_corespondences,matching_score,nb_of_matches] = repeatability('img1kaze.txt', 'img2kaze.txt',H, 'E:\MyResearch\paper\image\detector\Colles\view\vsimage\1.png',strcat('E:\MyResearch\paper\image\detector\Colles\view\vsimage\',str,'.png'),1);
v_nb_of_corespondencesk=[v_nb_of_corespondencesk v_nb_of_corespondences];
v_repeatabilityk=[v_repeatabilityk v_repeatability];
% % [v_overlap,v_repeatability,v_nb_of_corespondences,matching_score,nb_of_matches,twi] = repeatability('img1.haraff.sift','img2.haraff.sift','H1to2p','img1.ppm','img2.ppm',0);
% % [correct_match_nn,total_match_nn,correct_match_sim,total_match_sim,correct_match_rn,total_match_rn] = descperf('img1.haraff.sift','img2.haraff.sift','H1to2p','img1.ppm','img2.ppm',v_nb_of_corespondences(5),twi);
% % figure 
% display_features('img1harris.txt', '30.png',1,1) 
% figure
% plot(v_overlap,v_repeatability);
 end
save(['E:\MyResearch\paper\image\detector\Colles\view\','v_nb_of_corespondencesk2_6.mat'],'v_nb_of_corespondencesk')
save(['E:\MyResearch\paper\image\detector\Colles\view\','v_repeatabilityk2_6.mat'],'v_repeatabilityk')
