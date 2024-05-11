function V = Eur_Call_LVF_MC(S0, K, T, r, x, M, N)
    % Price the European call option of the LVF model by the Monte Carlo method
    %
    % Input
    % S0 – initial stock price
    % K – strike price
    % T – maturity
    % r – risk free interest rate
    % x – vector parameters for the LVF σ, [x1, x2, x3]
    % M – number of simulated paths
    % N – number of time steps, i.e., δt = T /N.
    %
    % Output
    % V – European call option price at t = 0 and S0.

    dt = T/N; % time step
    S0 = ones(M,1); % create vector of initial stock price (for each simulation)

    % Antithetic Sampling method
    S1 = zeros(M,N); % sample 1, stock price matrix for M simulations at each point in time
    S2 = zeros(M,N); % sample 2, price matrix for M simulations at each point in time

    
    % local volatility function
    local_sig = @(x, S) max(0.0, x(1)+x(2).*S+x(3).*S.^2);
    
    % simulate stock price using euler-maruyama scheme
    sig = local_sig(x,S0); % calculate initial volatility
    Z = sqrt(dt)*randn(M,N); %standard normal distribution mean 0, sigma 1
    
    S1(:,1) = S0.*exp((r - sig.^2./2)*dt + sig.*Z(:,1)); % sample 1, initial stock price at time = 0 and initial local volatility
    S2(:,1) = S0.*exp((r - sig.^2/2)*dt - sig.*Z(:,1)); % sample 2, initial stock price at time = 0 and initial local volatility

    
    for k = 2:N
        sig1 = local_sig(x,S1(:,k-1)); % local volatility, sample 1
        S1(:,k) = S1(:,k-1).*exp((r - sig1.^2/2)*dt + sig1.*Z(:,k)); % simulated stock price at time t, sample 1

        sig2 = local_sig(x,S2(:,k-1)); % local volatility, sample 2
        S2(:,k) = S2(:,k-1).*exp((r - sig2.^2/2)*dt + sig2.*Z(:,k)); % simulated stock price at time t, sample 2
    end
    
    payoff1=max(S1(:,end) - K, 0); % payoff, sample 1
    payoff2=max(S2(:,end) - K, 0); % payoff, sample 2
    payoff = (payoff1+payoff2)/2;
    V_N = mean(payoff,2); % row wise average payoff for each simulation 
    V = exp(-r*dt)*mean(V_N); % option value discounted to today
end

