## File: profile.m
## Platform: Octave, https://www.gnu.org/software/octave/ 
## Author: gekko34
## Created: 2018-12-27
## Version: alpha
## Function: generates a motion profile
## Input: type, deltaS, deltaT, s = 0, v = 0
## Output: time, position, speed, acceleration
## Dependencies: -

function [time, position, speed, acceleration] = profile(type, deltaS, deltaT, s = 0, v = 0) 

  time = 1:deltaT;  
  
  switch(type)
    case 1
%     Const. Acc 
      acceleration = ones(deltaT,1)' *deltaS *2 /(deltaT^2);
    case 2
%     Sine Acc.       
      acceleration = sin(pi /deltaT *time) *1.5708 *deltaS *2 /(deltaT^2) ;
    case 3
%     Sine^s Acc. 
      acceleration = (-cos(pi /deltaT *time *2) + 1) *deltaS *2 /(deltaT^2);
    case 4
%     S-Curve 
      acceleration_1 = 1 /deltaT *time *4;
      acceleration_2 = 1 - 1 /deltaT *time *4;
      acceleration = [ acceleration_1(1:int32(deltaT/4)), ones( int32(deltaT /2) ,1)', acceleration_2(1:int32(deltaT/4))];
      acceleration = acceleration *deltaS *2 /(deltaT^2) /3 *4;  
    case 5
%     Opt. S-Curve. 
      acceleration_1 = (-cos(pi /deltaT *time *4) + 1)/2;
      acceleration = [ acceleration_1(1:int32(deltaT/4)), ones( int32(deltaT /2)-1 ,1)', acceleration_1( int32(deltaT/4):deltaT /2)];
      acceleration = acceleration *deltaS *2 /(deltaT^2) /3 *4;
    case 6
%     Torque Opt.
      if(v == 0)
        acceleration_1 = 1 /deltaT *time *4;
        acceleration_2 = 1 - 1 /deltaT *time *4 /3;
        acceleration = [ acceleration_1(1:int32(deltaT/4)), acceleration_2(1:int32(deltaT/4*3))];
      else
        acceleration_1 = 1 /deltaT *time *4 /3;
        acceleration_2 = 1 - 1 /deltaT *time *4;
        acceleration = [ acceleration_1(1:int32(deltaT/4 *3)), acceleration_2(1:int32(deltaT/4))];
      end
      
      acceleration = acceleration *deltaS *2 /(deltaT^2) *2 /9512 *9012;    
  end
  
  
  speed = ones(deltaT,1)' *v +acceleration(1);
  for i = 2:deltaT
    speed(i) = speed(i-1) + acceleration(i);
  end
    
  position = ones(deltaT,1)' *s +speed(1);
  for i = 2:deltaT
    position(i) = position(i-1) +speed(i);
  end 

  
end
