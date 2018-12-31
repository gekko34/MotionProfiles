## File: move_profile.m
## Author: gekko34
## Platform: Octave, https://www.gnu.org/software/octave/ 
## Created: 2018-12-29
## Version: alpha
## Function: generates motion profiles
## Input: profile type, distance [inc], acceleration [inc/ms^2], max. speed [inc/ms], start position [inc]
## Output: motion profile, resulting time
## Dependencies: profile.m

function [t, s, v, a, j] = move_profile(profile_type, distance, acceleration, velocity, start_pos) 
% profile_types: 
% 1 = Const. Acc
% 2 = Sine Acc
% 3 = Sine^s Acc
% 4 = S-Curve
% 5 = Opt. S-Curve
% 6 = Torque Opt

acceleration = abs(acceleration);
velocity = abs(velocity);
  
% t = (2s /a)^(1/2)
% v = a *t
  time_1 = (distance /acceleration )^(1/2);
  velocity_1 = acceleration *time_1;
    
  if(abs(velocity_1) < abs(velocity))
    distance = distance /2;
    [x1, x2, x3, x4] = profile(profile_type, distance, time_1, 0, 0);
    [y1, y2, y3, y4] = profile(profile_type, -distance, time_1, x2(end), x3(end));
    t = [ x1, y1 .+x1(end)];
    s = [ x2 .+start_pos, y2 .+start_pos ];
    v = [ x3, y3 ];
    a = [ x4, y4 ];
    j = [ 0, diff( [ x4, y4] ) ];
  else

% s = a /2 *t^2
% t = v /a
% -> s = a /2 *(v /a)^2 
    distance_1 = acceleration /2 *(velocity /acceleration)^2;

% a = 2s / t^2
% -> t = v / (2s / t^2)
% -> 1 = v /2s *t -> t = 2s / v 
    time_1 = distance_1 *2 /velocity;    

% s = v /t   
    time_2 = ( abs(distance) - 2* distance_1 ) /velocity;   
    distance_2 = velocity / time_2;
 
    if(distance > 0)
      [x1, x2, x3, x4] = profile(profile_type, distance_1, time_1, 0, 0);  
      [y1, y2, y3, y4] = profile(profile_type, distance_2, time_2, x2(end), x3(end));
      [z1, z2, z3, z4] = profile(profile_type, -distance_1, time_1, y2(end), y3(end));
    else
      [x1, x2, x3, x4] = profile(profile_type, -distance_1, time_1, 0, 0);  
      [y1, y2, y3, y4] = profile(profile_type, -distance_2, time_2, x2(end), x3(end));
      [z1, z2, z3, z4] = profile(profile_type, distance_1, time_1, y2(end), y3(end));
    end
    
    t = [ x1, y1 .+x1(end), z1 .+x1(end) .+y1(end) ];
    s = [ x2 .+start_pos, y2 .+start_pos, z2 .+start_pos ];
    v = [ x3, y3, z3 ];
    a = [ x4, y4, z4 ];
    j = [ 0, diff( [ x4, y4, z4] ) ];
  end

end