%% KKY/DR 4 Doors
% Change change
% not    change
% change not
% not    not
% Moderator does know where the car is

% Clear Sequence
clear all, close all %#ok<CLALL>

% Wait 0.01s (sometimes, clear all does not delete everything)
pause(0.01)

%% Initialize parameters

% Number of doors
doorCount = 4;

% Number of simulations
num_samples = 100000; 

% Create n vector of random choises for given number of doors
choose = @(n, doors) floor(rand(n, 1) * doors) + 1;

%% Simulation
% Moderator does not know where the car is

% Car position
carDoor = choose(num_samples, doorCount);

% Choose door for each game
playerChoices01 = choose(num_samples, doorCount);

% Moderator choice for each game
moderatorChoices01 = moderatorChoiceInstructed(playerChoices01, carDoor);

% Initialize vector of completed games
playerLost01 = carDoor == moderatorChoices01;

% Player next move (Will change)
playerChoices02 = playerChoiceNext(playerChoices01, moderatorChoices01, playerLost01, 1);

% Moderator choice for each game
moderatorChoices02 = moderatorChoice2Instructed(playerChoices02, moderatorChoices01, carDoor, playerLost01);

% Initialize vector of completed games
playerLost02 = mergeLosts(playerLost01, carDoor == moderatorChoices02);

% Player next move (Will change)
playerChoices03 = playerChoiceNext2(playerChoices02, moderatorChoices01, moderatorChoices02, playerLost02, 1);

% Count how many times player have won
playerWon = carDoor == playerChoices03;

% Results
disp(sum(playerWon == 1) / num_samples);

%% Simulation
% Moderator does not know where the car is

% Car position
carDoor = choose(num_samples, doorCount);

% Choose door for each game
playerChoices01 = choose(num_samples, doorCount);

% Moderator choice for each game
moderatorChoices01 = moderatorChoiceInstructed(playerChoices01, carDoor);

% Initialize vector of completed games
playerLost01 = carDoor == moderatorChoices01;

% Player next move (Will NOT change)
playerChoices02 = playerChoiceNext(playerChoices01, moderatorChoices01, playerLost01, 0);

% Moderator choice for each game
moderatorChoices02 = moderatorChoice2Instructed(playerChoices02, moderatorChoices01, carDoor, playerLost01);

% Initialize vector of completed games
playerLost02 = mergeLosts(playerLost01, carDoor == moderatorChoices02);

% Player next move (Will change)
playerChoices03 = playerChoiceNext2(playerChoices02, moderatorChoices01, moderatorChoices02, playerLost02, 1);

% Count how many times player have won
playerWon = carDoor == playerChoices03;

% Results
disp(sum(playerWon == 1) / num_samples);

%% Simulation

% Car position
carDoor = choose(num_samples, doorCount);

% Choose door for each game
playerChoices01 = choose(num_samples, doorCount);

% Moderator choice for each game
moderatorChoices01 = moderatorChoiceInstructed(playerChoices01, carDoor);

% Initialize vector of completed games
playerLost01 = carDoor == moderatorChoices01;

% Player next move (Will change)
playerChoices02 = playerChoiceNext(playerChoices01, moderatorChoices01, playerLost01, 1);

% Moderator choice for each game
moderatorChoices02 = moderatorChoice2Instructed(playerChoices02, moderatorChoices01, carDoor, playerLost01);

% Initialize vector of completed games
playerLost02 = mergeLosts(playerLost01, carDoor == moderatorChoices02);

% Player next move (Will NOT change)
playerChoices03 = playerChoiceNext2(playerChoices02, moderatorChoices01, moderatorChoices02, playerLost02, 0);

% Count how many times player have won
playerWon = carDoor == playerChoices03;

% Results
disp(sum(playerWon == 1) / num_samples);

%% Simulation

% Car position
carDoor = choose(num_samples, doorCount);

% Choose door for each game
playerChoices01 = choose(num_samples, doorCount);

% Moderator choice for each game
moderatorChoices01 = moderatorChoiceInstructed(playerChoices01, carDoor);

% Initialize vector of completed games
playerLost01 = carDoor == moderatorChoices01;

% Player next move (Will NOT change)
playerChoices02 = playerChoiceNext(playerChoices01, moderatorChoices01, playerLost01, 0);

% Moderator choice for each game
moderatorChoices02 = moderatorChoice2Instructed(playerChoices02, moderatorChoices01, carDoor, playerLost01);

% Initialize vector of completed games
playerLost02 = mergeLosts(playerLost01, carDoor == moderatorChoices02);

% Player next move (Will NOT change)
playerChoices03 = playerChoiceNext2(playerChoices02, moderatorChoices01, moderatorChoices02, playerLost02, 0);

% Count how many times player have won
playerWon = carDoor == playerChoices03;

% Results
disp(sum(playerWon == 1) / num_samples);

% End of Script
