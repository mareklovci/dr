function [out1, out2, out3] = CutZeros(S_1, S_2, t)
%CUTZEROS Summary of this function goes here
%   Detailed explanation goes here

firstNZeroS1 = find(S_1,1,'first');
firstNZeroS2 = find(S_2,1,'first');

if(~isempty(firstNZeroS1) && ~isempty(firstNZeroS2))
    cut = max(firstNZeroS1, firstNZeroS2);
else
    cut = firstNZeroS1;
end

out1 = S_1(cut:end);
out2 = S_2(cut:end);
out3 = t(cut:end);

end

