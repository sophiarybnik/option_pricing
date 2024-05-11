function F = objective_function(x)
    V0_mkt = [0.3570, 0.2792, 0.2146, 0.1747, 0.1425, 0.1206, 0.0676]; % initial market prices
    K = [0.80, 0.85, 0.90, 0.95, 1.00, 1.05, 1.10]; % respective strike prices
    T = 3/12; % time to expiry
    S0 = 1;
    r = 0.03;
    M = 10000;
    N = 100;
    % evaluate function F at x
    V0_mc = zeros(length(K),1); % initialize space for V0 values
    for i=1:length(K)
        V0_mc(i) = Eur_Call_LVF_MC(S0, K(i), T, r, x, M, N);
    end
    F = V0_mc-V0_mkt';
end