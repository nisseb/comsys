close all hidden

T = 1.9;
R = 1;
P = 0;
S = 0;

L = 199;
steps = 500;
p = 0.1;

rewards = [R S T P];
[dens, grid] = prisoner_spatial(rewards, L, steps, p, true, true);