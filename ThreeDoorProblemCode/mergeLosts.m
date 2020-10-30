function [out] = mergeLosts(lost1, lost2)
%MERGELOSTS Summary of this function goes here
%   Detailed explanation goes here

out = zeros(length(lost1), 1);

for i = length(lost1)
   if lost1(i) == 1 || lost2(i) == 1
    out(i) = 1;
end

end
