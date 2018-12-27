## File: plot_profile.m
## Author: gekko34
## Created: 2018-27-12
## Version: alpha
## Function: plots a motion profile
## Input: time, position, speed, acceleration, jerk
## Usage: plot_profile(time, position, speed, acceleration, jerk)
## Output: Chart, no return
## Dependencies: -

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
   ylabel('acceleration [inc/ms^2]')
   grid on
   
   subplot(4,1,4)
   plot(time,jerk)
   ylabel('jerk [inc/ms^3]')
   xlabel('time [ms]')
   grid on
end