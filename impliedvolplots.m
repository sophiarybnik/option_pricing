function impliedvolplots(x)
        S0 = 1; 
        T = 0.25;
        r = 0.03;
        M = 10000;
        N = 100;
        
        V0_mkt = [0.3570, 0.2792, 0.2146, 0.1747, 0.1425, 0.1206, 0.0676]; % observed market option prices
        K = [0.80, 0.85, 0.90, 0.95, 1.00, 1.05, 1.10]; % respective strike prices

        l = length(K);
        V0 = zeros(1,l);
        for i=1:l
        % monte carlo method
            V0(i) = Eur_Call_LVF_MC(S0, K(i), T, r, x, M, N);
        end
    
        implied_vol_mkt = blsimpv(S0,K,r,T,V0_mkt);
        implied_vol_mc = blsimpv(S0,K,r,T,V0);
    
    
        figure()
        subplot(2,1,1);
        plot(K,V0_mkt)
        hold on 
        plot(K,V0)
        title("European Call Options with time to maturity = 0.25 years and risk-free rate = 3%")
        xlabel("Strike Price")
        ylabel("Option Price")
        legend('Market Data', 'Local Volatility Model: Monte Carlo Method')
        hold off
    
        subplot(2,1,2);
        plot(K,implied_vol_mkt)
        hold on 
        plot(K,implied_vol_mc)
        title("Implied Volatility")
        xlabel("Strike Price")
        ylabel("Implied Volatility")
        legend('Market Data', 'Local Volatility Model: Monte Carlo Method')
        hold off        
end

