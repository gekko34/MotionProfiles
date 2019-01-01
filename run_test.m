## File: test.m
## Platform: Octave, https://www.gnu.org/software/octave/
## Copyright (c): Remo Kälin, rkaelin@gmx.net
## Author: Remo Kälin
## Created: 2018-12-31
## Version: alpha

number_of_errors = 0;

for i = 1:100
  delta_s = randi([1,5000]); % distance in increment
%  delta_s = 50; % distance in increment
  
  delta_t = randi([1,5000]); % time in ms  
%  delta_t = 50; % time in ms 

%  prof = randi([1,5]);
%  prof = randi([1,2]);
  prof = 1;

  try
    x_origin = zeros(4,1);
    [t, s, v, a] = profile(prof, delta_s, delta_t, x_origin(2,end), x_origin(3,end)); % generate profile
    x_new = [x_origin, [t; s; v; a] ]; % connect profiles
    
%    delta_s
%    int32(x_new(2,end) - x_origin(2,end))
  
    if( delta_s != int32( (x_new(2,end) - x_origin(2,end) ) ))  
      error('distance error')
    end     
  catch
     number_of_errors++;
  end_try_catch
end

display(number_of_errors)