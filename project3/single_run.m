%% Runs prisoner_spatial.m
% 

%% System and simulation parameters
% Rewards
T = 1.9;
R = 1;
P = 0;
S = 0;

% size, length and cooperator density
L = 200;
steps = 200;
p = 0.1;

rewards = [R S T P];
[dens, grid] = prisoner_spatial(rewards, L, steps, p, true, true);