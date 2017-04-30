%This code plots Fig5.15
clc
clear
a=1;
b=1;
c=1;
d=1;
e=1;
x=[2.8 2.6 2.4 2.2 2];
%% position1 

% h=2.8km

% [1 1 1 1 1 1 1 1 1 1 ]
x15=7.5;
y15=7.7;

RMSE15x=rms(x15);
RMSE15y=rms(y15);

% h=2.6km

x14=7;
y14=7.3;

RMSE14x=rms(x14);
RMSE14y=rms(y14);

% h=2.4km

x13=6.6;
y13=6.5;
RMSE13x=rms(x13);
RMSE13y=rms(y13);
% h=2.2km

x12=6;
y12=6.2;

RMSE12x=rms(x12);
RMSE12y=rms(y12);

% h=2km

x11=5.3;
y11=5.1;

RMSE11x=rms(x11);
RMSE11y=rms(y11);



figure(1)
p=plot(x,[a*RMSE15x,b*RMSE14x,c*RMSE13x,d*RMSE12x,e*RMSE11x],'-s',x,[a*RMSE15y,b*RMSE14y,c*RMSE13y,d*RMSE12y,e*RMSE11y],'-o');
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
ylabel('RMSE/pixel','FontSize',18)
legend({'X','Y'},'Location','northeast','FontSize',18')

ax = gca;
grid on
ax.GridLineStyle = ':';
ax.GridColor = [0 0 0];
ax.LineWidth=0.6;
ax.GridAlpha = 1;
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');
%% position2 

% h=2.8km

x25=7.6;
y25=7.9;

RMSE25x=rms(x25);
RMSE25y=rms(y25);

% h=2.6km

x24=7.6;
y24=7.5;

RMSE24x=rms(x24);
RMSE24y=rms(y24);

% h=2.4km

x23=7;
y23=7.3;

RMSE23x=rms(x23);
RMSE23y=rms(y23);

% h=2.2km
x22=6;
y22=6.3;

RMSE22x=rms(x22);
RMSE22y=rms(y22);

% h=2km

x21=5.3;
y21=5.2;

RMSE21x=rms(x21);
RMSE21y=rms(y21);


figure(2)
p=plot(x,[a*RMSE25x,b*RMSE24x,c*RMSE23x,d*RMSE22x,e*RMSE21x],'-s',x,[a*RMSE25y,b*RMSE24y,c*RMSE23y,d*RMSE22y,e*RMSE21y],'-o');
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
ylabel('RMSE/pixel','FontSize',18)
legend({'X','Y'},'Location','northeast','FontSize',18')

ax = gca;
grid on
ax.GridLineStyle = ':';
ax.GridColor = [0 0 0];
ax.LineWidth=0.6;
ax.GridAlpha = 1;
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');

%% position3 

% h=2.8km

x35=8;
y35=7.6;

RMSE35x=rms(x35);
RMSE35y=rms(y35);

% h=2.6km

x34=7;
y34=7.3;

RMSE34x=rms(x34);
RMSE34y=rms(y34);

% h=2.4km

x33=6.7;
y33=6.4;

RMSE33x=rms(x33);
RMSE33y=rms(y33);

% h=2.2km
x32=5.8;
y32=5.5;

RMSE32x=rms(x32);
RMSE32y=rms(y32);

% h=2km

x31=5.4;
y31=5.3;

RMSE31x=rms(x31);
RMSE31y=rms(y31);

figure(3)
p=plot(x,[a*RMSE35x,b*RMSE34x,c*RMSE33x,d*RMSE32x,e*RMSE31x],'-s',x,[a*RMSE35y,b*RMSE34y,c*RMSE33y,d*RMSE32y,e*RMSE31y],'-o');
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
ylabel('RMSE/pixel','FontSize',18)
legend({'X','Y'},'Location','northeast','FontSize',18')

ax = gca;
grid on
ax.GridLineStyle = ':';
ax.GridColor = [0 0 0];
ax.LineWidth=0.6;
ax.GridAlpha = 1;
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');
%% position4 

% h=2.8km

x45=8.6;
y45=8.3;

RMSE45x=rms(x45);
RMSE45y=rms(y45);

% h=2.6km

x44=8;
y44=8.3;

RMSE44x=rms(x44);
RMSE44y=rms(y44);

% h=2.4km

x43=7.8;
y43=7.6;

RMSE43x=rms(x43);
RMSE43y=rms(y43);

% h=2.2km

x42=6.6;
y42=6.4;

RMSE42x=rms(x42);
RMSE42y=rms(y42);

% h=2km

x41=6.5;
y41=6.4;

RMSE41x=rms(x41);
RMSE41y=rms(y41);


figure(4)
p=plot(x,[a*RMSE45x,b*RMSE44x,c*RMSE43x,d*RMSE42x,e*RMSE41x],'-s',x,[a*RMSE45y,b*RMSE44y,c*RMSE43y,d*RMSE42y,e*RMSE41y],'-o');
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
ylabel('RMSE/pixel','FontSize',18)
legend({'X','Y'},'Location','northeast','FontSize',18')

ax = gca;
grid on
ax.GridLineStyle = ':';
ax.GridColor = [0 0 0];
ax.LineWidth=0.6;
ax.GridAlpha = 1;
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');