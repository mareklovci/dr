function Param = maximization(Data, Param)
%MAXIMIZATION Calculate Maximization Step
%   Updates Gaussian Distribution Parameters according to the new labeled
%   dataset
% Inputs :
%   Data : New Data [x, y, label]
%   Param: Old Params (mu, sigma, lambda)
%
% Outputs:
%   Param: Updated Parameters

% Points in Cluster
Pic1 = Data(Data(:,3) == 1,:); Pic2 = Data(Data(:,3) == 2,:);

% Calculate Weights (% of points in All Data)
weight1 = size(Pic1,1) / size(Data,1);
weight2 = 1 - weight1;

% Assign Weights
Param.lambda = [weight1, weight2];

% Calculate the Means
Param.mu1 = [mean(Pic1(:,1)), mean(Pic1(:,2))];
Param.mu2 = [mean(Pic2(:,1)), mean(Pic2(:,2))];

% Calculate the Variances
Param.sigma1 = [std(Pic1(:,1)) 0; 0 std(Pic1(:,2))];
Param.sigma2 = [std(Pic2(:,1)) 0; 0 std(Pic2(:,2))];

end