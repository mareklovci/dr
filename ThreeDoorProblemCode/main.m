%% KKY/DR 4 Doors

% Clear Sequence
clear all, close all %#ok<CLALL>

% Wait 0.01s (sometimes, clear all does not delete everything)
pause(0.01)

%% Initialize parameters

% Number of doors
doorCount = 3;

% Number of simulations
num_samples = 100000; 

% Create n vector of random choises for given number of doors
choose = @(n, doors) floor(rand(n, 1) * doors) + 1;

%% Simulation
% Moderator does not know where the car is

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
disp(sum(playerWon0 == 1) / num_samples);
disp(sum(playerWon1 == 1) / num_samples);

%% Simulation
% Moderator does know where the car is

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
disp(sum(playerWon0 == 1) / num_samples);
disp(sum(playerWon1 == 1) / num_samples);

% End of Script
