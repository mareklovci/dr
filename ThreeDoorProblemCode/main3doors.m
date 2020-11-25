%% KKY/DR 3 Doors
% Moderator Strategy = MS (Random, Goat)
% Player Strategy = PS (Change, Hold)

% Clear Sequence
clear all, close all %#ok<CLALL>

% Wait 0.01s (sometimes, clear all does not delete everything)
pause(0.01)

%% Initialize parameters

% Output Table format text
formatSpec1 = 'Player Stategy Change Prob: %1.4f \n';
formatSpec2 = 'Player Stategy Hold Prob: %1.4f \n';

% Number of doors
doorCount = 3;

% Number of simulations
num_samples = 100000; 

% Create n vector of random choises for given number of doors
choose = @(n, doors) floor(rand(n, 1) * doors) + 1;

%% MS: Random

% Print MS
disp('Moderator Strategy: Random')

% Choose door for each game
playerChoices = choose(num_samples, doorCount);

% Car position
carDoor = choose(num_samples, doorCount);

% Moderator choice for each game
moderatorChoices = moderatorChoice(choose, playerChoices);

% Initialize vector of completed games
playerLost = carDoor == moderatorChoices;

% Player next move (Will NOT change)
playerChoicesNext0 = playerChoiceNext(playerChoices, moderatorChoices, playerLost, 0);

% Count how many times player have won
playerWon0 = carDoor == playerChoicesNext0;

% Player next move (Will change)
playerChoicesNext1 = playerChoiceNext(playerChoices, moderatorChoices, playerLost, 1);

% Count how many times player have won
playerWon1 = carDoor == playerChoicesNext1;

% Results
fprintf(formatSpec2, sum(playerWon0 == 1) / num_samples);
fprintf(formatSpec1, sum(playerWon1 == 1) / num_samples);

%% MS: Goat

% Print MS
disp('Moderator Strategy: Goat')

% Choose door for each game
playerChoices = choose(num_samples, doorCount);

% Car position
carDoor = choose(num_samples, doorCount);

% Moderator choice for each game
moderatorChoices = moderatorChoiceInstructed(playerChoices, carDoor);

% Initialize vector of completed games
playerLost = carDoor == moderatorChoices;

% Player next move (Will NOT change)
playerChoicesNext0 = playerChoiceNext(playerChoices, moderatorChoices, playerLost, 0);

% Count how many times player have won
playerWon0 = carDoor == playerChoicesNext0;

% Player next move (Will change)
playerChoicesNext1 = playerChoiceNext(playerChoices, moderatorChoices, playerLost, 1);

% Count how many times player have won
playerWon1 = carDoor == playerChoicesNext1;

% Results
fprintf(formatSpec2, sum(playerWon0 == 1) / num_samples);
fprintf(formatSpec1, sum(playerWon1 == 1) / num_samples);

% End of Script
