%% KKY/DR Leak Monitoring System

% Clear Sequence
clear all, close all %#ok<CLALL>

% Wait 0.01s (sometimes, clear all does not delete everything)
pause(0.01)

%% Setup pipe

% Sensor locations [m]
s_1 = 0; s_2 = s_1 + 1500;

% Speed of sound in pipe [m/s]
velocity = 5000;

% Leakage [m]
leak = 1000;

%% Setup correlation method

% Correlation window
frame = 50;

%% Generate signal

% Sine wave frequency (hertz)
F1 = 700; F2 = 2000; % F1 in (700-1000 Hz), F2 in (2000-3000 Hz)

% Sampling frequency (samples per second)
fs = max(F1, F2) * 2; % minimum - Shannon [Hz]

% Time needed for simulation
dt = 1/fs; % seconds per sample
StopTime = (s_2 + frame * dt) / velocity;
t = 0:dt:(StopTime + s_2 * dt - dt);

% TimeShift for sensors
[ts1, ts2] = GetLeakTimeShift(s_1, s_2, leak, velocity);

% Generate signal
S = GenerateCompositeSignal(F1, F2, t);

% Initialize receivers
[S_1, S_2] = InitializeReceiverSignals(S, t, ts1, ts2, dt);

% Cut out Leading Zeros
[S_1, S_2, ~] = CutZeros(S_1, S_2, t);

%% Initialize Bunch of Stuff

% Lists for iterations
noises = [80, 60, 40, 20, 10, 0, -10, -20, -40, -60, -80];
leaks = [200, 400, 600, 800, 1000, 1200, 1400];

% Results from Time Domain Computation
resultTD = zeros(1, 0); durationTD = zeros(1, 0);

% Results from Frequency Domain Computation
resultFD = zeros(1, 0); durationFD = zeros(1, 0);

%% Correlation method leak detection

% And now this thing with dBs
for noise = noises
    
    % Additional noise to the signals
    SS_1 = awgn(S_1(1, :), noise, 'measured');
    SS_2 = awgn(S_2(1, :), noise, 'measured');
    
    %%
    % Initialize Time Counter for Time Domain Computations
    tic;
    
    % Compute Correlation in Time Domain
    R = GetCorrelation(SS_1, SS_2, (StopTime / dt), frame);
    
    % Compute Leak Position
    leakTD = GetLeakPosition(R, s_1, s_2, dt, velocity);
    
    % End Time Counter for Time Domain Computations
    tocTD = toc;
    
    %%
    % Initialize Time Counter for Frequency Domain Computations
    tic;
    
    % Compute Correlation in Frequency Domain
    Rf = GetCorrelationFourier(SS_1, SS_2);
    
    % Compute Leak Position in Frequency Domain
    leakFD = GetLeakPositionFourier(Rf, s_1, s_2, dt, velocity, leak);
    
    % End Time Counter for Frequency Domain Computations
    tocFD = toc;
    
    % Create Columns with Results
    resultTD = [resultTD; leakTD]; %#ok<AGROW>
    resultFD = [resultFD; leakFD]; %#ok<AGROW>
    durationTD = [durationTD; tocTD]; %#ok<AGROW>
    durationFD = [durationFD; tocFD]; %#ok<AGROW>
    
end

% And Create Result Table
CMTable = table(noises', resultTD, resultFD, durationTD, durationFD);

% Format table
CMTable.Properties.VariableNames = {'dB', 'LeakTime', 'LeakFreq',...
                                    'DurationTime', 'DurationFreq'};

%% Leakage placement to signal/dB ratio

LPTableTime = zeros(length(leaks), length(noises));
LPTableFreq = zeros(length(leaks), length(noises));

% Initilize indice
i = 1;

for leak = leaks
    
    % TimeShift for signals s_1 and s_2
    [ts1, ts2] = GetLeakTimeShift(s_1, s_2, leak, velocity);
    
    % Initilize indice
    j = 1;
    
    for noise = noises
        
        % Initialize receivers
        [S_1, S_2] = InitializeReceiverSignals(S, t, ts1, ts2, dt);
        
        % Cut out Leading Zeros
        [S_1, S_2, ~] = CutZeros(S_1, S_2, t);
        
        % Additional noise to the signals
        SS_1 = awgn(S_1(1, :), noise, 'measured');
        SS_2 = awgn(S_2(1, :), noise, 'measured');
        
        %%
        % Compute Correlation in Time Domain
        R = GetCorrelation(SS_1, SS_2, (StopTime / dt), frame);
        
        % Compute Leak Position
        leakTD = GetLeakPosition(R, s_1, s_2, dt, velocity);
        
        %%
        % Compute Correlation in Frequency Domain
        Rf = GetCorrelationFourier(SS_1, SS_2);
    
        % Compute Leak Position in Frequency Domain
        leakFD = GetLeakPositionFourier(Rf, s_1, s_2, dt, velocity, leak);
        
        % Leakage placement to signal/dB ratio
        if isempty(leakTD); leakTD = 0; end
        LPTableTime(i, j) = leakTD; LPTableFreq(i, j) = leakFD;
        
        % Update Indices
        j = j + 1;
    end
    
    % Update Indices
    i = i + 1;
end

% Convert arrays to tables
LPTableTime = array2table(LPTableTime);
LPTableFreq = array2table(LPTableFreq);

% Format Tables
LPTableTime.Properties.VariableNames = {'dB80', 'dB60', 'dB40', 'dB20',...
                                        'dB10', 'dB0', 'dBm10', 'dBm20',...
                                        'dBm40', 'dBm60', 'dBm80'};
LPTableFreq.Properties.VariableNames = {'dB80', 'dB60', 'dB40', 'dB20',...
                                        'dB10', 'dB0', 'dBm10', 'dBm20',...
                                        'dBm40', 'dBm60', 'dBm80'};

%% Results

% Results are saved in the tables CMTable, LPTableTime and LPTableFreq

% End of Script
