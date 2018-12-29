## File: main.m
## Author: gekko34
## Platform: Octave, https://www.gnu.org/software/octave/ 
## Created: 2018-12-29
## Version: alpha
## Function: generates combined motion profiles
## Input: profile type, distance [inc], acceleration [inc/ms^2], max. speed [inc/ms], start position [inc]
## Output: motion charts & output file .mat
## Dependencies: plot_profile.m, move_profile.m

% clean up 
clear;
close all;
clf;
clc;

x = zeros(5,1);

[t, s, v, a, j] = move_profile(2, 100, 0.02, 1, 0); % -> ..move forward
x = [x, [t; s; v; a; j] ]; % connect profiles

[t, s, v, a, j] = move_profile(2, -200, 0.02, 1, s(end)); % <-- ..move backward, twice the distance
x = [x, [t; s; v; a; j] ]; % connect profiles

[t, s, v, a, j] = move_profile(2, 200, 0.02, 1, s(end)); % -> ..move forward, twice the distance
x = [x, [t; s; v; a; j] ]; % connect profiles

[t, s, v, a, j] = move_profile(2, -200, 0.02, 1, s(end) ); % <-- ..move backward, twice the distance
x = [x, [t; s; v; a; j] ]; % connect profiles

[t, s, v, a, j] = move_profile(2, 100, 0.02, 1, s(end)); % -> ..move forward
x = [x, [t; s; v; a; j] ]; % connect profiles


x(1,:) = 0:size(x,2)-1; % overwrite time 

% plot profile
plot_profile( x(1,:),x(2,:),x(3,:),x(4,:),x(5,:) );
  
% save profile to .mat-file  
save motion_profile.mat x ; % save to .mat-file
