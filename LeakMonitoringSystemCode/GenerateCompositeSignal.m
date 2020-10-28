function [out] = GenerateCompositeSignal(F1, F2, t)
%GENERATECOMPOSITESIGNAL Generate Composite Signal
%   Generate Composite Signal as stated in the assignment. Aplitudes,
%   Frequency and White noise parameters are given by the assigment
% Inputs:
%   F1  : Frequency of sine 1
%   F2  : Frequency of sine 2
%   t   : Time vector
%
% Outputs:
%   out  : Composite Signal (sine + sine + white noise)

% Amplitudes
amp1 = 0.7; amp2 = 0.15;

% White Noise
wn_mean = 0; wn_var = 1; % Variance in (1, 2)

% Sine Waves
sine1 = amp1 * sin(F1 * t); sine2 = amp2 * sin(F2 * t);

% White Noise
wn = normrnd(wn_mean, wn_var, [1, length(t)]);

% Compose Signal
out = [sine1 + sine2 + wn; t];

end
