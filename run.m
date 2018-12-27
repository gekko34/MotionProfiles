## File: run.m
## Author: gekko34
## Platform: Octave, https://www.gnu.org/software/octave/ 
## Created: 2018-12-27
## Version: alpha
## Function: script plots different types of motion profiles
## Input: DELTA_S, DELTA_T
## Output: charts
## Dependencies: plot_profile.m, profile.m

clear all
close all

DELTA_S = 1000; % distance in increment 
DELTA_T = 1000; % time in ms

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
bar(acc_vect);
title('Max. Acceleration [inc/ms^2]')
set(gca,'xTickLabel', profiles)
grid on


figure()
bar(jerk_vect);
title('Max. Jerk [inc/ms^3]')
set(gca,'xTickLabel', profiles)
grid on
