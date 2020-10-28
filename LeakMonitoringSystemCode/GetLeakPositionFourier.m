function [out] = GetLeakPositionFourier(R, s1, s2, dt, v, leak)
%GETLEAKPOSITIONFOURIER Returns position of a leak in Time Domain
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
%   out  : Position of a Leak in Frequency Domain

[~, argmax12] = max(R(1, :));
[~, argmax21] = max(R(2, :));

% Sensor position Difference
posDif = s2 - s1;

if leak > posDif / 2
    out = posDif - (posDif - (argmax21 - 1) * dt * v) / 2;
else
    out = (posDif - (argmax12 - 1) * dt * v) / 2;
end

% Where the heck is the leak?!
% if argmax12 <= argmax21 % Leak near sensor 2
%     out = posDif - (posDif - (argmax21 - 1) * dt * v) / 2;
% else % Leak near sensor 1
%     out = (posDif - (argmax12 - 1) * dt * v) / 2;
% end

end

