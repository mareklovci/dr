function [out] = GetCorrelationFourier(SS1, SS2)
%GETCORRELATIONFOURIER Return Correlation Function in Frequency Domain
%   Return Correlation Function in Time Domain as a Two Row vector
%   indicating value of a correlation function for given signals
% Inputs:
%   SS1 : Signal 1
%   SS2 : Signal 2
%
% Outputs:
%   out  : Correlation function Matrix

% Discrete Fourier transform
fft1 = fft(SS1); fft2 = fft(SS2);

% Inverse discrete Fourier transform & return
out(1, :) = ifft(conj(fft1) .* fft2);
out(2, :) = ifft(fft1 .* conj(fft2));

end
