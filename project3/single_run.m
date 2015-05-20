close all hidden

T = 1.3;
R = 1;
P = 0;
S = 0;

L = 400;
steps = 5;
p = 0.1;

rewards = [R S T P];
[dens, grid] = prisoner_spatial(rewards, L, steps, p, true);