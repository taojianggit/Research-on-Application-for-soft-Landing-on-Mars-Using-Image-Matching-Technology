%This code plots Fig5.12
clc
clear
a=0.7988*5;
b=0.7988*4;
c=0.7988*3;
%% position1 

% h=5km

x15=[1 1 1 8 1 1 2 8 1 1 2 8];
y15=[1 1 3 4 1 2 3 4 1 2 3 4];

RMSE15x=rms(x15);
RMSE15y=rms(y15);

% h=4km

x14=[2 1 1 5 2 1 1 5 2 1 1 5];
y14=[1 1 1 1 1 1 2 3 1 1 2 3];

RMSE14x=rms(x14);
RMSE14y=rms(y14);

% h=3km

x13=[1 1 1 3 1 1 1 2 2 1 1 1];
y13=[1 1 1 1 1 1 1 2 1 1 1 1];

RMSE13x=rms(x13);
RMSE13y=rms(y13);

x=[5 4 3];
figure(1)
p=plot(x,[a*RMSE15x,b*RMSE14x,c*RMSE13x],'-s',x,[a*RMSE15y,b*RMSE14y,c*RMSE13y],'-o');
set(gca,'FontSize',18,'Xdir','reverse');

p(1).LineWidth =2;
p(1).MarkerSize=5;
p(1).MarkerEdgeColor=[0,0,0 ];
p(1).MarkerFaceColor='w';
p(2).LineWidth =2;
p(2).MarkerSize=5;
p(2).MarkerEdgeColor=[0,0,1 ];
p(2).MarkerFaceColor='w';

xlabel('H/km','FontSize',18)
ylabel('RMSE/m','FontSize',18)
legend('X','Y','Location','northeast','FontSize',18')

ax = gca;
grid on
ax.GridLineStyle = ':';
ax.GridColor = [0 0 0];
ax.LineWidth=0.6;
ax.GridAlpha = 1;
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');
%% position2 

% h=5km

x25=[8 1 6 5 5 1 5 5 3 1 1 5];
y25=[8 1 6 1 5 5 2 4 1 1 2 3];

RMSE25x=rms(x25);
RMSE25y=rms(y25);

% h=4km

x24=[4 1 1 3 3 1 4 1 5 1 1 5];
y24=[4 1 1 3 1 1 6 4 1 1 2 3];

RMSE24x=rms(x24);
RMSE24y=rms(y24);

% h=3km

x23=[4 2 3 1 3 1 1 1 1 3 1 5];
y23=[4 2 3 1 1 1 2 3 1 4 1 3];

RMSE23x=rms(x23);
RMSE23y=rms(y23);

figure(2)
p=plot(x,[a*RMSE25x,b*RMSE24x,c*RMSE23x],'-s',x,[a*RMSE25y,b*RMSE24y,c*RMSE23y],'-o');
set(gca,'FontSize',18,'Xdir','reverse');

p(1).LineWidth =2;
p(1).MarkerSize=5;
p(1).MarkerEdgeColor=[0,0,0 ];
p(1).MarkerFaceColor='w';
p(2).LineWidth =2;
p(2).MarkerSize=5;
p(2).MarkerEdgeColor=[0,0,1 ];
p(2).MarkerFaceColor='w';

xlabel('H/km','FontSize',18)
ylabel('RMSE/m','FontSize',18)
legend('X','Y','Location','northeast','FontSize',18')

ax = gca;
grid on
ax.GridLineStyle = ':';
ax.GridColor = [0 0 0];
ax.LineWidth=0.6;
ax.GridAlpha = 1;
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');

%% position3 

% h=5km

x35=[8 3 3 5 2 1 1 5 2 1 1 5];
y35=[8 5 4 1 1 5 2 3 1 1 2 3];

RMSE35x=rms(x35);
RMSE35y=rms(y35);

% h=4km

x34=[2 1 1 5 2 1 1 5 2 3 1 5];
y34=[4 5 1 5 1 1 2 3 1 3 2 3];

RMSE34x=rms(x34);
RMSE34y=rms(y34);

% h=3km

x33=[2 1 1 5 2 1 1 5 2 1 1 2];
y33=[5 1 1 1 2 1 2 3 1 1 2 3];

RMSE33x=rms(x33);
RMSE33y=rms(y33);

figure(3)
p=plot(x,[a*RMSE35x,b*RMSE34x,c*RMSE33x],'-s',x,[a*RMSE35y,b*RMSE34y,c*RMSE33y],'-o');
set(gca,'FontSize',18,'Xdir','reverse');

p(1).LineWidth =2;
p(1).MarkerSize=5;
p(1).MarkerEdgeColor=[0,0,0 ];
p(1).MarkerFaceColor='w';
p(2).LineWidth =2;
p(2).MarkerSize=5;
p(2).MarkerEdgeColor=[0,0,1 ];
p(2).MarkerFaceColor='w';

xlabel('H/km','FontSize',18)
ylabel('RMSE/m','FontSize',18)
legend('X','Y','Location','northeast','FontSize',18')

ax = gca;
grid on
ax.GridLineStyle = ':';
ax.GridColor = [0 0 0];
ax.LineWidth=0.6;
ax.GridAlpha = 1;
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');
%% position4 

% h=5km

x45=[6 2 1 5 2 1 1 5 2 1 1 5];
y45=[5 3 4 1 5 1 2 3 4 1 2 3];

RMSE45x=rms(x45);
RMSE45y=rms(y45);

% h=4km

x44=[4 1 1 5 2 1 1 5 2 1 1 5];
y44=[4 1 5 1 5 1 2 3 1 3 2 3];

RMSE44x=rms(x44);
RMSE44y=rms(y44);

% h=3km

x43=[2 1 1 5 2 1 1 5 2 2 1 1];
y43=[5 4 1 1 1 1 2 3 1 1 4 1];

RMSE43x=rms(x43);
RMSE43y=rms(y43);

figure(4)
p=plot(x,[a*RMSE45x,b*RMSE44x,c*RMSE43x],'-s',x,[a*RMSE45y,b*RMSE44y,c*RMSE43y],'-o');
set(gca,'FontSize',18,'Xdir','reverse');

p(1).LineWidth =2;
p(1).MarkerSize=5;
p(1).MarkerEdgeColor=[0,0,0 ];
p(1).MarkerFaceColor='w';
p(2).LineWidth =2;
p(2).MarkerSize=5;
p(2).MarkerEdgeColor=[0,0,1 ];
p(2).MarkerFaceColor='w';

xlabel('H/km','FontSize',18)
ylabel('RMSE/m','FontSize',18)
legend('X','Y','Location','northeast','FontSize',18')

ax = gca;
grid on
ax.GridLineStyle = ':';
ax.GridColor = [0 0 0];
ax.LineWidth=0.6;
ax.GridAlpha = 1;
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');