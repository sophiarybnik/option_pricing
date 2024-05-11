function V0 = Eur_Call_LVF_FD(S0, K, T, r, x, Smax, M, N)
    % Price the European call option of the LVF model by the Finite Difference method
    %
    % Input
    % S0 – initial stock price
    % K – strike price
    % T – maturity
    % r – risk free interest rate
    % x – vector parameters for the LVF σ, [x1, x2, x3]
    % Smax - maximum price of the discretized underlying
    % M – number of discrete underlying price steps
    % N – number of discrete time steps, i.e., δt = T /N.
    %
    % Output
    % V0 – European call option price at t = 0 and S0.

    % local volatility function
    local_sig = @(x, S) max(0.0, x(1)+x(2)*S+x(3)*S.^2);

    % time step
    dt=T/(N-1);
    dS=Smax/(M-1);

    % time discretization
    t=linspace(0, T, N)';

    % vector of evenly spaced stock prices from 0 to 3
    S=linspace(0, Smax, M)';
    
    V=zeros(M,N); % define matrix of option values for M stock prices at N points in time
    

    payoff = max(S-K, 0);  
    V(:, 1)= payoff; % initial condition- exercise value at maturity
    % minimum and maximum price (boundary conditions)
    % V(1,:) = 0  -- when stock price is zero -- already specified by grid initialization of all zeros
    V(M,:)=(Smax -K)./(1-r*t); 

   
    A=zeros(M, M);
    for i=2:M-1 
        sigma = local_sig(x, S(i)); % compute volatility for each point in time and stock price
        C=0.5*(sigma*S(i)/dS)^2;
        D=(r*S(i))/(2*dS);
    
        % central diff
        alpha=C-D;
        beta=C+D;
    
        % upstream weighting for positive coefficient discretization
        if alpha < 0 
            alpha = C;
            beta = C+2*D;
        end
        
        A(i,i) = -alpha - beta - r;
        A(i, i-1) = alpha;
        A(i, i+1) = beta; 
    end
    
    [L U] = lu(eye(M) - dt*A); % LU factorization
    B = U\(L\eye(M));
    
    % forward fill the price matrix
    for n=2:N
        V(:, n) = B*V(:, n-1);
    end
    
    % interpolate price at t = 0 and S0
    V0=interp1(S, V(:,N), S0);
end


