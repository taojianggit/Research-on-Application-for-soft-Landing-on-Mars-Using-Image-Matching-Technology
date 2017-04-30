figure;

x=10:10:90;
p=plot(x, v_repeatabilityh ,'-x',x, v_repeatabilitys ,'-+',x, v_repeatabilitysu ,'-d',x, v_repeatabilitymser ,'-o',x,v_repeatabilitybrisk,'-s',x,v_repeatabilityk,'-^',x,v_repeatabilityak,'-v');
% p=plot(x, v_repeatabilityh ,'-mx',x, v_repeatabilitys ,'-b+',x, v_repeatabilitysu ,'-rd',x, v_repeatabilitymser ,'-yo',x,v_repeatabilitybrisk,'-gs',x,v_repeatabilityk,'-k^',x,v_repeatabilityak,'-cp');
set(gca,'FontSize',10);
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

p(7).LineWidth =2;
p(7).MarkerSize=7;
p(7).MarkerEdgeColor=[0,0,0 ];
p(7).MarkerFaceColor='w';

grid on
xlabel('rotate','FontSize',18)
ylabel('repeatability %','FontSize',18)
legend('HARRIS','SIFT','SURF','MSER','BRISK','KAZE','AKAZE','Location','northeast')