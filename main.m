## File: main.m
## Platform: Octave, https://www.gnu.org/software/octave/
## Copyright (c): Remo Kälin, rkaelin@gmx.net
## Author: Remo Kälin
## Created: 2018-12-27
## Version: alpha

% clean up 
clear;
close all;
clf;
clc;

MOVE_DISTANCE = 100;
ACCELERATION = 0.02;
MAX_SPEED = 1;

prof = { 'Const. Acc', 'Sine Acc.', 'Sine^s Acc.', 'S-Curve', 'Opt. S-Curve.', 'Torque Opt.' };

for i = 1:length(prof)

  x = zeros(5,1);

  [t, s, v, a, j] = move_profile(i, MOVE_DISTANCE, ACCELERATION, MAX_SPEED, 0); % -> ..move forward
  x = [x, [t; s; v; a; j] ]; % connect profiles

  [t, s, v, a, j] = move_profile(i, -MOVE_DISTANCE *2, ACCELERATION, MAX_SPEED, s(end)); % <-- ..move backward, twice the distance
  x = [x, [t; s; v; a; j] ]; % connect profiles

  [t, s, v, a, j] = move_profile(i, MOVE_DISTANCE *2, ACCELERATION, MAX_SPEED, s(end)); % -> ..move forward, twice the distance
  x = [x, [t; s; v; a; j] ]; % connect profiles

  [t, s, v, a, j] = move_profile(i, -MOVE_DISTANCE *2, ACCELERATION, MAX_SPEED, s(end) ); % <-- ..move backward, twice the distance
  x = [x, [t; s; v; a; j] ]; % connect profiles

  [t, s, v, a, j] = move_profile(i, MOVE_DISTANCE, ACCELERATION, MAX_SPEED, s(end)); % -> ..move forward
  x = [x, [t; s; v; a; j] ]; % connect profiles

  x(1,:) = 0:size(x,2)-1; % overwrite time vector 

  % plot profile
  plot_profile( x(1,:),x(2,:),x(3,:),x(4,:),x(5,:) );
  
  subplot(4,1,1)
  title(prof(i))
 
end
 
% save profile to .mat-file  
%save motion_profile.mat x ; % save to .mat-file
