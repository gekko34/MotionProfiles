clf
clear




load motion_profile.mat
p = x(2,:)';

z = zeros(size(p));

load motion_profile_angle.mat
a = x(2,:)';

% roll, pitch, yaw, surge, sway, heave, xOffset, yOffset, zOffset
q = [ a, z, z,   z, z, z,   z, z, z;
      z, a, z,   z, z, z,   z, z, z;
      z, z, a,   z, z, z,   z, z, z;
            
      z, z, z,   p, z, z,   z, z, z;
      z, z, z,   z, p, z,   z, z, z;
      z, z, z,   z, z, p,   z, z, z ];
     
save motion_profile.mat q