figure;


p=plot(precisionakaze,recallakaze,'-x',precisionkaze,recallkaze,'-+',precisionsu,recallsu,'-d',precisionsift,recallsift,'-o',precisionbrisk,recallbrisk,'-s',precisionfreak,recallfreak,'-^');% p=plot(x, v_repeatabilityh ,'-mx',x, v_repeatabilitys ,'-b+',x, v_repeatabilitysu ,'-rd',x, v_repeatabilitymser ,'-yo',x,v_repeatabilitybrisk,'-gs',x,v_repeatabilityk,'-k^',x,v_repeatabilityak,'-cp');
set(gca,'FontSize',10);
% set( p, 'linesmoothing', 'on' );

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
xlabel('1-precision','FontSize',18)
ylabel('recall','FontSize',18)
legend('AKAZE','KAZE','SURF','SIFT','BRISK','FREAK','Location','northeast','FontSize',18')