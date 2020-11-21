function Data = expectation(Data, Param)
%EXPECTATION Calculate Expectation Step
%   Get Probability of each Data Point that it belongs to class
% Inputs :
%   Data : Data [x, y, label]
%   Param: Parameters (mu, sigma, lambda)
%
% Outputs:
%   Data : the Dataset with Updated Labels

for i = 1: size(Data, 1)
    x = Data(i, 1:2);
    p_cluster1 = prob(x, Param.mu1, Param.sigma1, Param.lambda(1,1));
    p_cluster2 = prob(x, Param.mu2, Param.sigma2, Param.lambda(1,2));
    
    if p_cluster1 > p_cluster2
        Data(i, 3) = 1;
    else
        Data(i, 3) = 2;
    end
end

end
