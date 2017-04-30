figure
p=plot(precisionsu(1,:),recallsu(1,:),precisionbrisk(1,:),recallbrisk(1,:),precisionfreak(1,:),recallfreak(1,:),precisionsift,recallsift,precisionakaze,recallakaze,precisionkaze,recallkaze);
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

p(5).LineWidth =2;
p(5).MarkerSize=7;
p(5).MarkerEdgeColor=[0,0,0 ];
p(5).MarkerFaceColor='w';

p(6).LineWidth =2;
p(6).MarkerSize=7;
p(6).MarkerEdgeColor=[0,0,0 ];
p(6).MarkerFaceColor='w';


grid on
xlabel('1-precision','FontSize',18')
ylabel('recall %','FontSize',18')
legend('SURF','BRISK','FREAK','SIFT','AKAZE','KAZE','Location','SouthEast','FontSize',18')