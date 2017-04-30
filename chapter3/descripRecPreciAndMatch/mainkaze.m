clc
clear


%% region
pts1=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\pts1.txt');
angle1=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\kpts1angle.txt');
size1=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\kpts1size.txt');

pts2=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\pts2.txt');
angle2=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\kpts2angle.txt');
size2=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\kpts2size.txt');


angle1=deg2rad(angle1);
for i=1:size(angle1)
    if angle1(i)>3.1416
        angle1(i)=-(2*pi-angle1(i));
    end
end
angle2=deg2rad(angle2);
for i=1:size(angle2)
    if angle2(i)>3.1416
        angle2(i)=-(2*pi-angle2(i));
    end
end

region1=[pts1 size1 angle1];
region2=[pts2 size2 angle2];
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','region1.mat'],'region1')
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','region2.mat'],'region2')

dkaze1=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\kdesc1.txt');
dkaze2=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\kdesc2.txt');

aa=0.02;
% img1kaze=[region1(:,1) region1(:,2) ones(size(region1,1),1).*aa zeros(size(region1,1),1) ones(size(region1,1),1).*aa double(dkaze1)];
% img2kaze=[region2(:,1) region2(:,2) ones(size(region2,1),1).*aa zeros(size(region2,1),1) ones(size(region2,1),1).*aa double(dkaze2)];
img1kaze=[region1(:,1) region1(:,2) region1(:,3)*aa zeros(size(region1,1),1) region1(:,3)*aa double(dkaze1)];
img2kaze=[region2(:,1) region2(:,2) region2(:,3)*aa zeros(size(region2,1),1) region2(:,3)*aa double(dkaze2)];
p1 = [64;size(img1kaze,1)];
p2 = [64;size(img2kaze,1)];
q1 = double(img1kaze);
q2 = double(img2kaze);
save('img1kaze.txt','p1','q1','-ascii')
save('img2kaze.txt','p2','q2','-ascii')
%% 
H=importdata(strcat('E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\2.txt'));
[v_overlap, v_repeatability, v_nb_of_corespondences,matching_score,nb_of_matches,twi] = repeatability('img1kaze.txt', 'img2kaze.txt',H, 'E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\1.jpg','E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\2.jpg',0);
v_nb_of_corespondenceskaze=v_nb_of_corespondences;
v_repeatabilitykaze=v_repeatability;

[correct_match_nn,total_match_nn,correct_match_sim,total_match_sim,correct_match_rn,total_match_rn,recall,precision] = descperf('img1kaze.txt','img2kaze.txt',H,'E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\1.jpg','E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\2.jpg',v_nb_of_corespondences,twi);
recallkaze=recall;
precisionkaze=precision;
% figure 
% display_features('img1kaze.txt', 'E:\MyResearch\paper\image\descriptor\Colles\rotate\1.jpg',1,1) 
% figure
% plot(v_overlap,v_repeatability);jpg
figure
plot(precision,recall);
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','v_nb_of_corespondenceskaze.mat'],'v_nb_of_corespondenceskaze')
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','v_repeatabilitykaze.mat'],'v_repeatabilitykaze')
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','recallkaze.mat'],'recallkaze')
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','precisionkaze.mat'],'precisionkaze')