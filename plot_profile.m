## File: plot_profile.m
## Platform: Octave, https://www.gnu.org/software/octave/
## Copyright (c): Remo Kälin, rkaelin@gmx.net
## Author: Remo Kälin
## Created: 2018-12-27
## Version: alpha

function plot_profile(time, position, speed, acceleration, jerk)  
   
   figure()
   subplot(4,1,1)
   plot(time,position)
   ylabel('position [inc]')
   grid on
   
   subplot(4,1,2)
   plot(time,speed)
   ylabel('speed [inc/ms]')
   grid on
   
   subplot(4,1,3)
   plot(time,acceleration)
   ylabel('acc. [inc/ms^2]')
   grid on
   
   subplot(4,1,4)
   plot(time,jerk)
   ylabel('jerk [inc/ms^3]')
   xlabel('time [ms]')
   grid on
   
end