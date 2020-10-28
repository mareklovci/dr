%% KKY/DR Hypothesis Testing

% Clear Sequence
clear all, close all %#ok<CLALL>

% Wait 0.01s (sometimes, clear all does not delete everything)
pause(0.01)

%% Generate Measurements

% Lambda function to make things easier
measurement = @(mean, var, samples) normrnd(mean, sqrt(var), [samples, 1]);

% Generate measurements A, B and C
A = measurement(0, 4, 2000);
B = measurement(0.1, 4, 2000);
C = measurement(1, 4, 2000);

%% Generate file with measurements

% Generate CSV file with semicolon delimiter
dlmwrite('measurements.csv', [A, B, C], 'delimiter', ';', 'precision', '%.4f');

%% Initialize subset sizes

sizes = [5, 10, 20, 50, 100, 200, 500, 1000, 2000];

%% Initialize result matrices

% One-sided t-test hypothesis & p-value
H1 = zeros(length(sizes), 3); P1 = zeros(length(sizes), 3);

% Double-sided t-test hypothesis & p-value
H2 = zeros(length(sizes), 3); P2 = zeros(length(sizes), 3);

%% Experiments

for s = 1:length(sizes)
    
    % Just define alpha (needed for some reason), default from docs
    alpha = 0.05;
    
    % Mean Equality performed by double-sided unpaired two-sample t-test
    [H2(s, 1), P2(s, 1)] = ttest2(A(1:sizes(s)), B(1:sizes(s))); % AB
    [H2(s, 2), P2(s, 2)] = ttest2(A(1:sizes(s)), C(1:sizes(s))); % AC
    [H2(s, 3), P2(s, 3)] = ttest2(B(1:sizes(s)), C(1:sizes(s))); % BC
    
    % Mean Relationship? performed by one-sided unpaired two-sample t-test
    [H1(s, 1), P1(s, 1)] = ttest2(A(1:sizes(s)), B(1:sizes(s)), 'alpha', alpha, 'tail', 'right');
    [H1(s, 2), P1(s, 2)] = ttest2(A(1:sizes(s)), C(1:sizes(s)), 'alpha', alpha, 'tail', 'right');
    [H1(s, 3), P1(s, 3)] = ttest2(B(1:sizes(s)), C(1:sizes(s)), 'alpha', alpha, 'tail', 'right');
    
end

%% Results

% Plot 1
figure; plot(sizes, P1);
ylabel('p-value'); xlabel('Number of Samples');
legend("(A', B')", "(A', C')", "(B', C')");
title('p-value of one-sided t-test to Number of Samples');
saveas(gcf, 'fig1', 'epsc')

% Plot 2
figure; plot(sizes, P2);
ylabel('p-value'); xlabel('Number of Samples');
legend("(A', B')", "(A', C')", "(B', C')");
title('p-value of double-sided t-test to Number of Samples');
saveas(gcf, 'fig2', 'epsc')

% End of Script
