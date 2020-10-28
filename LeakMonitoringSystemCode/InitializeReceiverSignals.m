function [out1, out2] = InitializeReceiverSignals(S, t, ts1, ts2, dt)
%INITIALIZERECEIVERSIGNALS Initialize receivers
%   Initialize receivers with account for the time shift of the sensors
% Inputs:
%   S   : Composite Signal
%   t   : Time vector
%   ts1 : Time Shift for sensor 1 as given in the assignment
%   ts2 : Time Shift for sensor 2 as given in the assignment
%   dt  : Time difference
%
% Outputs:
%   out1 : Received Signal from Sensor 1
%   out2 : received Signal from Sensor 2

% Initialize some zero vectors
out1 = zeros(1, length(t)); out2 = zeros(1, length(t));

% Define where to start
begin1 = (ts1 / dt) + 1; begin2 = (ts2 / dt) + 1;

% Return receivers signals
out1(begin1:end) = S(1, 1:(length(t) - begin1 + 1));
out2(begin2:end) = S(1, 1:(length(t) - begin2 + 1));

end

