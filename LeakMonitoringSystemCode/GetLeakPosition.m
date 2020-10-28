function [out] = GetLeakPosition(R, s1, s2, dt, v)
%GETLEAKPOSITION Returns position of a leak in Time Domain
%   Returns position of a leak based on correlation function
%   (from prof. Muller scripts)
% Inputs:
%   R   : Correlation function
%   s1  : Sensor 1 location
%   s2  : Sensor 2 location
%   dt  : Time difference
%   v   : Velocity of a sound in a tube
%
% Outputs:
%   out  : Position of a Leak in Time Domain

[~, argmax] = max(R(1, :));

out = (s2 - s1 - (argmax - 1) * dt * v) / 2;
if R(2, argmax) == 2 % Leak near sensor 2
    out = s2 - s1 - out;
end

end

