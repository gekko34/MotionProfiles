clear all
close all

DELTA_S = 1000;
DELTA_T = 1000;

acc_vect = [];
jerk_vect = [];

profiles = { 'Const. Acc', 'Sine Acc.', 'Sine^s Acc.', 'S-Curve', 'Opt. S-Curve.', 'Torque Opt.' };

for i = 1:length(profiles)
  
  [x1, x2, x3, x4] = profile(i, DELTA_S, DELTA_T, 0, 0);
  [y1, y2, y3, y4] = profile(i, 0, DELTA_T, x2(end), x3(end) );
  [z1, z2, z3, z4] = profile(i, -DELTA_S, DELTA_T, y2(end), y3(end) );
  jerk = [0, diff([ x4, y4, z4 ])];
  plot_profile( [x1, y1 .+x1(end), z1 .+x1(end) .+y1(end) ], [x2, y2, z2], [x3, y3, z3], [x4, y4, z4], jerk );
  subplot(4,1,1)
  title(profiles(i))
  grid
  disp ('profile: '), disp(i)
  acc_vect = [ acc_vect, max([x4, y4, z4]) ];
  jerk_vect = [ jerk_vect, max(abs(jerk)) ];
  x2(end)
  y2(end)

end

figure()
hold on
grid on
for i = 1:length(profiles)
  h = bar(i, acc_vect(i), 'barwidth', 0.4);
  if(i == 2)
    set(h, 'facecolor', 'r')
  else
    set(h, 'facecolor', 'b')
  end
end  
ylim([0,0.002]) 
title('Max. Acceleration [inc/ms^2]')
set(gca,'xTickLabel', {0, profiles })




figure()
hold on
grid on
for i = 1:length(profiles)
  h = bar(i, jerk_vect(i), 'barwidth', 0.4);
  if(i == 2)
    set(h, 'facecolor', 'r')
  else
    set(h, 'facecolor', 'b')
  end
end  

ylim([0,0.00001])
title('Max. Jerk [inc/ms^3]')
set(gca,'xTickLabel', {0, profiles})

