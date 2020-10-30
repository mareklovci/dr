function [out] = moderatorChoice(choose, playerChoices)
%MODERATORCHOICE Summary of this function goes here
%   Detailed explanation goes here

% [1, 2, 3, 4?]
availableChoices = unique(playerChoices);

% Get Door count
doorCount = max(availableChoices);

% Moderator choices
out = choose(length(playerChoices), doorCount);

for i = 1:length(playerChoices)
    
    % If choices are the same
    if playerChoices(i) == out(i)
        
        % Get only available door choices
        newAvailable = availableChoices;
        newAvailable(newAvailable == out(i)) = [];
        
        % Select random door from available
        out(i) = newAvailable(randperm(length(newAvailable), 1));
    end
end

end
