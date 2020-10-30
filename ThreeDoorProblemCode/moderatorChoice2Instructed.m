function [out] = moderatorChoice2Instructed(playerChoices, moderatorChoices, carDoor, playerLost)
%MODERATORCHOICE2INSTRUCTED Summary of this function goes here
%   Detailed explanation goes here

% [1, 2, 3, 4?]
availableChoices = unique(playerChoices);

% Moderator choices
out = zeros(length(playerChoices), 1);

for i = 1:length(playerChoices)
    
    % If did not win yet
    if playerLost(i) == 0
        % If player is on CarDoor
        if playerChoices(i) == carDoor(i)

            % Get only available door choices
            newAvailable = availableChoices;
            newAvailable(newAvailable == carDoor(i)) = [];
            newAvailable(newAvailable == moderatorChoices(i)) = [];

            % Select random door from available
            out(i) = newAvailable(randperm(length(newAvailable), 1));

        else
            % Get only available door choices
            newAvailable = availableChoices;
            newAvailable(newAvailable == carDoor(i)) = [];
            newAvailable(newAvailable == playerChoices(i)) = [];
            newAvailable(newAvailable == moderatorChoices(i)) = [];

            % Select random door from available
            out(i) = newAvailable(randperm(length(newAvailable), 1));
        end
    end
end

end

