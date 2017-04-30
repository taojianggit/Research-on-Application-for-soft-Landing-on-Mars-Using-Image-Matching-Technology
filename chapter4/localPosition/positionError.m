clc
clear;

x=1:1:9;

%% 

y1=[0,500,0 ,0,500,0,0,500,0];
y2=[23,484,15,-18,475,21,25,528,19];
rms1=rms(y2-y1)
figure
p1=plot(x,y1,x,y2,'LineWidth',2);
ylabel('\Delta x /m ','FontSize',14)
xlabel('group number','FontSize',14)
legend('ground truth ','computed value','Location','southeast','FontSize',18')
set(gca,'FontSize',14);
ax = gca;
grid on
ax.GridLineStyle = ':';
ax.GridColor = [0 0 0];
ax.LineWidth=0.6;
ax.GridAlpha = 1;
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');

%% 

y3=[500,0,0 ,500,0,0,500,0,0];
y4=[559,-25,15,466,34,24,525,28,31];
rms2=rms(y4-y3)
figure
p2=plot(x,y3,x,y4,'LineWidth',2);
ylabel('\Delta y /m ','FontSize',14)
xlabel('group number','FontSize',14)
legend('ground truth ','computed value','Location','southeast','FontSize',18')
set(gca,'FontSize',14);
ax = gca;
grid on
ax.GridLineStyle = ':';
ax.GridColor = [0 0 0];
ax.LineWidth=0.6;
ax.GridAlpha = 1;
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');

%% 

y5=[0,0,10,0,0,10,0,0,10];
y6=[1.4,-1.9,12.4,-1.8,2.5,11.9,1.1,-2.3,8.6];
rms3=rms(y5-y6)
figure
p3=plot(x,y5,x,y6,'LineWidth',2);
ylabel('\Delta \theta /бу ','FontSize',14)
xlabel('group number','FontSize',14)
legend('ground truth ','computed value','Location','southeast','FontSize',18')
set(gca,'FontSize',14);
ax = gca;
grid on
ax.GridLineStyle = ':';
ax.GridColor = [0 0 0];
ax.LineWidth=0.6;
ax.GridAlpha = 1;
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');

%% 

y7=[0,10,0 ,0,10,0,0,10,0];
y8=[-2.3,12.1,1.4,-1.5,12.6,2.3,2.9,8.3,1.9];
rms4=rms(y7-y8)
figure
p4=plot(x,y7,x,y8,'LineWidth',2);
ylabel('\Delta \phi /бу ','FontSize',14)
xlabel('group number','FontSize',14)
legend('ground truth ','computed value','Location','southeast','FontSize',18')

set(gca,'FontSize',14);
ax = gca;
grid on
ax.GridLineStyle = ':';
ax.GridColor = [0 0 0];
ax.LineWidth=0.6;
ax.GridAlpha = 1;
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');

%% 

y9=[10, 0,0 ,10, 0,0,10, 0,0];
y10=[11.3,2.7,1.5,8.4,-3.1,-2.1,12.9,2.2,2.5];
rms5=rms(y9-y10)
figure
p5=plot(x,y9,x,y10,'LineWidth',2);
ylabel('\Delta \psi/бу ','FontSize',14)
xlabel('group number','FontSize',14)
legend('ground truth ','computed value','Location','southeast','FontSize',18')

%% 

set(gca,'FontSize',14);
ax = gca;
grid on
ax.GridLineStyle = ':';
ax.GridColor = [0 0 0];
ax.LineWidth=0.6;
ax.GridAlpha = 1;
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');



