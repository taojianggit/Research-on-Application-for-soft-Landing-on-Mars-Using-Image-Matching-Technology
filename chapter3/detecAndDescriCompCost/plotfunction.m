% 1.Fig3.2 Number of detected features VS Times
% 2.This code is just a plot function, describling 7 detecots' computation cost.
figure
surfNum=[1252 841 254 97];
surfTime=[0.1473 0.1270 0.1111 0.0979];

akazeNum=[2690 1847 586 324];
akazeTime=[0.7770 0.7293 0.6540 0.6411];

kazeNum=[2631 1683 622 399];
kazeTime=[1.3956 1.3841 1.3536 1.3356];

briskNum=[580 332 116 46];
briskTime=[0.0210 0.0142 0.0117 0.0084];

mserNum=[1529 811 385 14];
mserTime=[0.7789 0.4362 0.2436 0.0768];

harrisNum=[2491 1095 969 226];
harrisTime=[0.1308 0.1301 0.1261 0.1250];

siftNum=[1665 1522 1428 942];
siftTime=[0.3713 0.2766 0.2693 0.2635];


p=plot(surfNum,surfTime,'-+',akazeNum,akazeTime,'-s',kazeNum,kazeTime,'-o',briskNum,briskTime,'-p',mserNum,mserTime,'-x',harrisNum,harrisTime,'-h',siftNum,siftTime,'-*');
% 20:10:60,v_repeatabilitysu,'-g+',
% 20:10:60,v_repeatabilityh,'-bs',
set( p, 'linesmoothing', 'on' );

p(1).LineWidth =2;
p(1).MarkerSize=6;
p(1).MarkerEdgeColor=[0,0,0 ];
p(1).MarkerFaceColor='w';

p(2).LineWidth =2;
p(2).MarkerSize=6;
p(2).MarkerEdgeColor=[0,0,0 ];
p(2).MarkerFaceColor='w';

p(3).LineWidth =2;
p(3).MarkerSize=6;
p(3).MarkerEdgeColor=[0,0,0 ];
p(3).MarkerFaceColor='w';

p(4).LineWidth =2;
p(4).MarkerSize=6;
p(4).MarkerEdgeColor=[0,0,0 ];
p(4).MarkerFaceColor='w';

p(5).LineWidth =2;
p(5).MarkerSize=6;
p(5).MarkerEdgeColor=[0,0,0 ];
p(5).MarkerFaceColor='w';

p(6).LineWidth =2;
p(6).MarkerSize=6;
p(6).MarkerEdgeColor=[0,0,0 ];
p(6).MarkerFaceColor='w';

p(7).LineWidth =2;
p(7).MarkerSize=6;
p(7).MarkerEdgeColor=[0,0,0 ];
p(7).MarkerFaceColor='w';

ax=gca;
grid on
ax.GridLineStyle = ':';
ax.GridColor = [0 0 0];
ax.LineWidth=0.6;
ax.GridAlpha = 1;
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');

xlabel('Number of detected features','FontSize',14')
ylabel('Time/s','FontSize',14')
legend({'SURF','AKAZE','KAZE','BRISK','MSER','HARRIS','SIFT'},'FontSize',14,'Location','northeast')

