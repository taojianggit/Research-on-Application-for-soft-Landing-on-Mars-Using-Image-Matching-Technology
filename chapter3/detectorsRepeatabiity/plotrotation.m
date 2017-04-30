figure
p=plot(20:10:60,v_repeatabilitys,'-rd',20:10:60,v_repeatabilitysu,'-b+',20:10:60,v_repeatabilitymser,'-co',20:10:60,v_repeatabilitybrisk,'-mx');
% 20:10:60,v_repeatabilitysu,'-g+',
% 20:10:60,v_repeatabilityh,'-bs',
set( p, 'linesmoothing', 'on' );

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
xlabel('rotation angle','FontSize',14')
ylabel('repeatability %','FontSize',14')
legend('SIFT','SURF','MSER','FontSize',14')