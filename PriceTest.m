clear;
clc;

% define parameters
S0 = 1; 
K = 1;
T = 0.25;
r = 0.03;
x = [0.2, 0.001, 0.003];
M_mc = 10000;
M_fd = 30;
N = 100;
Smax=3;

% monte carlo method
V0_mc = Eur_Call_LVF_MC(S0, K, T, r, x, M_mc, N)

% finite difference method
V0_fd = Eur_Call_LVF_FD(S0, K, T, r, x, Smax, M_fd, N)

