function [out] = GetCorrelation(SS1, SS2, ns, fr)
%GETCORRELATION Return Correlation Function in Time Domain
%   Return Correlation Function in Time Domain as a Two Row vector
%   with first row indicating value of a corr. and second row indicating
%   where the maximum correlation was for given signals
% Inputs:
%   SS1 : Signal 1
%   SS2 : Signal 2
%   ns  : Number of Samples
%   dt  : Time difference
%   fr  : Computation Frame Size
%
% Outputs:
%   out  : Correlation function Matrix

% I would not like decimals in a range function
ns = round(ns);

% Inititalize something full of zeros
out = zeros([2, ns]);

% And now, according to prof. Muller I have to iterate for each section
% with size of given correlation window (frame)
for m = 1:ns
    
    % Just calculate ends of vectors
    end1 = fr; end2 = m + fr - 1;
    
    % Get correlations
    R12 = SS1(1:end1) * SS2(m:end2)';
    R21 = SS2(1:end1) * SS1(m:end2)';
    
    % Get maximum correlation, indices and return 
    [out(1, m), out(2, m)] = max([R12, R21]); 
end

end
