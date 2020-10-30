function [out] = playerChoiceNext2(playerChoices, moderatorChoices, moderatorChoices2, playerLost, playerChange)
%PLAYERCHOICENEXT2 Summary of this function goes here
%   Detailed explanation goes here

% [1, 2, 3, 4?]
availableChoices = unique(playerChoices);

% New Player choices
out = zeros(length(playerChoices), 1);

% Will Player change doors? 0 - no, 1 - yes
% playerChange = round(rand(length(playerChoices), 1));

for i = 1:length(playerChoices)
    
    % If did not lost already & wants to change
    if playerLost(i) == 0 && playerChange == 1
        
        % Get only available door choices
        newAvailable = availableChoices;
        newAvailable(newAvailable == playerChoices(i)) = [];
        newAvailable(newAvailable == moderatorChoices(i)) = [];
        newAvailable(newAvailable == moderatorChoices2(i)) = [];
        
        % Select random door from available
        out(i) = newAvailable(randperm(length(newAvailable), 1));
        
    % If did not lost already & does not want to change
    elseif playerLost(i) == 0 && playerChange == 0
        out(i) = playerChoices(i);
    end
end

end

