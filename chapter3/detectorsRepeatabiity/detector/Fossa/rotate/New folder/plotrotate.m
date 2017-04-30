figure;
x=10:10:50;
p=plot(x,v_repeatabilityh,'-mx',x,v_repeatabilitys,'-b+',x,v_repeatabilitysu,'-rd',x,v_repeatabilitymser,'-yo');
set(gca,'FontSize',18);
set( p, 'linesmoothing', 'on' );
% 20:10:60,v_repeatabilitysu,'-g+',
% 20:10:60,v_repeatabilityh,'-bs',

p(1).LineWidth =2;
p(1).MarkerSize=7;
p(1).MarkerEdgeColor=[0,0,0 ];
p(1).MarkerFaceColor='w';

p(2).LineWidth =2;
p(2).MarkerSize=7;
p(2).MarkerEdgeColor=[0,0,0 ];
p(2).MarkerFaceColor='w';

p(3).LineWidth =2;
p(3).MarkerSize=7;
p(3).MarkerEdgeColor=[0,0,0 ];
p(3).MarkerFaceColor='w';

p(4).LineWidth =2;
p(4).MarkerSize=7;
p(4).MarkerEdgeColor=[0,0,0 ];
p(4).MarkerFaceColor='w';
grid on
xlabel('rotation','FontSize',18)
ylabel('repeatability %','FontSize',18)
legend('HARRIS','SIFT','SURF','MSER','FontSize',18)