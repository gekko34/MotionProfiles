## File: profile.m
## Platform: Octave, https://www.gnu.org/software/octave/
## Copyright (c): Remo Kälin, rkaelin@gmx.net
## Author: Remo Kälin
## Created: 2018-12-27
## Version: alpha

function [time, position, speed, acceleration] = profile(type, deltaS, deltaT, s = 0, v = 0) 
  
  
  time = 1:deltaT; 
  
  assert( deltaT > 0, 'deltaT is negative or "0"'); 
  assert( 0 < type, 'profile type unknown');
  assert( type <= 6, 'profile type unknown');    
  
  switch(type)
    case 1
%     Const. Acc 
      acceleration = ones(deltaT,1)'; 
      acceleration = acceleration *deltaS *2 /(deltaT^2);     
      speed = acceleration .*time .+v;  % v = a *t +v0 
      position = acceleration ./2 .*time.^2 .+(v *time) +s;  % s = a /2 *t^2 + v0 *t +s0 
      return

%     Int(0,n,x) =  n *x 
%     Int(0,n,nx) = n *x^2 /2     
           
    case 2
%     Sine Acc.       
      acceleration = sin(pi /deltaT *time) *(pi /2);
      acceleration = acceleration *deltaS *2 /(deltaT^2);         
      speed = (-cos(pi /deltaT *time) +1) *deltaS /deltaT  .+v;  
      position = (-sin(pi /deltaT *time)/pi + time /deltaT) *deltaS .+(v *time) +s;
      return   
          
          
    case 3
%     Sine^s Acc. 
      acceleration = (-cos(pi /deltaT *time *2) + 1);
    case 4
%     S-Curve 
      acceleration_1 = 1 /deltaT *time *4;
      acceleration_2 = 4 - 1 /deltaT *time *4;
      acceleration_3 = ones(deltaT,1);
      for i = 1:deltaT
        acceleration(i) = min( [acceleration_1(i), acceleration_2(i), acceleration_3(i)] );  
      end  
      acceleration = acceleration /3 *4; 
    case 5
%     Opt. S-Curve. 
      acceleration_1 = (-cos(pi /deltaT *time *4) + 1)/2;
      acceleration = [ acceleration_1(1:int32(deltaT /4)), ones( int32(deltaT /2)-1 ,1)', acceleration_1( int32(deltaT/4):int32(deltaT /2) )];
      acceleration = acceleration /3 *4;
    case 6
%     Torque Opt.
      if(v == 0)
        acceleration_1 = 1 /deltaT *time *4;
        acceleration_2 = 1 - 1 /deltaT *time;
        for i = 1:deltaT
          acceleration(i) = min( [acceleration_1(i), acceleration_2(i)] );  
        end  
      else
        acceleration_1 = 1 /deltaT *time;
        acceleration_2 = 4 - 1 /deltaT *time *4;
        for i = 1:deltaT
          acceleration(i) = min( [acceleration_1(i), acceleration_2(i)] );  
        end  
      end
      
      acceleration = acceleration /3520* 4000;    
  end
     
  acceleration = acceleration *deltaS *2 /(deltaT^2);
 
% v = int(a *t) +v0   
  speed = zeros(deltaT,1)';
  speed(1) = acceleration(1);
  for i = 2:deltaT
    speed(i) = speed(i-1) +acceleration(i);
  end
  speed = speed .+v;

  
% s = int(v0 *t) +s0   
  position = zeros(deltaT,1)';
  position(1) = speed(1);
  for i = 2:deltaT
    position(i) = position(i-1) + speed(i);
  end 
  position = position .+s;
 
  
end
