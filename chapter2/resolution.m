% Fig2.4 Altitude VS Resolution
% This code describes resolution of descend camera and satellite camera.

% Y = [0.25, 0.35;
%      0.25, 0.35;
%      0.25, 0.35;
%      0.25, 0.35];
% figure
% basevalue = 0.25;
% area(2:5,Y,basevalue)
x=[2,5];
y1=[0.25,0.25];
figure
p1=line(x,y1);
p1.LineWidth=2;
p1.Color=[1 0 1];

hold on

p=plot(x,2*x*tan(0.76/2));
p.LineWidth=2;
p.Color=[53/255,42/255,134/255];
set(gca,'FontSize',16);
xlabel('altitude/(km)','FontSize',16)
ylabel('resolution/(m/pixel)','FontSize',16)
legend({'Descent Camera','Satellite Camera'},'Location','northwest','FontSize',16)
ax = gca;

grid on
ax.GridLineStyle = ':';
ax.GridColor = [0 0 0];
ax.LineWidth=0.6;
ax.GridAlpha = 1;
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');

