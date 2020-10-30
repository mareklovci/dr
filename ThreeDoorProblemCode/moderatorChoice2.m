function [out] = moderatorChoice2(playerChoices, moderatorChoices, playerLost)
%MODERATORCHOICE2 Summary of this function goes here
%   Detailed explanation goes here

% [1, 2, 3, 4?]
availableChoices = unique(playerChoices);

out = zeros(length(playerChoices), 1);

for i = 1:length(playerChoices)
    
    % If did not win yet
    if playerLost(i) == 0
        
        % Get only available door choices
        newAvailable = availableChoices;
        newAvailable(newAvailable == out(i)) = [];
        newAvailable(newAvailable == moderatorChoices(i)) = [];
        
        % Select random door from available
        out(i) = newAvailable(randperm(length(newAvailable), 1));
    end
end

end


