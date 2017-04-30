%variable need to check 
%     1)path
%     2)iamge format
%     3)location size angle file
%     4)if dimensions of desc pts angle kdesc  are consistent
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

dakaze1=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\desc1.txt');
dakaze2=importdata('E:\MyResearch\paper\image\descriptor\Colles\rotate\desc2.txt');

aa=0.02;
% img1akaze=[region1(:,1) region1(:,2) ones(size(region1,1),1).*aa zeros(size(region1,1),1) ones(size(region1,1),1).*aa double(dakaze1)];
% img2akaze=[region2(:,1) region2(:,2) ones(size(region2,1),1).*aa zeros(size(region2,1),1) ones(size(region2,1),1).*aa double(dakaze2)];
img1akaze=[region1(:,1) region1(:,2) region1(:,3)*aa zeros(size(region1,1),1) region1(:,3)*aa double(dakaze1)];
img2akaze=[region2(:,1) region2(:,2) region2(:,3)*aa zeros(size(region2,1),1) region2(:,3)*aa double(dakaze2)];
p1 = [61;size(img1akaze,1)];
p2 = [61;size(img2akaze,1)];
q1 = double(img1akaze);
q2 = double(img2akaze);
save('img1akaze.txt','p1','q1','-ascii')
save('img2akaze.txt','p2','q2','-ascii')
%% 
H=importdata(strcat('E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\2.txt'));
[v_overlap, v_repeatability, v_nb_of_corespondences,matching_score,nb_of_matches,twi] = repeatability('img1akaze.txt', 'img2akaze.txt',H, 'E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\1.jpg','E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\2.jpg',0);
v_nb_of_corespondencesakaze=v_nb_of_corespondences;
v_repeatabilityakaze=v_repeatability;

[correct_match_nn,total_match_nn,correct_match_sim,total_match_sim,correct_match_rn,total_match_rn,recall,precision] = descperf('img1akaze.txt','img2akaze.txt',H,'E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\1.jpg','E:\MyResearch\paper\image\descriptor\Colles\rotate\vsimage\2.jpg',v_nb_of_corespondences,twi);
recallakaze=recall;
precisionakaze=precision;
% figure 
% display_features('img1akaze.txt', 'E:\MyResearch\paper\image\descriptor\Colles\rotate\1.jpg',1,1) 
% figure
% plot(v_overlap,v_repeatability);
figure
plot(precision,recall);

save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','v_nb_of_corespondencesakaze.mat'],'v_nb_of_corespondencesakaze')
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','v_repeatabilityakaze.mat'],'v_repeatabilityakaze')
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','recallakaze.mat'],'recallakaze')
save(['E:\MyResearch\paper\image\descriptor\Colles\rotate\','precisionakaze.mat'],'precisionakaze')
mainsurf;
mainbrisk;
mainfreak;
mainkaze;
mainsift;
