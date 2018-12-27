function plot_profile(time, position, speed, acceleration, jerk) 
   
   figure()
   hold on
   subplot(4,1,1)
   plot(time,position)
   hold on
   ylabel('position [inc]')
   
   subplot(4,1,2)
   plot(time,speed)
   hold on
   ylabel('speed [inc/ms]')
   
   subplot(4,1,3)
   plot(time,acceleration)
   hold on
   ylabel('acceleration [inc/ms^2]')
   
   subplot(4,1,4)
   plot(time,jerk)
   hold on
   ylabel('jerk [inc/ms^3]')
   xlabel('time [ms]')
end