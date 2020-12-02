%% KKY/DR Gaussian Mixture Parameters

% Clear Sequence
clear all, close all %#ok<CLALL>

% Wait 0.01s (sometimes, clear all does not delete everything)
pause(0.01)

%% Import Data

Data = importdata('sp4_data.mat');
x = Data(:, 1); y = Data(:, 2);

%% Plot Input Data

figure; plot(x, y, '.');
title('Input Data'); xlabel('x'); ylabel('y');

% Save figure
% saveas(gcf, 'fig1', 'epsc')

%% MATLAB EM Results

% Fit Model
GMModel = fitgmdist(Data, 2);

% Assign Points to Clusters
idx = cluster(GMModel, Data);

% Plot Them All!
figure; h = gscatter(x, y, idx, 'rg','+o',5); hold on;
gmPDF = @(x,y) arrayfun(@(x0,y0) pdf(GMModel,[x0 y0]),x,y);
g = gca; fcontour(gmPDF,[g.XLim g.YLim]);
title('{\bf Scatter Plot and Fitted Gaussian Mixture Contours}')
legend(h,'Model0','Model1'); hold off;

% Save figure
% saveas(gcf, 'fig2', 'epsc')

%% Custom EM

% number of points in each cluster
num_points = length(Data); 

% make some initial guess
Param = InitialGuess(Data);

%% run EM to find the parameters 

% Preallocate result vectors
errors = zeros(5, 1); lambdas = zeros(5, 2);

% Something large to begin with, counter & precision
error = 10000; iter = 0; epsilon = 0.001;

% Output Table format text
formatSpec = 'iteration: %d, error: %2.4f, mu1: [%2.4f %2.4f], mu2: [%2.4f %2.4f], lambda1: %2.4f, lambda2: %2.4f \n';

while error > epsilon
    iter = iter + 1;

    %% Expectation Step
    Data_ = expectation(Data, Param);
    
    %% Maximization Step
    Param_ = maximization(Data_, Param);
    
    %% Calculate the Error From the Previous Params
    % error = norm(Param.mu1 - Param_.mu1) + norm(Param.mu2 - Param_.mu2);
    error = norm(Param.mu1 - Param_.mu1) * Param_.lambda(1) + ...
            norm(Param.mu2 - Param_.mu2) * Param_.lambda(2);
    
    % Print table
    fprintf(formatSpec, iter, error, Param_.mu1, Param_.mu2,...
        Param_.lambda(1), Param_.lambda(2));    

    % Just Assign Variables
    errors(iter) = error; Data = Data_; Param = Param_;
    
    % Let's Clean Up
    clear Data_ Param_
end

%% Plot the Custom Alg Results

Data(:, 3) = changem(Data(:,3), [1 2], [2 1]);
figure; h = gscatter(Data(:,1), Data(:,2), Data(:,3), 'rg', '+o', 5);
title('Custom EM Results'); xlabel('x'); ylabel('y');
legend(h, 'Model0', 'Model1');

% Save figure
% saveas(gcf, 'fig3', 'epsc')

%% Plot Error Curve

figure; plot(1:iter, errors, '.-'); title('Error to Iteration No');
xlabel('Iteration No'); ylabel('||\lambda_i - \lambda_{i - 1}||_2');

% Save figure
% saveas(gcf, 'fig4', 'epsc')

% End of Script
