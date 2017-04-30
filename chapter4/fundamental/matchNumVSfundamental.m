clc
clear;
figure
x=[42,48,51,52,61,62,66,69,70,72];
y1=[0.0158,0.0153,0.0125,0.0184,0.0161,0.0184,0.0173,0.0123,0.0195,0.0197];
y2=[1.0317,0.9635,0.8992,1.0480,1.2495,1.5819,1.2591,1.1353,1.2212,1.1917];

yyaxis left
p1=plot(x,y1);
ylim(  [ 0 0.05 ] );
xlim(  [ 40 75 ] );
ylabel('mean remaining error ','FontSize',14)

yyaxis right
p2=plot(x,y2);
ylim( [ 0 5 ] );
ylabel('mean epipolar distance ','FontSize',14)

set(gca,'FontSize',14);
p1.LineWidth =2;
p1.MarkerSize=5;
p1.MarkerEdgeColor=[0,0,0 ];
p1.MarkerFaceColor='w';
p2.LineWidth =2;
p2.MarkerSize=5;
p2.MarkerEdgeColor=[0,0,0 ];
p2.MarkerFaceColor='w';

xlabel('matched features','FontSize',14)

legend('mean remaining error ','mean epipolar distance','Location','northeast','FontSize',18')

ax = gca;
grid on
ax.GridLineStyle = ':';
ax.GridColor = [0 0 0];
ax.LineWidth=0.6;
ax.GridAlpha = 1;
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');