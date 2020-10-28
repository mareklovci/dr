function [out1, out2] = GetLeakTimeShift(s1, s2, leak, v)
%GETLEAKTIMESHIFT Get Time Shift for given sensor locations 
%   Get Time Shift for given sensor locations based on leak position and
%   speed of sound in a medium
% Inputs:
%   s1  : Sensor 1 location
%   s2  : Sensor 2 location
%   leak: Real Leakage Position
%   v   : Velocity of a sound in a tube
%
% Outputs:
%   out1 : Time Shift for sensor 1 (scalar)
%   out2 : Time Shift for sensor 2 (scalar)

% Compute Time Shift
out1  = abs(s1 - leak) / v; out2  = abs(s2 - leak) / v;

end
