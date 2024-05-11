function [x, resnorm] = calibrate_parameters(x0)
    options = optimoptions('lsqnonlin','SpecifyObjectiveGradient',true);
    options.Algorithm = 'levenberg-marquardt';
    options.Display = 'iter';
    lb = [0,0,0];
    ub = [];
    [x,resnorm,residual,exitflag,output] = lsqnonlin(@myfun,x0,lb,ub,options);  
end
