function Param = InitialGuess(Data)

Param = struct();

% Get Data Centers from k-means
X = Data(:, 1:2); [~, C] = kmeans(X,2);
Param.mu1 = C(2, :); Param.mu2 = C(1, :);

% Sigmas
Param.sigma1 = eye(2); Param.sigma2 = eye(2);

% Lambda
Param.lambda = [0.4, 0.6];

end