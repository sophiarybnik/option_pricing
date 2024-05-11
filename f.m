function F = f(x)
    % Objective function- a vector of model option value errors from the market prices
    %
    % Input
    % x - parameters of local quadratic local volatility model
    %
    % Output
    % F – objective function evaluated at x

    V0_mkt = [0.3570, 0.2792, 0.2146, 0.1747, 0.1425, 0.1206, 0.0676]; % observed market option prices
    K = [0.80, 0.85, 0.90, 0.95, 1.00, 1.05, 1.10]; % respective strike prices
    T = 3/12; % time to expiry
    S0 = 1; % initial price of underlying
    r = 0.03; % risk-free rate
    M = 10000; % number of simulated paths
    N = 100; % number of time steps, i.e., δt = T /N.

    V0_mc = zeros(length(K),1); 
    for i=1:length(K)
        % calculate option price (via monte carlo method) for each given
        % strike price
        V0_mc(i) = Eur_Call_LVF_MC(S0, K(i), T, r, x, M, N);
    end
    % difference between observed and computed option prices
    F = V0_mc-V0_mkt';
end